package com.oneshop.config;

import com.oneshop.entity.User;
import com.oneshop.service.IUserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

@Configuration
public class SecurityConfig {

    @Autowired
    private IUserService userService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
        
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/register", "/login", "/forgot_password", "/otp_password", "/otp_register", "/enterOtp", "/user/**", "/vendor/**", "/admin/**", "/shipper/**")

                .ignoringRequestMatchers("/register","/login", "/forgot_password", "/otp_password", "/otp_register", "/enterOtp", "/user/**", "/vendor/**", "/admin/**")

            )
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/user/**").hasAnyAuthority("ROLE_USER","ROLE_VENDOR")
                .requestMatchers("/admin/**").hasAnyAuthority("ROLE_ADMIN")
                .requestMatchers("/vendor/**").hasAnyAuthority("ROLE_VENDOR")
                .requestMatchers("/shipper/**").hasAnyAuthority("ROLE_SHIPPER")
                .requestMatchers("/**").permitAll()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successHandler((request, response, authentication) -> {
                    HttpSession session = request.getSession();
                    String username = authentication.getName();
                    User user = userService.findByUsername(username);

                    // Lưu thông tin người dùng vào SecurityContext
                    SecurityContextHolder.getContext().setAuthentication(authentication);

                    // Lưu thông tin người dùng vào session 
                    session.setAttribute("user", user);
                    session.setAttribute("userRole", user.getRole());

                    // Điều hướng sau khi đăng nhập thành công
                    String redirectUrl = "/home";
                    switch (user.getRole()) {
                        case "ROLE_ADMIN":
                            redirectUrl = "/admin/home";
                            break;
                        case "ROLE_VENDOR":
                            redirectUrl = "/vendor/home";
                            break;
                        case "ROLE_SHIPPER":
                            redirectUrl = "/shipper/home";
                            break;
                        case "ROLE_USER":
                            redirectUrl = "/user/home";
                            break;
                    }
                    response.sendRedirect(redirectUrl);
                })
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login")
                .permitAll()
            );

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class)
            .userDetailsService(username -> {
                User user = userService.findByUsername(username);
                if (user == null) {
                    throw new RuntimeException("User not found: " + username);
                }
                return org.springframework.security.core.userdetails.User
                    .withUsername(user.getUsername())
                    .password(user.getPassword())
                    .authorities(user.getRole())
                    .build();
            })
            .passwordEncoder(passwordEncoder())
            .and()
            .build();
    }
    @Bean
    public HttpFirewall httpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true); // Cho phép "//"
        return firewall;
    }
}
