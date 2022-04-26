package com.fc.async;

import com.fc.util.MyConstant;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

import javax.mail.internet.MimeMessage;

public class MailTask implements Runnable {

    private String code;
    private String email;
    private JavaMailSender javaMailSender;
    private int operation;

    public MailTask(String code, String email, JavaMailSender javaMailSender, int operation) {
        this.code = code;
        this.email = email;
        this.javaMailSender = javaMailSender;
        this.operation = operation;
    }

    @Override
    public void run() {
        javaMailSender.send(mimeMessage -> {
            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            mimeMessageHelper.setFrom(MyConstant.MAIL_FROM);
            mimeMessageHelper.setTo(email);
            StringBuilder sb = new StringBuilder();
            sb.append("<html><head></head><body>");

            if (operation == 1) {
                mimeMessageHelper.setSubject("PTIT Forum - Register Account");
                sb.append("Hi, please click link bellow to active your account");
                sb.append("<br/><a href=" + MyConstant.DOMAIN_NAME + "activate.do?code=");
                sb.append(code);
                sb.append(">Click here</a></body>");
            } else {
                mimeMessageHelper.setSubject("PTIT Forum - Forget Password");
                sb.append("Hi, please click link bellow to reset your password");
                sb.append(code.substring(0, 8));
                sb.append("，<br/><a href=" + MyConstant.DOMAIN_NAME + "verify.do?code=" + code + ">");
                sb.append("Click here</a></body>");
            }

            mimeMessageHelper.setText(sb.toString(), true);

        });
    }
}








