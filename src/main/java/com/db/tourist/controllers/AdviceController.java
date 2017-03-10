package com.db.tourist.controllers;

import com.db.tourist.services.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class AdviceController {

    @Autowired
    private CommentService commentService;

    @Value("${app.siteName}")
    private String siteName;

    @ModelAttribute("notCheckedCommentsCnt")
    public Integer getNotCheckedCommentsCount()
    {
        return commentService.getNotCheckedCount();
    }

    @ModelAttribute("siteName")
    public String siteName()
    {
        return siteName;
    }
}
