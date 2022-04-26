package com.fc.controller;

import com.fc.model.Post;
import com.fc.model.User;
import com.fc.service.LoginService;
import com.fc.service.PostService;
import com.fc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private LoginService loginService;

    @Autowired
    private PostService postService;

    @RequestMapping("/toMyProfile.do")
    public String toMyProfile(HttpSession session, Model model, HttpServletRequest request) {
        int sessionUid = (int) session.getAttribute("userId");
        User user = userService.getProfile(sessionUid, sessionUid);
        List<Post> postList = postService.getPostListByUserId(sessionUid);

        model.addAttribute("user", user);
        model.addAttribute("postList", postList);
        return "myProfile";
    }

    @RequestMapping("/toProfile.do")
    public String toProfile(int userId, Model model, HttpSession session) {
        int sessionUid = session.getAttribute("userId") == null ? Integer.MAX_VALUE : (int) session.getAttribute("userId");
        if (sessionUid == userId) {
            return "redirect:toMyProfile.do";
        }
        boolean following = userService.getFollowStatus(sessionUid, userId);
        User user = userService.getProfile(sessionUid, userId);
        List<Post> postList = postService.getPostListByUserId(userId);
        model.addAttribute("following", following);
        model.addAttribute("user", user);
        model.addAttribute("postList", postList);
        return "profile";
    }

    @RequestMapping("/toEditProfile.do")
    public String toEditProfile(HttpSession session, Model model) {
        int userId = (int) session.getAttribute("userId");
        User user = userService.getEditInfo(userId);
        model.addAttribute("user", user);
        return "editProfile";
    }

    @RequestMapping("/editProfile.do")
    public String editProfile(User user) {
        userService.updateUser(user);
        return "redirect:toMyProfile.do";
    }

    @RequestMapping("/updatePassword.do")
    public String updatePassword(String password, String newpassword, String repassword, HttpSession session, Model model) {
        int sessionUid = (int) session.getAttribute("userId");
        String status = loginService.updatePassword(password, newpassword, repassword, sessionUid);
        if (status.equals("ok")) {
            return "redirect:logout.do";
        } else {
            model.addAttribute("passwordError", status);
            return "editProfile";
        }
    }

    @RequestMapping("/forgetPassword.do")
    public String forgetPassword(String email) {
        userService.forgetPassword(email);
        return "forgetPassword";
    }

    @RequestMapping("/afterForgetPassword.do")
    public String afterForgetPassword(Model model) {
//        User user = userService.getEditInfo(session)
        return "prompt/afterForgetPassword";
    }

//    @RequestMapping("/updateHeadUrl.do")
//    public String updateHeadUrl(MultipartFile myFileName, Model model, HttpSession session) throws IOException {
//        String[] allowedType = {"image/bmp", "image/gif", "image/jpeg", "image/png"};
//        boolean allowed = Arrays.asList(allowedType).contains(myFileName.getContentType());
//        if (!allowed) {
//            model.addAttribute("error3", "We just only accept format: bmp，jpg，png，gif. Please try to upload again.");
//            return "editProfile";
//        }
//        if (myFileName.getSize() > 3 * 1024 * 1024) {
//            model.addAttribute("error3", "Size of the picture are too large. Please try again.");
//            return "editProfile";
//        }
//        String fi = myFileName.getOriginalFilename();
//        String fileNameExtension = fi.substring(fi.indexOf("."), fi.length());
//        String remoteFileName = UUID.randomUUID().toString() + fileNameExtension;
//        qiniuService.upload(myFileName.getBytes(), remoteFileName);
//
//        int userId = (int) session.getAttribute("userId");
//        userService.updateHeadUrl(userId, MyConstant.QINIU_IMAGE_URL + remoteFileName);
//
//        return "redirect:toMyProfile.do";
//    }

    @RequestMapping("/uploadImage.do")
    public String uploadImage (MultipartFile myFileName, String addTo, Model model, HttpSession session, HttpServletRequest request) {
        if (myFileName != null && !myFileName.isEmpty()) {
            String[] allowedType = {"image/bmp", "image/gif", "image/jpeg", "image/png"};
            boolean allowed = Arrays.asList(allowedType).contains(myFileName.getContentType());
            if (!allowed) {
                model.addAttribute("error3", "We just only accept format: bmp，jpg，png，gif. Please try to upload again.");
                return "editProfile";
            }
            if (myFileName.getSize() > 3 * 1024 * 1024) {
                model.addAttribute("error3", "Size of the picture are too large. Please try again.");
                return "editProfile";
            }
            try {
                byte[] bytes = myFileName.getBytes();
                String rootPath = request.getServletContext().getRealPath("upload");
                File dir = new File(rootPath + File.separator + "images");
                if (!dir.exists()) {
                    dir.mkdir();
                }

                String name = myFileName.getOriginalFilename();
                File serverFile = new File(dir.getAbsolutePath()+File.separator+name);
                System.out.println("Path of image on server: " + serverFile.getPath());

                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

                int userId = (int) session.getAttribute("userId");
                if (addTo.equalsIgnoreCase("avatar")) {
                    userService.updateHeadUrl(userId, name);
                }
                else if (addTo.equalsIgnoreCase("cover")){
                    userService.updateCover(userId, name);
                }
                User user = userService.getUserById(userId);
                session.setAttribute("user", user);

                return "redirect:toMyProfile.do";
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        else {
            System.out.println("File upload false");
        }
        return null;
    }

    @RequestMapping("/follow.do")
    public String follow(int userId, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        userService.follow(sessionUid, userId);
        return "forward:toProfile.do";
    }

    @RequestMapping("/unfollow.do")
    public String unfollow(int userId, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        userService.unfollow(sessionUid, userId);
        return "forward:toProfile.do";
    }

    @RequestMapping("/verify.do")
    public String verify(String code) {
        userService.verifyForgetPassword(code);
        return "redirect:toLogin.do";
    }

}

