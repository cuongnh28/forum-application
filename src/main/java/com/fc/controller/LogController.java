package com.fc.controller;

import com.fc.model.Log;
import com.fc.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class LogController {

    @Autowired
    private LogService logService;

    @RequestMapping("/toLog.do")
    public String toLog(Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Map<String, List<Log>> map = logService.listLogByUserId(sessionUid);
        model.addAttribute("map", map);
        return "log";
    }

}
