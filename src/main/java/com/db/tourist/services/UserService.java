package com.db.tourist.services;

import com.db.tourist.models.User;
import com.db.tourist.utils.auth.UserPrincipal;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserService {

    User create(User user);

    User getUser();

    UserPrincipal makeUserPrincipal(User user);

    User findByEmail(String email);

    User findByToken(String token);

    User findByLogin(String login);

    User save(User user);

    List<User> findAll();

    void delete(Long userId);

    User findOne(Long userId);

    Boolean lockUser(Long id, Boolean lockStatus);

    Boolean sendRegistrationRequest(User user, HttpServletRequest request);

    Boolean checkRegistrationToken(String token);

    Boolean sendRestoreRequest(User user, HttpServletRequest request);

    Integer changePassword(String oldPassowrd, String password);

    Boolean changePassword(User user, String password, Boolean resetToken);
}
