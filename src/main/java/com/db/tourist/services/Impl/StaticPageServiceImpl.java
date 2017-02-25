package com.db.tourist.services.Impl;

import com.db.tourist.models.StaticPage;
import com.db.tourist.repositories.StaticPageRepository;
import com.db.tourist.services.StaticPageService;
import com.db.tourist.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Service
public class StaticPageServiceImpl implements StaticPageService {

    @Autowired
    private StaticPageRepository staticPageRepository;

    @Autowired
    private UserService userService;

    public String getRequestUrl(HttpServletRequest request) {
        String url = request.getRequestURL().toString();
        return url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    }

    public List<StaticPage> findAll() {
        return staticPageRepository.findAll();
    }

    public void delete(Long pageId) {
        staticPageRepository.delete(pageId);
    }

    public StaticPage findOne(Long pageId) {
        return staticPageRepository.findOne(pageId);
    }

    public StaticPage save(StaticPage page) {
        page.setCreateDate(new Date());
        if(page.getId() == null) page.setAuthor(userService.getUser());
        return staticPageRepository.save(page);
    }

    public StaticPage findOneByUrl(String url) {
        return staticPageRepository.findOneByUrl(url);
    }

    public StaticPage update(StaticPage page) {
        StaticPage p = staticPageRepository.findOne(page.getId());
        if(p != null) {
            p.setTitle(page.getTitle());
            p.setText(page.getText());
            p.setUrl(page.getUrl());
            return staticPageRepository.save(p);
        }
        return null;
    }
}
