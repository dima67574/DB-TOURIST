package com.db.tourist.services;

import com.db.tourist.models.StaticPage;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface StaticPageService {
    String getRequestUrl(HttpServletRequest request);

    List<StaticPage> findAll();

    void delete(Long pageId);

    StaticPage findOne(Long pageId);

    StaticPage save(StaticPage page);

    StaticPage findOneByUrl(String url);
}
