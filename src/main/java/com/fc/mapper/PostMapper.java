package com.fc.mapper;

import com.fc.model.Post;
import com.fc.model.PostVisit;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;


public interface PostMapper {

    List<Post> listPostByUserId(int userId);

    int insertPost(Post post);

    List<Post> listPostByNewestTime(@Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByLatestTime(@Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByHottest(@Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByTopic(@Param("topicId") int topicId, @Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByTopicId(@Param("topicId") int topicId, @Param("postId") int postId);

    List<Post> searchByTitle(@Param("title") String title);

    int selectPostCount();

    Post getPostByPostId(int postId);

    void updateCommentCount(@Param("val") int val, @Param("postId") int postId);

    void updateScanCount(int postId);

    void updateCommentTime(int postId);

    int getUserIdByPostId(int postId);

    String getTitleByPostId(int postId);

    boolean deletePost(int postId);

    boolean rejectPost(int postId);

    List<Post> listPostsNotApprove();

    boolean acceptPost(int postId);

    void insertPostVisit(int postId);

    List<PostVisit> getPostVisitByPostId(int postId);

    double selectNoOfPost(@Param("fromDate") Date fromDate, @Param("toDate") Date toDate);

    void updateLikeCount(@Param("val") long val, @Param("postId") int postId);

}
