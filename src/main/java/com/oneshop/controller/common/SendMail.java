package com.oneshop.controller.common;

import java.util.Properties;
import jakarta.mail.Authenticator; // Xác thực email
import jakarta.mail.Message; // Tạo nội dung email
import jakarta.mail.PasswordAuthentication; // Dùng để cung cấp email và mật khẩu
import jakarta.mail.Session; // Tạo session gửi email
import jakarta.mail.Transport; // Gửi email qua SMTP
import jakarta.mail.internet.InternetAddress; // Địa chỉ email
import jakarta.mail.internet.MimeMessage; // Email định dạng MIME

public class SendMail {

    // Gửi email với tham số là email người nhận và mã OTP
	public boolean sendEmail(String toEmail, String otpCode) {
	    boolean test = false;

	    // Thông tin email người gửi
	    String fromEmail = "qthu01012004@gmail.com"; 
	    String password = "zgmy zjec ojzn twsr"; 

	    try {
	        // Cấu hình chi tiết SMTP server
	        Properties pr = configEmail(new Properties());

	        // Lấy session để xác thực email và mật khẩu
	        Session session = Session.getInstance(pr, new Authenticator() {
	            @Override
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(fromEmail, password);
	            }
	        });

	        // Thiết lập thông tin email
	        Message mess = new MimeMessage(session);
	        mess.setHeader("Content-Type", "text/plain; charset=UTF-8");
	        mess.setFrom(new InternetAddress(fromEmail));
	        mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

	        // Tiêu đề và nội dung email
	        mess.setSubject("Xác thực tài khoản");
	        mess.setText("Đây là mã OTP của bạn: " + otpCode);
	        
	        // Gửi email
	        Transport.send(mess);
	        
	        // Nếu không có lỗi xảy ra, trả về true
	        test = true;
	    } catch (Exception e) {
	        // In lỗi ra nếu gửi email không thành công
	        e.printStackTrace();
	    }

	    // Trả về false nếu có lỗi xảy ra
	    return test;
	}


    // Cấu hình chi tiết SMTP server
    public Properties configEmail(Properties pr) {
        // Cấu hình thông số cho server SMTP Gmail
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        pr.put("mail.smtp.ssl.protocols", "TLSv1.2");
        pr.put("mail.smtp.socketFactory.port", "587");
        pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // Sửa lại ở đây

        return pr;
    }

}
