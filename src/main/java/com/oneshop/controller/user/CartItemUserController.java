package com.oneshop.controller.user;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@GetMapping("")
	public ModelAndView List(ModelMap model, HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/login");
		}
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
		System.out.println(listItem.get(0).getCart().getId());
		model.addAttribute("listcart", listItem);
		model.addAttribute("price", price);
		return new ModelAndView("/user/cartItem/shopping_cart", model);
	}

	@GetMapping("add/{id}/{count}")
	public String addtoCart(ModelMap model, HttpServletRequest request, @PathVariable("count") String num,
			@PathVariable("id") Integer id) {

		User user = (User) request.getSession().getAttribute("user");
		if(user==null)
			return "redirect:/login";
		System.out.println(user.getId());
		List<Cart> carts = cartService.findByUserId(user.getId()); // Giỏ hàng của user
		long millis = System.currentTimeMillis();
		Date date = new Date(millis);
		if (carts.isEmpty()) {
			Cart cart = new Cart();
			cart.setCreateat(date);
			cart.setUser(user);
			cartService.save(cart);
		}
		carts = cartService.findByUserId(user.getId());
		Product product = productService.getById(id);
		CartItem thisItem = null;
		for (Cart cart : carts) {
			List<CartItem> cartitems = cartItemService.findByCartId(cart.getId());

			for (CartItem cartitem : cartitems) {
				if (cartitem.getProduct().getId() == id) {
					thisItem = cartitem;
				}
			}
		}
		if (thisItem != null) {
			thisItem.setCount(thisItem.getCount() + Integer.parseInt(num));
			thisItem.setUpdateat(date);
		} else {

			thisItem = new CartItem();
			thisItem.setCount(Integer.parseInt(num));
			thisItem.setCreateat(date);
			thisItem.setUpdateat(null);
			thisItem.setCart(carts.get(0));
			thisItem.setProduct(product);
		}
		cartItemService.save(thisItem);

		List(model, request);
		return "/user/cartItem/shopping_cart";
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
		List(model, request);
		return "redirect:/user/cart/item";
	}

}
