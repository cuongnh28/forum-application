package com.fc.controller;

import com.fc.model.PageBean;
import com.fc.model.Post;
import com.fc.model.User;
import com.fc.service.*;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/")
public class IndexController {

    @Autowired
    TestPostService testPostService;

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private QiniuService qiniuService;

    @RequestMapping("/toIndex.do")
    public String toIndex(Model model, HttpServletRequest request) {
//        userService.record(request.getRequestURL(), request.getContextPath(), request.getRemoteAddr());
        PageBean<Post> pageBean;
        pageBean = postService.listPostByNewestTime(1);
        List<User> newUserList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        String sortBy = "newestTime";
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("newUserList", newUserList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }


    @RequestMapping(value = "/upload.do", method = {RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String upload(MultipartFile myFileName) throws IOException {

        String[] allowedType = {"image/bmp", "image/gif", "image/jpeg", "image/png"};
        boolean allowed = Arrays.asList(allowedType).contains(myFileName.getContentType());
        if (!allowed) {
            return "error";
        }
        if (myFileName.getSize() > 3 * 1024 * 1024) {
            return "error";
        }
        String fi = myFileName.getOriginalFilename();
        String fileNameExtension = fi.substring(fi.indexOf("."), fi.length());
        String remoteFileName = UUID.randomUUID().toString() + fileNameExtension;

        qiniuService.upload(myFileName.getBytes(), remoteFileName);

        return MyConstant.QINIU_IMAGE_URL + remoteFileName;
    }

}
