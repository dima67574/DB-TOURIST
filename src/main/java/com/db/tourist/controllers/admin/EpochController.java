package com.db.tourist.controllers.admin;

import com.db.tourist.models.Epoch;
import com.db.tourist.services.EpochService;
import com.db.tourist.services.PhotoService;
import com.db.tourist.utils.UploadedFile;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class EpochController {

    @Autowired
    private EpochService epochService;

    @Autowired
    private PhotoService photoService;

    @RequestMapping(value = "/epochs", method = RequestMethod.GET)
    public ModelAndView epochs() {
        View view = new View("epochs");
        view.addObject("title", "Эпохи");
        view.addObject("epochs", epochService.findAllByOrderByNameAsc());
        return view;
    }

    @RequestMapping(value = "/epoch/{epochId}/gallery", method = RequestMethod.GET)
    public ModelAndView epochs(@PathVariable("epochId") Long epochId) {
        View view = new View("gallery");
        Epoch epoch = epochService.findOne(epochId);
        view.addObject("title", "Фотоальбом эпохи «" + epoch.getName() + "»");
        view.addObject("object", epoch);
        return view;
    }

    @RequestMapping(value = {"/admin", "/admin/epoch"}, method = RequestMethod.GET)
    public ModelAndView list() {
        View view = new View("epoch/list", true);
        view.addObject("title", "Эпохи");
        view.addObject("epochs", epochService.findAll());
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/epoch/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long id) {
        epochService.delete(id);
    }

    @RequestMapping(value = "/admin/epoch/add", method = RequestMethod.GET)
    public ModelAndView add() {
        View view = new View("epoch/edit", true);
        view.addObject("title", "Создание эпохи");
        view.addObject("epoch", new Epoch());
        return view;
    }

    @RequestMapping(value = "/admin/epoch/add", method = RequestMethod.POST)
    public String add(@ModelAttribute("epoch") Epoch epoch, RedirectAttributes redirectAttributes) {
        Epoch e = epochService.save(epoch);
        if(e != null) {
            redirectAttributes.addFlashAttribute("success", "Эпоха успешно создана. Теперь вы можете добавить фотографии");
            return "redirect:/admin/epoch/photo/" + e.getId();
        }
        return "redirect:/admin/epoch";
    }

    @RequestMapping(value = "/admin/epoch/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id) {
        View view = new View("epoch/edit", true);
        view.addObject("title", "Редактирование эпохи");
        view.addObject("epoch", epochService.findOne(id));
        return view;
    }

    @RequestMapping(value = "/admin/epoch/edit/{id}", method = RequestMethod.POST)
    public String edit(Epoch epoch, RedirectAttributes redirectAttributes) {
        Epoch e = epochService.findOne(epoch.getId());
        epoch.setCover(e.getCover());
        if(epochService.save(epoch) != null) {
            redirectAttributes.addFlashAttribute("success", "Эпоха успешно отредактирована");
        }
        return "redirect:/admin/epoch";
    }

    @RequestMapping(value = "/admin/epoch/photo/{id}", method = RequestMethod.GET)
    public ModelAndView photos(@PathVariable("id") Long id) {
        View view = new View("epoch/photo", true);
        Epoch epoch = epochService.findOne(id);
        if(epoch != null) {
            view.addObject("title", "Фотоальбом эпохи «" + epoch.getName() + "»");
            view.addObject("epoch", epoch);
        }
        return view;
    }

    @RequestMapping(value = "/admin/epoch/setCover", method = RequestMethod.POST)
    public String setCover(@RequestParam("epochId") Long epochId, @RequestParam("coverId") Long coverId, RedirectAttributes ra) {
        Epoch epoch = epochService.findOne(epochId);
        epoch.setCover(photoService.findOne(coverId));
        epochService.save(epoch);
        return "redirect:/admin/epoch/photo/" + epoch.getId();
    }

    @RequestMapping(value = "/admin/epoch/upload", method = RequestMethod.POST)
    public Boolean saveFile(@ModelAttribute UploadedFile uploadedFile, @RequestParam("objectId") Long objectId) {
        return epochService.uploadPhoto(uploadedFile, objectId);
    }

}
