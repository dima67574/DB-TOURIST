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

@Controller
public class StaticPageController {

    @Autowired
    private StaticPageService staticPageService;

    @RequestMapping(value = "/page/{page}", method = RequestMethod.GET)
    public ModelAndView page(@PathVariable("page") String page) {
        View view = new View("staticPage");
        StaticPage staticPage = staticPageService.findOneByUrl(page);
        if(staticPage != null) {
            view.addObject("staticPage", staticPage);
            view.addObject("title", staticPage.getTitle());
        } else {
            view.addObject("title", "Страница не найдена");
        }
        return view;
    }

    @RequestMapping(value = "/admin/pages", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request) {
        View view = new View("staticPages/list", true);
        view.addObject("title", "Статические страницы");
        view.addObject("pages", staticPageService.findAll());
        view.addObject("url", staticPageService.getRequestUrl(request));
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/pages/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long pageId) {
        staticPageService.delete(pageId);
    }

    @RequestMapping(value = "/admin/pages/add", method = RequestMethod.GET)
    public ModelAndView add(HttpServletRequest request) {
        View view = new View("staticPages/edit", true);
        view.addObject("title", "Создание страницы");
        view.addObject("page", new StaticPage());
        view.addObject("url", staticPageService.getRequestUrl(request));
        return view;
    }

    @RequestMapping(value = "/admin/pages/add", method = RequestMethod.POST)
    public String add(@ModelAttribute("page") StaticPage staticPage, RedirectAttributes redirectAttributes) {
        staticPageService.save(staticPage);
        redirectAttributes.addFlashAttribute("success", "Страница успешно создана");
        return "redirect:/admin/pages/";
    }

    @RequestMapping(value = "/admin/pages/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id, HttpServletRequest request) {
        View view = new View("staticPages/edit", true);
        view.addObject("title", "Редактирование страницы");
        view.addObject("page", staticPageService.findOne(id));
        view.addObject("url", staticPageService.getRequestUrl(request));
        return view;
    }

    @RequestMapping(value = "/admin/pages/edit/{id}", method = RequestMethod.POST)
    public String edit(StaticPage page, RedirectAttributes redirectAttributes) {
        if(staticPageService.update(page) != null) {
            redirectAttributes.addFlashAttribute("success", "Страница успешно отредактирована");
        }
        return "redirect:/admin/pages";
    }
}
