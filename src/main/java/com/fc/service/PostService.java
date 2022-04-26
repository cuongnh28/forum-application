package com.fc.service;

import com.fc.async.LogTask;
import com.fc.mapper.LogMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.CommentMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.PageBean;
import com.fc.model.Post;
import com.fc.model.PostVisit;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;


@Service
public class PostService {

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private LogMapper logMapper;

    @Autowired
    private JedisPool jedisPool;

    @Autowired
    private TaskExecutor taskExecutor;

    public List<Post> getPostListByUserId(int userId) {
        return postMapper.listPostByUserId(userId);
    }

    public int publishPost(Post post) {

        post.setPublishTime(new Date());
        post.setCommentTime(null);
        post.setCommentCount(0);
        post.setLikeCount(0);
        post.setScanCount(0);
        postMapper.insertPost(post);
        userMapper.updatePostCount(post.getUser().getUserId());

        return post.getPostId();
    }

    public PageBean<Post> listPostByNewestTime(int curPage) {
        int limit = 8;
        int offset = (curPage - 1) * limit;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByNewestTime(offset, limit);

        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
            post.setPostVisitList(postMapper.getPostVisitByPostId(post.getPostId()));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, curPage);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public PageBean<Post> listPostByLatestTime(int curPage) {
        int limit = 8;
        int offset = (curPage - 1) * limit;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByLatestTime(offset, limit);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
            post.setPostVisitList(postMapper.getPostVisitByPostId(post.getPostId()));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, curPage);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public PageBean<Post> listPostByHottest(int curPage) {
        int limit = 8;
        int offset = (curPage - 1) * limit;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByHottest(offset, limit);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
            post.setPostVisitList(postMapper.getPostVisitByPostId(post.getPostId()));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, curPage);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public PageBean<Post> listPostByTopic(int topicId) {
        int limit = 8;
//        int offset = (topicId - 1) * limit;
        int offset = 0;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByTopic(topicId, offset, limit);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
            post.setPostVisitList(postMapper.getPostVisitByPostId(post.getPostId()));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, topicId);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public List<Post> listPostByTopicId(int topicId, int postId) {
        List<Post> postList = postMapper.listPostByTopicId(topicId, postId);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
            post.setPostVisitList(postMapper.getPostVisitByPostId(post.getPostId()));
        }
        return postList;
    }

    public Post getPostByPostId(int postId) {
        postMapper.updateScanCount(postId);
        Post post = postMapper.getPostByPostId(postId);
        Jedis jedis = jedisPool.getResource();
        long likeCount = jedis.scard(postId + ":like");
        post.setLikeCount((int) likeCount);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return post;
    }

    public PageBean<Post> searchByTitle(String searchTerm) {
        List<Post> postList = postMapper.searchByTitle(searchTerm);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
            post.setPostVisitList(postMapper.getPostVisitByPostId(post.getPostId()));
        }
        PageBean<Post> pageBean = new PageBean();
        pageBean.setList(postList);
        return pageBean;
    }

    public String clickLike(int postId, int sessionUid, boolean liked) {
        Jedis jedis = jedisPool.getResource();
        if (!liked) {
            jedis.sadd(postId + ":like", String.valueOf(sessionUid));
        }
        else {
            jedis.srem(postId + ":like", String.valueOf(sessionUid));
        }

        postMapper.updateLikeCount(jedis.scard(postId + ":like"), postId);


        taskExecutor.execute(new LogTask(logMapper, userMapper, postMapper, commentMapper, replyMapper, postId, null, null, sessionUid, MyConstant.OPERATION_CLICK_LIKE));
        String result = String.valueOf(jedis.scard(postId + ":like"));

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return result;
    }

    public boolean getLikeStatus(int postId, int sessionUid) {
        Jedis jedis = jedisPool.getResource();
        boolean result = jedis.sismember(postId + ":like", String.valueOf(sessionUid));

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return result;
    }

    public boolean deletePost(int postId) {
        try {
            postMapper.deletePost(postId);
            logMapper.deleteLogByPost(postId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public void updateCommentCount (int val, int postId) {
        postMapper.updateCommentCount(val, postId);
    }

    public List<Post> listPostsNotApprove () {
        return postMapper.listPostsNotApprove();
    }

    public boolean acceptPost (int postId) {
        return postMapper.acceptPost(postId);
    }

    public boolean rejectPost (int postId) {
        return postMapper.rejectPost(postId);
    }

    public void insertPostVisit (int postId) {
        postMapper.insertPostVisit(postId);
    }

    public double getNoOfNewPostsInMonth(LocalDate date) {
        LocalDate firstDayOfMonth = date.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate lastDayOfMonth = date.with(TemporalAdjusters.lastDayOfMonth());
        return postMapper.selectNoOfPost(java.sql.Date.valueOf(firstDayOfMonth), java.sql.Date.valueOf(lastDayOfMonth));
    }

    public List<PostVisit> getPostVisitByPostId (int postId) {
        return postMapper.getPostVisitByPostId(postId);
    }

}

