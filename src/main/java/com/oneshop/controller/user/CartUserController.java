package com.oneshop.controller.user;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.oneshop.entity.Cart;
import com.oneshop.entity.CartItem;
import com.oneshop.entity.Inventory;
import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IUserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RestController
@RequestMapping("/user/cart")
public class CartUserController {

    @Autowired
    private ICartService cartService;

    @Autowired
    private ICartItemService cartItemService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private IOrderItemService orderItemService;
    @Autowired
    private IProductService productService;
    
    @Autowired
    private Cloudinary cloudinary;

    @GetMapping("")
    public ModelAndView viewCartGroupedByStore(ModelMap model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        List<Cart> carts = cartService.findByUserId(user.getId());
        Map<Store, List<CartItem>> storeGroupedCartItems = new LinkedHashMap<>();

        for (Cart cart : carts) {
            List<CartItem> cartItems = cartItemService.findByCartId(cart.getId());

            for (CartItem cartItem : cartItems) {
                Product product = cartItem.getProduct();
                List<String> imageUrls = product.getImages().stream()
                        .map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
                        .collect(Collectors.toList());
                product.setImageUrls(imageUrls);

                int availableStock = product.getInventories().stream()
                        .mapToInt(Inventory::getQuantity)
                        .sum();
                
                product.setQuantity(availableStock);
                
                Store store = product.getStore();
                storeGroupedCartItems.computeIfAbsent(store, k -> new ArrayList<>()).add(cartItem);
            }
        }
        Map<Store, Double> storeTotals = new HashMap<>();
        storeGroupedCartItems.forEach((store, cartItems) -> {
            double total = cartItems.stream()
                    .mapToDouble(item -> item.getCount() * item.getProduct().getPrice())
                    .sum();
            storeTotals.put(store, total);
        });
        model.addAttribute("storeGroupedCartItems", storeGroupedCartItems);
        model.addAttribute("storeTotals", storeTotals);

        return new ModelAndView("/user/cart/cart", model);
    }


    @PostMapping("/add/{id}")
    public ModelAndView addToCart(
            @PathVariable("id") Integer id, 
            @RequestParam("quantity") Integer quantity, 
            ModelMap model, 
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/login"); 
        }

        List<Cart> carts = cartService.findByUserId(user.getId());
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        if (carts.isEmpty()) {
            Cart cart = new Cart();
            cart.setCreateat(date);
            cart.setUser(user);
            cartService.save(cart);
            carts = cartService.findByUserId(user.getId());
        }

        Product product = productService.getById(id);
        if (product == null) {
            throw new IllegalArgumentException("Sản phẩm không tồn tại."); 
        }
        Store store = product.getStore(); 
        CartItem thisItem = null;
        for (Cart cart : carts) {
            List<CartItem> cartItems = cartItemService.findByCartId(cart.getId());
            for (CartItem cartItem : cartItems) {
                if (cartItem.getProduct().getId().equals(id)) {
                    thisItem = cartItem;
                    break;
                }
            }
            if (thisItem != null) break;
        }

