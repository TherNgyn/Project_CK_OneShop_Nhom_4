package com.oneshop.controller.common;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        // Lấy mã lỗi HTTP
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        if (status != null) {
            int errorCode = Integer.valueOf(status.toString());
            if (errorCode == HttpStatus.NOT_FOUND.value()) {
                return "error/404";  // Trang lỗi 404
            }
            if (errorCode == HttpStatus.FORBIDDEN.value()) {
                return "error/403";  // Trang lỗi 403
            }
            if (errorCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                return "error/500";  // Trang lỗi 500
            }
        }
        return "error/generic";  // Trang lỗi chung nếu không phải các lỗi trên
    }
}
