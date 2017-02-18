package com.db.tourist.controllers;

import com.db.tourist.models.StaticPage;
import com.db.tourist.services.StaticPageService;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class StaticPageController {

    @Autowired
    private StaticPageService staticPageService;

    @RequestMapping(value = "/page/{page}", method = RequestMethod.GET)
    public ModelAndView page(@PathVariable("page") String page) {
        View view = new View("staticPage");
        StaticPage staticPage = staticPageService.findOneByUrl(page);
        view.addObject("page", staticPage);
        view.addObject("title", staticPage.getTitle());
        return view;
    }

    @RequestMapping(value = "/admin/pages", method = RequestMethod.GET)
    public ModelAndView pagesList(HttpServletRequest request) {
        View view = new View("admin/staticPages/list");
        view.addObject("title", "Статические страницы");
        view.addObject("pages", staticPageService.findAll());
        view.addObject("url", staticPageService.getRequestUrl(request));
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/pages/delete", method = RequestMethod.POST)
    public void deleteUser(@RequestParam("id") Long pageId) {
        staticPageService.delete(pageId);
    }

    @RequestMapping(value = "/admin/pages/add", method = RequestMethod.GET)
    public ModelAndView pageAdd(HttpServletRequest request) {
        View view = new View("admin/staticPages/edit");
        view.addObject("title", "Создание страницы");
        view.addObject("page", new StaticPage());
        view.addObject("url", staticPageService.getRequestUrl(request));
        return view;
    }

    @RequestMapping(value = "/admin/pages/add", method = RequestMethod.POST)
    public String faqAddPost(@ModelAttribute("page") StaticPage staticPage, RedirectAttributes redirectAttributes) {
        staticPage.setCreateDate(new Date());
        staticPageService.save(staticPage);
        redirectAttributes.addFlashAttribute("success", "Страница успешно создана");
        return "redirect:/admin/pages/";
    }

    @RequestMapping(value = "/admin/pages/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id, HttpServletRequest request) {
        View view = new View("admin/staticPages/edit");
        view.addObject("title", "Редактирование страницы");
        view.addObject("page", staticPageService.findOne(id));
        view.addObject("url", staticPageService.getRequestUrl(request));
        return view;
    }

    @RequestMapping(value = "/admin/pages/edit/{id}", method = RequestMethod.POST)
    public String editPost(StaticPage page, RedirectAttributes redirectAttributes) {
        StaticPage p = staticPageService.findOne(page.getId());
        if(p != null) {
            p.setTitle(page.getTitle());
            p.setText(page.getText());
            p.setUrl(page.getUrl());
            staticPageService.save(p);
            redirectAttributes.addFlashAttribute("success", "Страница успешно отредактирована");
        }
        return "redirect:/admin/pages";
    }
}
