package com.db.tourist.controllers.admin;

import com.db.tourist.models.Type;
import com.db.tourist.services.PhotoService;
import com.db.tourist.services.TypeService;
import com.db.tourist.utils.UploadedFile;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class TypeController {
    @Autowired
    private TypeService typeService;

    @Autowired
    private PhotoService photoService;

    @RequestMapping(value = "/types", method = RequestMethod.GET)
    public ModelAndView types() {
        View view = new View("types");
        view.addObject("title", "Типы");
        view.addObject("types", typeService.findAllByOrderByNameAsc());
        return view;
    }

    @RequestMapping(value = "/type/{typeId}/gallery", method = RequestMethod.GET)
    public ModelAndView epochs(@PathVariable("typeId") Long typeId) {
        View view = new View("gallery");
        Type type = typeService.findOne(typeId);
        view.addObject("title", "Фотоальбом типа «" + type.getName() + "»");
        view.addObject("object", type);
        return view;
    }

    @RequestMapping(value = "/admin/type", method = RequestMethod.GET)
    public ModelAndView list() {
        View view = new View("type/list", true);
        view.addObject("title", "Типы");
        view.addObject("types", typeService.findAll());
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/type/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long id) {
        typeService.delete(id);
    }

    @RequestMapping(value = "/admin/type/add", method = RequestMethod.GET)
    public ModelAndView add() {
        View view = new View("type/edit", true);
        view.addObject("title", "Создание типа");
        view.addObject("type", new Type());
        return view;
    }

    @RequestMapping(value = "/admin/type/add", method = RequestMethod.POST)
    public String add(@ModelAttribute("type") Type type, RedirectAttributes redirectAttributes) {
        Type t = typeService.save(type);
        if(t != null) {
            redirectAttributes.addFlashAttribute("success", "Тип успешно создан. Теперь вы можете добавить фотографии");
            return "redirect:/admin/type/photo/" + t.getId();
        }
        return "redirect:/admin/type";
    }

    @RequestMapping(value = "/admin/type/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id) {
        View view = new View("type/edit", true);
        view.addObject("title", "Редактирование типа");
        view.addObject("type", typeService.findOne(id));
        return view;
    }

    @RequestMapping(value = "/admin/type/edit/{id}", method = RequestMethod.POST)
    public String edit(Type type, RedirectAttributes redirectAttributes) {
        Type t = typeService.findOne(type.getId());
        type.setCover(t.getCover());
        if(typeService.save(type) != null) {
            redirectAttributes.addFlashAttribute("success", "Тип успешно отредактирован");
        }
        return "redirect:/admin/type";
    }

    @RequestMapping(value = "/admin/type/setCover", method = RequestMethod.POST)
    public String setCover(@RequestParam("typeId") Long typeId, @RequestParam("coverId") Long coverId, RedirectAttributes ra) {
        Type type = typeService.findOne(typeId);
        type.setCover(photoService.findOne(coverId));
        typeService.save(type);
        return "redirect:/admin/type/photo/" + type.getId();
    }

    @RequestMapping(value = "/admin/type/photo/{id}", method = RequestMethod.GET)
    public ModelAndView photos(@PathVariable("id") Long id) {
        View view = new View("type/photo", true);
        Type type = typeService.findOne(id);
        if(type != null) {
            view.addObject("title", "Фотоальбом типа «" + type.getName() + "»");
            view.addObject("type", type);
        }
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/type/upload", method = RequestMethod.POST)
    public Boolean saveFile(@ModelAttribute UploadedFile uploadedFile, @RequestParam("objectId") Long objectId) {
        return typeService.uploadPhoto(uploadedFile, objectId);
    }
}
