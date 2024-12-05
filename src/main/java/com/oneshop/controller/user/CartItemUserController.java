package com.oneshop.controller.user;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import java.util.stream.Collectors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.entity.Cart;
import com.oneshop.entity.CartItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.User;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.IProductService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/cart/item")
public class CartItemUserController {

	@Autowired
	ICartItemService cartItemService;

	@Autowired
	IProductService productService;

	@Autowired
	ICartService cartService;

	@Autowired
	ServletContext application;

	@Autowired
	private Cloudinary cloudinary;
	@GetMapping("")
	public ModelAndView list(ModelMap model, HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}

		double totalPrice = 0;
		List<Cart> carts = cartService.findByUserId(user.getId());
		List<CartItem> listItem = new ArrayList<>();

		for (Cart cart : carts) {
			List<CartItem> cartItems = cartItemService.findByCartId(cart.getId());
			for (CartItem cartItem : cartItems) {
				List<String> imageUrls = cartItem.getProduct().getImages()
						.stream()
						.map(image -> cloudinary.url().publicId(image.getImageUrl()).generate())
						.collect(Collectors.toList());
				cartItem.getProduct().setImageUrls(imageUrls);
				listItem.add(cartItem);
			}
		}

		for (CartItem cartItem : listItem) {
			totalPrice += cartItem.getCount() * cartItem.getProduct().getPrice();
		}

		model.addAttribute("listcart", listItem);
		model.addAttribute("totalPrice", totalPrice);

		return new ModelAndView("/user/cartItem/shopping_cart", model);
	}


	@GetMapping("add/{id}/{count}")
	public String addtoCart(ModelMap model, HttpServletRequest request, @PathVariable("count") String num,
							@PathVariable("id") Integer id) {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}

		List<Cart> carts = cartService.findByUserId(user.getId());
		long millis = System.currentTimeMillis();
		Date date = new Date(millis);

		if (carts.isEmpty()) {
			Cart cart = new Cart();
			cart.setCreateat(date);
			cart.setUser(user);
			cartService.save(cart);
		}

		// Lấy giỏ hàng sau khi đã đảm bảo tồn tại
		carts = cartService.findByUserId(user.getId());
		Product product = productService.getById(id);
		CartItem thisItem = null;

		// Kiểm tra sản phẩm đã có trong giỏ hàng hay chưa
		for (Cart cart : carts) {
			List<CartItem> cartitems = cartItemService.findByCartId(cart.getId());
			for (CartItem cartitem : cartitems) {
				if (cartitem.getProduct().getId().equals(id)) {
					thisItem = cartitem;
					break;
				}
			}
		}

		// Nếu đã có, tăng số lượng
		if (thisItem != null) {
			thisItem.setCount(thisItem.getCount() + Integer.parseInt(num));
			thisItem.setUpdateat(date);
		} else {
			// Nếu chưa có, thêm sản phẩm mới vào giỏ hàng
			thisItem = new CartItem();
			thisItem.setCount(Integer.parseInt(num));
			thisItem.setCreateat(date);
			thisItem.setUpdateat(null);
			thisItem.setCart(carts.get(0));
			thisItem.setProduct(product);
		}

		cartItemService.save(thisItem);

		return "redirect:/user/cart/item";
	}


	@GetMapping("delete/{id}")
	public ModelAndView deletetoCart(ModelMap model, @PathVariable("id") Integer id) {
		cartItemService.deleteById(id);
		model.addAttribute("message", "Xóa thành công");
		return new ModelAndView("redirect:/user/cart/item", model);
	}
	@GetMapping("update/{id}/{count}")
	public String updatetoCart(ModelMap model, HttpServletRequest request, @PathVariable("count") String num,
							   @PathVariable("id") Integer id) {
		long millis = System.currentTimeMillis();
		Date date = new Date(millis);

		CartItem cartitem = cartItemService.getById(id);
		cartitem.setCount(Integer.parseInt(num));
		cartitem.setUpdateat(date);
		cartItemService.save(cartitem);

		return "redirect:/user/cart/item";
	}

}
