package com.db.tourist.utils;

import com.db.tourist.models.User;
import com.db.tourist.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Interceptor implements HandlerInterceptor {

    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView modelAndView)
            throws Exception {

        if(modelAndView!= null && modelAndView.getViewName().equals("layout")) {
            try {
                User user = userService.getUser();

                if (user != null && user.getRole().getName().equals("ROLE_USER")) {
                    //modelAndView.addObject("test", 123);
                }

                if (user != null && user.getRole().getName().equals("ROLE_ADMIN")) {
                    //modelAndView.addObject("test", 321);
                }

            } catch (ClassCastException ex) {}
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex) throws Exception {
    }
}