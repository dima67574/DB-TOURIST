package com.db.tourist.services.Impl;

import com.db.tourist.models.User;
import com.db.tourist.repositories.RoleRepository;
import com.db.tourist.repositories.UserRepository;
import com.db.tourist.services.UserService;
import com.db.tourist.utils.EmailSender;
import com.db.tourist.utils.auth.UserPrincipal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private EmailSender emailSender;

    @Autowired
    private RoleRepository roleRepository;

    @Value("${app.siteName}")
    private String siteName;

    public User getUser() {
        return ((UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUser();
    }

    public UserPrincipal makeUserPrincipal(User user) {
        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        grantedAuthorities.add(new SimpleGrantedAuthority(user.getRole().getName()));
        return new UserPrincipal(user.getLogin(), user.getPassword(), grantedAuthorities, user);
    }

    @Override
    public User create(User user) {
        user.setRole(roleRepository.findByName("ROLE_USER"));
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    public Boolean sendRegistrationRequest(User user, HttpServletRequest request) {
        user.setToken(UUID.randomUUID().toString());
        userRepository.save(user);

        String url = request.getRequestURL().toString();
        String domain = url.substring(0, url.length() - request.getRequestURI().length())
                + request.getContextPath() + "/";
        String text = "Здравствуйте, " + user.getLogin() + ".<br/>" +
                "Для завершения регистрации на " + siteName + " перейдите по " +
                "<a href=\"" + domain + "registration/confirm/" + user.getToken() + "\">ссылке</a>";
        try {
            emailSender.sendMail(siteName, user.getEmail(), "Подтверждение регистрации", text);
        } catch (MessagingException e) {
            return false;
        }
        return true;
    }

    public Boolean sendRestoreRequest(User user, HttpServletRequest request) {
        user.setToken(UUID.randomUUID().toString());
        userRepository.save(user);

        String url = request.getRequestURL().toString();
        String domain = url.substring(0, url.length() - request.getRequestURI().length())
                + request.getContextPath() + "/";
        String text = "Здравствуйте, " + user.getLogin() + ".<br/>" +
                "Для восстановления доступа к аккаунту на " + siteName + " перейдите по " +
                "<a href=\"" + domain + "restore/confirm/" + user.getToken() + "\">ссылке</a>";
        try {
            emailSender.sendMail(siteName, user.getEmail(), "Восстановление доступа", text);
        } catch (MessagingException e) {
            return false;
        }
        return true;
    }

    public Boolean checkRegistrationToken(String token) {
        User user = userRepository.findByToken(token);
        if(user != null) {
            user.setEnabled(true);
            user.setToken(null);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User findByToken(String token) {
        return userRepository.findByToken(token);
    }

    public User findByLogin(String login) {
        return userRepository.findByLogin(login);
    }

    public Integer changePassword(String oldPassowrd, String password) {
        User user = getUser();
        if(oldPassowrd != null) {
            if (!bCryptPasswordEncoder.matches(oldPassowrd, user.getPassword())) {
                return 1;
            }
        }
        return changePassword(user, password, false) ? 0 : 2;
    }

    public Boolean changePassword(User user, String password, Boolean resetToken) {
        //Если новый и старый пароли совпадают
        if (bCryptPasswordEncoder.matches(password, user.getPassword())) {
            return false;
        }
        user.setPassword(bCryptPasswordEncoder.encode(password));
        if(resetToken != null && resetToken){
            user.setToken(null);
        }
        return userRepository.save(user) != null;
    }

    public User save(User user) {
        return userRepository.save(user);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void delete(Long userId) {
        userRepository.delete(userId);
    }

    public User findOne(Long userId) {
        return userRepository.findOne(userId);
    }

    public Boolean lockUser(Long id, Boolean lockStatus) {
        User user = userRepository.findOne(id);
        if(user != null && !user.getBanned().equals(lockStatus)) {
            user.setBanned(lockStatus);
            return userRepository.save(user) != null;
        } else {
            return false;
        }
    }
}