        if (thisItem != null) {
            thisItem.setCount(thisItem.getCount() + quantity);
            thisItem.setUpdateat(date);
        } else {
            thisItem = new CartItem();
            thisItem.setCount(quantity);
            thisItem.setCreateat(date);
            thisItem.setUpdateat(null);  
            thisItem.setCart(carts.get(0)); 
            thisItem.setProduct(product);
        }
        Cart cart = carts.get(0);
        cartService.save(cart); 
        cartItemService.save(thisItem);
        updateCartModel(model, request);
        model.addAttribute("updateCartCount", true);
        redirectAttributes.addFlashAttribute("message", "Sản phẩm đã được thêm vào giỏ hàng");
        return new ModelAndView("redirect:/user/cart", model);
    }

    private void updateCartModel(ModelMap model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            List<Cart> carts = cartService.findByUserId(user.getId());
            if (!carts.isEmpty()) {
                Cart cart = carts.get(0); 
                List<CartItem> cartItems = cartItemService.findByCartId(cart.getId());
                model.addAttribute("cartItems", cartItems);
                model.addAttribute("cart", cart);
            }
        }
    }

    
    @GetMapping("delete/{id}")
	public ModelAndView deletetoCart(ModelMap model, @PathVariable("id") Integer id) {
		cartItemService.deleteById(id);
		model.addAttribute("message", "Xóa thành công");
		 model.addAttribute("updateCartCount", true);
		return new ModelAndView("redirect:/user/cart", model);
	}
    
    @PostMapping("/update")
    @ResponseBody
    public Map<String, Object> updateCartItem(@RequestBody Map<String, Object> requestBody) {
        Map<String, Object> response = new HashMap<>();

        try {
            if (requestBody == null || requestBody.isEmpty()) {
                response.put("error", "Dữ liệu không hợp lệ.");
                return response;
            }
            Integer itemId = (Integer) requestBody.get("itemId");
            Integer count = (Integer) requestBody.get("count");
            if (itemId == null || count == null || count < 1) {
                response.put("error", "ID sản phẩm hoặc số lượng không hợp lệ.");
                return response;
            }
            CartItem cartItem = cartItemService.getById(itemId);
            if (cartItem == null) {
                response.put("error", "Không tìm thấy sản phẩm trong giỏ hàng.");
                return response;
            }
            cartItem.setCount(count);
            cartItem.setUpdateat(new Date(System.currentTimeMillis()));
            cartItemService.save(cartItem);
            response.put("success", true);
            response.put("message", "Cập nhật thành công.");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("error", "Đã xảy ra lỗi trong quá trình cập nhật: " + e.getMessage());
        }

        return response;
    }

    @GetMapping("/total")
    @ResponseBody
    public Map<String, Object> getCartTotal(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                response.put("error", "Người dùng chưa đăng nhập.");
                return response;
            }

            List<CartItem> cartItems = cartItemService.findByUserId(user.getId());
            double total = cartItems.stream()
                    .mapToDouble(item -> item.getCount() * item.getProduct().getPrice())
                    .sum();

            response.put("total", total);
            response.put("success", true);
        } catch (Exception e) {
            response.put("error", "Lỗi khi tính tổng tiền: " + e.getMessage());
        }
        return response;
    }
    @PostMapping("/saveTotal")
    @ResponseBody
    public ResponseEntity<?> saveCartTotal(@RequestBody Map<String, Object> requestBody, HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                     .body(Map.of("error", "Người dùng chưa đăng nhập."));
            }
            Number totalNumber = (Number) requestBody.get("total");
            if (totalNumber == null || totalNumber.doubleValue() <= 0) {
                return ResponseEntity.badRequest()
                                     .body(Map.of("error", "Tổng tiền không hợp lệ."));
            }
            Double total = totalNumber.doubleValue();
            List<Map<String, Object>> selectedItems = (List<Map<String, Object>>) requestBody.get("selectedItems");
            if (selectedItems == null || selectedItems.isEmpty()) {
                return ResponseEntity.badRequest()
                                     .body(Map.of("error", "Không có sản phẩm nào được chọn."));
            }
            Order order = new Order();
            order.setUser(user);
            order.setPrice(total.floatValue());
            order.setPhone(user.getPhone());
            order.setCreateat(java.time.LocalDateTime.now());
            order.setStatus("Waiting");
            orderService.save(order);
            for (Map<String, Object> item : selectedItems) {
                try {
                    String productIdStr = (String) item.get("productId");
                    if (productIdStr == null) {
                        return ResponseEntity.badRequest()
                                             .body(Map.of("error", "ID sản phẩm không hợp lệ."));
                    }
                    Integer productId = null;
                    try {
                        productId = Integer.parseInt(productIdStr);  
                    } catch (NumberFormatException e) {
                        return ResponseEntity.badRequest()
                                             .body(Map.of("error", "ID sản phẩm không hợp lệ."));
                    }

                    Product product = productService.getById(productId);
                    if (product != null) {
                        OrderItem orderItem = new OrderItem();
                        orderItem.setOrder(order);
                        orderItem.setProduct(product);
                        orderItem.setCount((Integer) item.get("quantity"));
                        orderItem.setCreateat(java.time.LocalDateTime.now());
                        orderItemService.save(orderItem);
                    } else {
                        return ResponseEntity.badRequest()
                                             .body(Map.of("error", "Không tìm thấy sản phẩm với ID: " + productId));
                    }
                } catch (Exception e) {
                    return ResponseEntity.badRequest()
                                         .body(Map.of("error", "Lỗi xử lý sản phẩm: " + e.getMessage()));
                }
            }

            return ResponseEntity.ok(Map.of("success", "Lưu đơn hàng thành công!"));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("error", "Lỗi khi lưu đơn hàng: " + e.getMessage()));
        }
    }

    @GetMapping("/count")
    @ResponseBody
    public int getCartItemCount(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return 0; 
        }
        return cartService.getCartItemCountByUserId(user.getId());
    }



}

