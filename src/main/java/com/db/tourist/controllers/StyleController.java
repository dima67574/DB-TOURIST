package com.db.tourist.controllers;

import com.db.tourist.models.Style;
import com.db.tourist.services.ObjectService;
import com.db.tourist.services.PhotoService;
import com.db.tourist.services.StyleService;
import com.db.tourist.utils.UploadedFile;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class StyleController {
    @Autowired
    private StyleService styleService;

    @Autowired
    private PhotoService photoService;

    @Autowired
    private ObjectService objectService;

    @Transactional
    @RequestMapping(value = "/style/{epochId}/objects", method = RequestMethod.GET)
    public ModelAndView objects(@PathVariable("epochId") Long id) {
        View view = new View("objects");
        Style s = styleService.findOne(id);
        view.addObject("title", "Достопримечательности стиля «" + s.getName() + "»");
        view.addObject("objects", objectService.setRatings(s.getObjectList()));
        return view;
    }

    @RequestMapping(value = "/styles", method = RequestMethod.GET)
    public ModelAndView epochs() {
        View view = new View("styles");
        view.addObject("title", "Стили");
        view.addObject("styles", styleService.findAllByOrderByNameAsc());
        return view;
    }

    @RequestMapping(value = "/style/{styleId}/gallery", method = RequestMethod.GET)
    public ModelAndView epochs(@PathVariable("styleId") Long epochId) {
        View view = new View("gallery");
        Style style = styleService.findOne(epochId);
        view.addObject("title", "Фотоальбом стиля «" + style.getName() + "»");
        view.addObject("object", style);
        return view;
    }

    @RequestMapping(value = "/admin/style/setCover", method = RequestMethod.POST)
    public String setCover(@RequestParam("styleId") Long styleId, @RequestParam("coverId") Long coverId, RedirectAttributes ra) {
        Style style = styleService.findOne(styleId);
        style.setCover(photoService.findOne(coverId));
        styleService.save(style);
        return "redirect:/admin/style/photo/" + style.getId();
    }

    @RequestMapping(value = "/admin/style", method = RequestMethod.GET)
    public ModelAndView list() {
        View view = new View("style/list", true);
        view.addObject("title", "Стили");
        view.addObject("styles", styleService.findAll());
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/style/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long id) {
        styleService.delete(id);
    }

    @RequestMapping(value = "/admin/style/add", method = RequestMethod.GET)
    public ModelAndView add() {
        View view = new View("style/edit", true);
        view.addObject("title", "Создание стиля");
        view.addObject("style", new Style());
        return view;
    }

    @RequestMapping(value = "/admin/style/add", method = RequestMethod.POST)
    public String add(@ModelAttribute("style") Style style, RedirectAttributes redirectAttributes) {
        Style s = styleService.save(style);
        if(s != null) {
            redirectAttributes.addFlashAttribute("success", "Стиль успешно создан. Теперь вы можете добавить фотографии");
            return "redirect:/admin/style/photo/" + s.getId();
        }
        return "redirect:/admin/style";
    }

    @RequestMapping(value = "/admin/style/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id) {
        View view = new View("style/edit", true);
        view.addObject("title", "Редактирование стиля");
        view.addObject("style", styleService.findOne(id));
        return view;
    }

    @RequestMapping(value = "/admin/style/edit/{id}", method = RequestMethod.POST)
    public String edit(Style style, RedirectAttributes redirectAttributes) {
        Style s = styleService.findOne(style.getId());
        s.setName(style.getName());
        s.setDescription(style.getDescription());
        if(styleService.save(s) != null) {
            redirectAttributes.addFlashAttribute("success", "Стиль успешно отредактирован");
        }
        return "redirect:/admin/style";
    }

    @RequestMapping(value = "/admin/style/photo/{id}", method = RequestMethod.GET)
    public ModelAndView photos(@PathVariable("id") Long id) {
        View view = new View("photo", true);
        Style style = styleService.findOne(id);
        if(style != null) {
            view.addObject("title", "Фотоальбом стиля «" + style.getName() + "»");
            view.addObject("object", style);
            view.addObject("objectName", "style");
            view.addObject("backBtnText", "К списку стилей");
            view.addObject("objectTitle", "стиль");
        }
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/style/upload", method = RequestMethod.POST)
    public Boolean saveFile(@ModelAttribute UploadedFile uploadedFile, @RequestParam("objectId") Long objectId) {
        return styleService.uploadPhoto(uploadedFile, objectId);
    }
}
