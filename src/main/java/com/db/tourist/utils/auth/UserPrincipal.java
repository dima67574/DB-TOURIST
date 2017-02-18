package com.db.tourist.utils.auth;

import com.db.tourist.models.User;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class UserPrincipal extends org.springframework.security.core.userdetails.User {

    private User user;

    public UserPrincipal(String login, String password, Collection<? extends GrantedAuthority> authorities, User user) {
        super(login, password, authorities);
        this.user = user;
    }

    public User getUser() {
        return user;
    }
}
