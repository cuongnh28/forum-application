package com.fc.controller;

import com.fc.model.User;
import com.fc.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @RequestMapping("/toLogin.do")
    public String toLogin() {
        return "login";
    }

    @RequestMapping(value = "/register.do", method = RequestMethod.POST)
    public String register(User user, String repassword, Model model) {
        String result = loginService.register(user, repassword);
        if (result.equals("ok")) {
            model.addAttribute("info", "An email is sent to your email. Please access link to confirm new account");
            return "prompt/promptInfo";
        } else {
            model.addAttribute("register", "yes");
            model.addAttribute("email", user.getEmail());
            model.addAttribute("error", result);
            return "login";
        }
    }

    @RequestMapping(value = "/login.do", method = RequestMethod.POST)
    public String login(User user, Model model, HttpSession session) {
        Map<String, Object> map = loginService.login(user);
        if (map.get("status").equals("yes")) {
            session.setAttribute("userId", map.get("userId"));
            session.setAttribute("headUrl", map.get("headUrl"));
            session.setAttribute("user", map.get("user"));
            session.setAttribute("isAdmin", map.get("isAdmin"));
            return "redirect:toMyProfile.do";
        } else {
            model.addAttribute("email", user.getEmail());
            model.addAttribute("error", map.get("error"));
            return "login";
        }
    }

    @RequestMapping(value = "/activate.do")
    public String activate(String code, Model model) {
        loginService.activate(code);

        model.addAttribute("info", "Your account has been active.<br/>Please use.");
        return "prompt/promptInfo";
    }

    @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.removeAttribute("userId");
        session.removeAttribute("user");
        return "redirect:toIndex.do";
    }
}


