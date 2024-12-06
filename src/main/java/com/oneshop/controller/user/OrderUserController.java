package com.oneshop.controller.user;
import java.lang.reflect.InvocationTargetException;
import java.nio.file.Path;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oneshop.entity.Cart;
import com.oneshop.entity.CartItem;
import com.oneshop.entity.Category;
import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.Store;
import com.oneshop.entity.User;
import com.oneshop.model.ProductModel;
import com.oneshop.model.UserModel;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.ICategoryService;
import com.oneshop.service.IOrderItemService;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IStoreService;
import com.oneshop.service.IUserService;

@Controller
@RequestMapping("/user/order")
public class OrderUserController {
    @Autowired
    IUserService userService;
    @Autowired
    IProductService productService;
    @Autowired
    ICartItemService cartItemService;
    @Autowired
    ICartService cartService;
    @Autowired
    ICategoryService categoryService;
    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    IOrderService orderService;
    @Autowired
    IStoreService storeService;

    @RequestMapping("")
    public String order(ModelMap model, HttpServletRequest request) {
        // model.addAttribute("user", new UserModel());
        User user = (User) request.getSession().getAttribute("user");
        double price = 0;
        List<Cart> carts = cartService.findByUserId(user.getId());
        List<CartItem> listItem = new ArrayList<>();
        for (Cart cart : carts) {
            List<CartItem> cartItems = cartItemService.findByCartId(cart.getId());
            for (CartItem cartItem : cartItems) {
                listItem.add(cartItem);
            }
        }
        for (CartItem cartItem : listItem) {
            price += cartItem.getCount() * cartItem.getProduct().getPrice();
        }
        model.addAttribute("listcart", listItem);
        model.addAttribute("price", price);

        return "user/orderItem/order";
    }

    @PostMapping("{price}")
    public ModelAndView order(ModelMap model, /* @RequestParam(name = "fullname", required = false) String fullname, */
                              @RequestParam(name = "address", required = false) String address,
            /*
             * @RequestParam(name = "phuong", required = false) String phuong,
             *
             * @RequestParam(name = "quan", required = false) String quan,
             *
             * @RequestParam(name = "thanhpho", required = false) String thanhpho,
             */
                              @RequestParam(name = "phone", required = false) String phone, HttpServletRequest request,
                              @PathVariable("price") Float price) {
        User user = (User) request.getSession().getAttribute("user");
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        Order order = new Order();

        Store store = storeService.getById(33);
        order.setAddress(address);
        order.setPhone(phone);
        order.setUser(user);
        order.setCreateat(date);
        order.setDelivery(null);
        order.setStatus("cho xac nhan");
        order.setStore(store);
        order.setUpdateat(null);
        order.setPrice(price);
        if (order.getAddress() == null || order.getPhone() == null) {
            System.out.println("AAA");
            return new ModelAndView("redirect:/user/order", model);
        }
        orderService.save(order);

        return new ModelAndView("redirect:/user/order", model);
    }
}