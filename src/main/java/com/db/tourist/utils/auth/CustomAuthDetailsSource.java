package com.db.tourist.utils.auth;


import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class CustomAuthDetailsSource implements AuthenticationDetailsSource<HttpServletRequest, CustomAuthDetails> {
    public CustomAuthDetails buildDetails (HttpServletRequest context) {
        return new CustomAuthDetails(context);
    }
}