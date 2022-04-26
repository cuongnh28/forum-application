package com.fc.mapper;

import com.fc.model.User;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;

public interface UserMapper {

    int selectEmailCount(String email);

    void insertUser(User user);

    int selectActived(User user);

    User selectUserByUserId(int userId);

    Integer selectUserIdByEmailAndPassword(User user);

    User selectEditInfo(int userId);

    void updateUser(User user);

    void updatePostCount(Integer userId);

    void updateActived(String activateCode);

    List<User> listUserByTime();

    List<User> listUserByHot();

    void updateHeadUrl(@Param("userId") int userId, @Param("headUrl") String headUrl);

    void updateCover(@Param("userId") int userId, @Param("cover") String cover);

    String selectHeadUrl(int userId);

    void updateScanCount(int userId);

    User selectUsernameByUserId(int userId);

    String selectPasswordByUserId(int userId);

    void updatePassword(@Param("newPassword") String newPassword,@Param("userId") int userId);

    String selectVerifyCode(String email);

    void updatePasswordByActivateCode(String code);

    double selectNoOfUser(@Param("fromDate") Date fromDate, @Param("toDate") Date toDate);

    void updateFollowerCount(@Param("follower_count") long follower_count, @Param("userId") int userId);

    void updateFollowCount( @Param("follow_count") long follow_count, @Param("userId") int userId);

}
