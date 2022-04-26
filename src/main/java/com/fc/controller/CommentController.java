package com.fc.controller;

import com.fc.model.Comment;
import com.fc.model.User;
import com.fc.service.PostService;
import com.fc.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private PostService postService;

    @RequestMapping("/comment.do")
    public String comment(int postId, String contentComment, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        commentService.comment(sessionUid, postId, contentComment);
        return "redirect:toPost.do?postId=" + postId;
    }

    @RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
    public String deleteComment(int commentId, int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User sessionUser = (User) session.getAttribute("user");
        Comment comment = commentService.getCommentById(commentId);

        if (sessionUid == comment.getUser().getUserId() || sessionUser.checkIsAdmin()) {
            if (commentService.deleteComment(commentId)) {
                postService.updateCommentCount(-1, postId);
                return "redirect:toPost.do?postId=" + postId;
            }
        }

        return null;
    }
}





