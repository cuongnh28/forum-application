package com.fc.controller;

import com.fc.model.Post;
import com.fc.model.Topic;
import com.fc.model.User;
import com.fc.service.PostService;
import com.fc.service.TopicService;
import com.fc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
public class TopicController {

    @Autowired
    private TopicService topicService;

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @RequestMapping("/listTopic.do")
    public String listTopic(Model model) {
        List<Topic> topicList = topicService.listTopic();
        return getTopicViewsAndPosts(model, topicList);
    }

    @RequestMapping("/listImage.do")
    public String listImage(Model model) {
        List<String> imageList = topicService.listImage();
        model.addAttribute("imageList", imageList);
        return "image";
    }

    @RequestMapping(value = "/addTopic.do", method = RequestMethod.POST)
    public String addTopic(String name, String content, MultipartFile myFileName, Model model, HttpSession session, HttpServletRequest request) {
        int sessionUid = (int) session.getAttribute("userId");

        if (myFileName != null && !myFileName.isEmpty()) {
            String[] allowedType = {"image/bmp", "image/gif", "image/jpeg", "image/png"};
            boolean allowed = Arrays.asList(allowedType).contains(myFileName.getContentType());
            if (!allowed) {
                model.addAttribute("error4", "We just only accept format: bmp，jpg，png，gif. Please try to upload again.");
                return "topic";
            }
            if (myFileName.getSize() > 3 * 1024 * 1024) {
                model.addAttribute("error4", "Size of the picture are too large. Please try again.");
                return "topic";
            }
            try {
                byte[] bytes = myFileName.getBytes();
                String rootPath = request.getServletContext().getRealPath("upload");
                File dir = new File(rootPath + File.separator + "images");
                if (!dir.exists()) {
                    dir.mkdir();
                }

                String image = myFileName.getOriginalFilename();
                File serverFile = new File(dir.getAbsolutePath() + File.separator + image);
                System.out.println("Path of image on server: " + serverFile.getPath());

                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

                topicService.addTopic(name, content, image);
                List<Topic> topicList = topicService.listTopic();
                model.addAttribute("topicList", topicList);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("File upload false");
        }

        return "redirect:listTopic.do";
    }

    @RequestMapping(value="/searchTopic.do", method = RequestMethod.GET)
    public String searchTopic(String searchTemp, Model model) {
        List<Topic> topicList = topicService.searchByTopicName(searchTemp);
        return getTopicViewsAndPosts(model, topicList);
    }

    private String getTopicViewsAndPosts(Model model, List<Topic> topicList) {
        int tmpTotalViews;
        for (Topic topic:topicList) {
            tmpTotalViews = 0;
            topic.setListPost(postService.listPostByTopicId(topic.getTopicId(), 0));
            for (Post post:topic.getListPost()) {
                tmpTotalViews += post.getPostVisitList().size();
            }
            topic.setTotalViews(tmpTotalViews);
        }
        List<User> hotUserList = userService.listUserByHot();
        model.addAttribute("topicList", topicList);
        model.addAttribute("hotUserList", hotUserList);
        return "topic";
    }

}





