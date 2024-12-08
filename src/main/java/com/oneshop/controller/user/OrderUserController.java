package com.oneshop.controller.user;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oneshop.entity.Cart;
import com.oneshop.entity.CartItem;
import com.oneshop.entity.User;
import com.oneshop.service.ICartItemService;
import com.oneshop.service.ICartService;
import com.oneshop.service.IOrderService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/order")
public class OrderUserController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private ICartService cartService;

    @Autowired
    private ICartItemService cartItemService;

    @RequestMapping("")
    public String order(ModelMap model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Cart> carts = cartService.findByUserId(user.getId());
        List<CartItem> listItem = new ArrayList<>();
        double totalPrice = 0.0;

        for (Cart cart : carts) {
            List<CartItem> cartItems = cartItemService.findByCartId(cart.getId());
            listItem.addAll(cartItems);
            totalPrice += cartItems.stream()
                    .mapToDouble(item -> item.getCount() * item.getProduct().getPrice())
                    .sum();
        }

        model.addAttribute("listcart", listItem);
        model.addAttribute("price", totalPrice);

        return "user/order/order";
    }
}
