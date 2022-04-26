package com.fc.controller;

import com.fc.model.Reply;
import com.fc.model.User;
import com.fc.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")

public class ReplyController {

    @Autowired
    private ReplyService replyService;

    @RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
    public String deleteReply(int replyId, int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User sessionUser = (User) session.getAttribute("user");
        Reply reply = replyService.getReplyById(replyId);

        if (sessionUid == reply.getUser().getUserId() || sessionUser.checkIsAdmin()) {
            if (replyService.deleteReply(replyId)) {
                return "redirect:toPost.do?postId=" + postId;
            }
        }

        return null;
    }

    @RequestMapping("/reply.do")
    public String reply(int postId, int commentId, String content, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        replyService.reply(postId, sessionUid, commentId, content);
        return "redirect:toPost.do?postId=" + postId;
    }

}
