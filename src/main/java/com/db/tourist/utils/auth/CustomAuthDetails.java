package com.db.tourist.utils.auth;

import org.springframework.security.web.authentication.WebAuthenticationDetails;

import javax.servlet.http.HttpServletRequest;

public class CustomAuthDetails extends WebAuthenticationDetails {
    private final String formType;
    private final String captcha;
    public CustomAuthDetails(HttpServletRequest request) {
        super(request);
        this.formType = request.getParameter("f_type");
        this.captcha = request.getParameter("captcha");
    }

    public String getFormType() {
        return formType;
    }

    public String getCaptcha() {
        return captcha;
    }
}