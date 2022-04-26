package com.fc.async;

import com.fc.mapper.CommentMapper;
import com.fc.mapper.LogMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.Log;
import com.fc.model.User;
import com.fc.util.MyConstant;

public class LogTask implements Runnable {

    private LogMapper logMapper;
    private UserMapper userMapper;
    private PostMapper postMapper;
    private ReplyMapper replyMapper;
    private CommentMapper commentMapper;
    private Integer postId;
    private Integer replyId;
    private Integer commentId;
    private int sessionUid;
    private int operation;

    public LogTask(LogMapper logMapper, UserMapper userMapper, PostMapper postMapper, CommentMapper commentMapper, ReplyMapper replyMapper, Integer postId, Integer commentId, Integer replyId, int sessionUid, int operation) {
        this.logMapper = logMapper;
        this.userMapper = userMapper;
        this.postMapper = postMapper;
        this.commentMapper = commentMapper;
        this.replyMapper = replyMapper;
        this.postId = postId;
        this.replyId = replyId;
        this.commentId = commentId;
        this.sessionUid = sessionUid;
        this.operation = operation;
    }

    public LogTask(LogMapper logMapper, UserMapper userMapper, PostMapper postMapper, CommentMapper commentMapper, ReplyMapper replyMapper, int sessionUid, int operation) {
        this.logMapper = logMapper;
        this.userMapper = userMapper;
        this.postMapper = postMapper;
        this.replyMapper = replyMapper;
        this.commentMapper = commentMapper;
        this.sessionUid = sessionUid;
        this.operation = operation;
    }

    @Override
    public void run() {
        Log log = new Log();
        int userId = postMapper.getUserIdByPostId(postId);
        log.setUserId(userId);

        User user = userMapper.selectUsernameByUserId(sessionUid);
        log.setUserId(user.getUserId());
        log.setOtherUsername(user.getUsername());
        log.setPostId(postId);
        log.setCommentId(commentId);
        log.setReplyId(replyId);

        if (operation == MyConstant.OPERATION_CLICK_LIKE) {
            log.setOperation(" voted on ");
            log.setDisplayedContent(postMapper.getTitleByPostId(postId));
        } else if (operation == MyConstant.OPERATION_REPLY) {
            log.setOperation(" replied on ");
            log.setDisplayedContent(postMapper.getTitleByPostId(postId));
        } else if (operation == MyConstant.OPERATION_COMMENT) {
            log.setOperation(" commented on ");
            log.setDisplayedContent(postMapper.getTitleByPostId(postId));
        }

        logMapper.insertLog(log);
    }
}


