package com.db.tourist.utils;

import org.springframework.web.servlet.ModelAndView;

public class View extends ModelAndView {
    public View(String viewName) {
        super("user/template/layout", "content", "../" + viewName + ".jsp");
    }
    public View(String viewName, boolean isAdmin) {
        super("admin/template/layout", "content", "../" + viewName + ".jsp");
    }
}