package com.oneshop.controller.user;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.oneshop.entity.Order;
import com.oneshop.entity.OrderItem;
import com.oneshop.entity.Product;
import com.oneshop.entity.Review;
import com.oneshop.entity.User;
import com.oneshop.service.IOrderService;
import com.oneshop.service.IProductService;
import com.oneshop.service.IReviewService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/review")
public class ReviewUserController {

    @Autowired
    private IReviewService reviewService;

    @Autowired
    private IProductService productService;

    @Autowired
    private IOrderService orderService;

    @GetMapping("/write")
    public String showOrderReviewForm(@RequestParam("orderId") Integer orderId, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        Optional<Order> optionalOrder = orderService.findById(orderId);
        if (!optionalOrder.isPresent()) {
            model.addAttribute("error", "Đơn hàng không tồn tại.");
            return "redirect:/user/delivery";
        }

        Order order = optionalOrder.get();

        // Kiểm tra nếu đơn hàng đã được đánh giá
        if (order.getReviewed() != null && order.getReviewed()) {
            model.addAttribute("error", "Đơn hàng này đã được đánh giá.");
            return "redirect:/user/delivery";
        }

        List<OrderItem> orderItems = order.getOrderItems();

        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);
        return "/user/review/write";
    }


    @PostMapping("/save")
    public String saveOrderReviews(
            @RequestParam("orderId") Integer orderId,
            @RequestParam("ratings") List<Float> ratings,
            @RequestParam("reviews") List<String> reviews,
            @RequestParam("productIds") List<Integer> productIds,
            HttpServletRequest request, Model model) {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            model.addAttribute("error", "Người dùng chưa đăng nhập.");
            return "redirect:/login";
        }

        Optional<Order> optionalOrder = orderService.findById(orderId);
        if (!optionalOrder.isPresent()) {
            model.addAttribute("error", "Đơn hàng không tồn tại.");
            return "redirect:/user/delivery";
        }

        Order order = optionalOrder.get();
        try {
            // Lưu đánh giá cho từng sản phẩm trong đơn hàng
            for (int i = 0; i < productIds.size(); i++) {
                Integer productId = productIds.get(i);
                Float rating = ratings.get(i);
                String reviewText = reviews.get(i);

                Optional<Product> optionalProduct = productService.findById(productId);
                if (!optionalProduct.isPresent()) {
                    continue;
                }

                Product product = optionalProduct.get();
                Review existingReview = reviewService.findByUserAndProduct(user, product);

                if (existingReview != null) {
                    existingReview.setRating(rating);
                    existingReview.setContent(reviewText);
                    existingReview.setUpdateat(Date.valueOf(LocalDate.now()));
                    reviewService.save(existingReview);
                } else {
                    Review newReview = new Review();
                    newReview.setUser(user);
                    newReview.setProduct(product);
                    newReview.setRating(rating);
                    newReview.setContent(reviewText);
                    newReview.setCreateat(Date.valueOf(LocalDate.now()));
                    reviewService.save(newReview);
                }
            }

            // Đánh dấu đơn hàng đã được đánh giá
            order.setReviewed(true);
            orderService.save(order);

            return "redirect:/user/delivery?status=Completed";
        } catch (Exception e) {
            model.addAttribute("error", "Đã xảy ra lỗi khi lưu đánh giá: " + e.getMessage());
            return "redirect:/user/delivery?status=Completed";
        }
    }

}
