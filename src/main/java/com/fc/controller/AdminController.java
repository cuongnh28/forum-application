package com.fc.controller;

import com.fc.model.Post;
import com.fc.model.User;
import com.fc.service.CommentService;
import com.fc.service.PostService;
import com.fc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    @RequestMapping("/admin.do")
    public String admin(HttpSession session, Model model) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        double noOfNewUsersThisMonth = userService.getNoOfNewUsersInMonth(LocalDate.now());
        double noOfNewUsersLastMonth = userService.getNoOfNewUsersInMonth(LocalDate.now().minusMonths(1));
        double noOfNewPostsThisMonth = postService.getNoOfNewPostsInMonth(LocalDate.now());
        double noOfNewPostsLastMonth = postService.getNoOfNewPostsInMonth(LocalDate.now().minusMonths(1));
        double noOfNewCommentsThisMonth = commentService.getNoOfNewCommentsInMonth(LocalDate.now());
        double noOfNewCommentsLastMonth = commentService.getNoOfNewCommentsInMonth(LocalDate.now().minusMonths(1));
        String incrementUser = String.format("%.2f",((noOfNewUsersThisMonth - noOfNewUsersLastMonth) / noOfNewUsersLastMonth * 100));
        String incrementPost = String.format("%.2f",((noOfNewPostsThisMonth - noOfNewPostsLastMonth) / noOfNewPostsLastMonth * 100));
        String incrementComment = String.format("%.2f",((noOfNewCommentsThisMonth - noOfNewCommentsLastMonth) / noOfNewCommentsLastMonth * 100));
        if (user.checkIsAdmin()) {
            model.addAttribute("newUser", noOfNewUsersThisMonth);
            model.addAttribute("incrementUser", incrementUser);
            model.addAttribute("newPost", noOfNewPostsThisMonth);
            model.addAttribute("incrementPost", incrementPost);
            model.addAttribute("newComment", noOfNewCommentsThisMonth);
            model.addAttribute("incrementComment", incrementComment);
            return "admin/home";
        }
        else {
            return null;
        }
    }

    @RequestMapping("/postPendingTables.do")
    public String postPendingTables(Model model, HttpSession session) {
        List<Post> listPostsNotApprove = postService.listPostsNotApprove();
        model.addAttribute("listPost", listPostsNotApprove);
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            return "admin/tables";
        }
        else {
            return null;
        }
    }

    @RequestMapping("/acceptPost.do")
    public String acceptPost(int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            postService.acceptPost(postId);
            return "redirect:postPendingTables.do";
        }
        else {
            return null;
        }
    }

    @RequestMapping("/rejectPost.do")
    public String rejectPost(int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            postService.rejectPost(postId);
            return "redirect:postPendingTables.do";
        }
        else {
            return null;
        }
    }

    @RequestMapping(value = "/getTotalPostsRecently.do", method = RequestMethod.GET)
    public ResponseEntity<List<Integer>> getTotalPostsRecently () {
        List<Integer> listTotalPostsRecently = new ArrayList<>();
        double totalPostsOfAug = postService.getNoOfNewPostsInMonth(LocalDate.now().minusMonths(5));
        double totalPostsOfSep = postService.getNoOfNewPostsInMonth(LocalDate.now().minusMonths(4));
        double totalPostsOfOct = postService.getNoOfNewPostsInMonth(LocalDate.now().minusMonths(3));
        double totalPostsOfNow = postService.getNoOfNewPostsInMonth(LocalDate.now().minusMonths(2));
        double totalPostsOfDec = postService.getNoOfNewPostsInMonth(LocalDate.now().minusMonths(1));
        double totalPostsOfJan = postService.getNoOfNewPostsInMonth(LocalDate.now());
        listTotalPostsRecently.add((int) totalPostsOfAug);
        listTotalPostsRecently.add((int) totalPostsOfSep);
        listTotalPostsRecently.add((int) totalPostsOfOct);
        listTotalPostsRecently.add((int) totalPostsOfNow);
        listTotalPostsRecently.add((int) totalPostsOfDec);
        listTotalPostsRecently.add((int) totalPostsOfJan);
        return new ResponseEntity<>(listTotalPostsRecently, HttpStatus.OK);
    }

}
