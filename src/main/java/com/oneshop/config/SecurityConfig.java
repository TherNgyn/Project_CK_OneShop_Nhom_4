package com.oneshop.config;

import com.oneshop.service.Impl.CustomUserDetailsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
	
	@Autowired
    private CustomUserDetailsService customUserDetailsService;
	
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/register", "/login")  // Bỏ qua CSRF cho các URL này
            )
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/user/**").hasAnyAuthority("ROLE_USER")
                .requestMatchers("/admin/**").hasAnyAuthority("ROLE_ADMIN")
                .requestMatchers("/vendor/**").hasAnyAuthority("ROLE_VENDOR")
                .requestMatchers("/**").permitAll()  // Chấp nhận tất cả yêu cầu cho các URL khác (như trang login, register...)
            )
            .formLogin(form -> form
                .loginPage("/login")  // URL của trang login
                .loginProcessingUrl("/login")  // URL mà form gửi đến
                .successHandler((request, response, authentication) -> {
                    String role = authentication.getAuthorities().toString();
                    String redirectUrl = "/home";  // Đặt URL mặc định cho mọi trường hợp

                    // Điều chỉnh URL chuyển hướng dựa trên vai trò của người dùng
                    if (role.contains("ROLE_ADMIN")) {
                        redirectUrl = "/admin/home";
                    } else if (role.contains("ROLE_VENDOR")) {
                        redirectUrl = "/vendor/home";
                    } else if (role.contains("ROLE_USER")) {
                        redirectUrl = "/user/home";
                    }

                    response.sendRedirect(redirectUrl);  // Chuyển hướng sau khi đăng nhập thành công
                })
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login")  // Trở lại trang login sau khi logout
                .permitAll()
            );

        return http.build();
    }

    
    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class)
            .userDetailsService(customUserDetailsService)
            .passwordEncoder(passwordEncoder())
            .and()
            .build();
    }








}

