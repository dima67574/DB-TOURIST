package com.db.tourist.controllers.admin;

import com.db.tourist.models.Epoch;
import com.db.tourist.models.Photo;
import com.db.tourist.models.UploadedFile;
import com.db.tourist.repositories.EpochRepository;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.utils.FileHelper;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
public class EpochController {

    @Autowired
    private EpochRepository epochRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileHelper fileHelper;

    @RequestMapping(value = "/admin/epoches", method = RequestMethod.GET)
    public ModelAndView epochesList(HttpServletRequest request) {
        View view = new View("epoche/list", true);
        view.addObject("title", "Эпохи");
        view.addObject("epoches", epochRepository.findAll());
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/epoches/delete", method = RequestMethod.POST)
    public void deleteUser(@RequestParam("id") Long epochId) {
        epochRepository.delete(epochId);
    }

    @RequestMapping(value = "/admin/epoches/add", method = RequestMethod.GET)
    public ModelAndView epochesAdd() {
        View view = new View("epoche/edit", true);
        view.addObject("title", "Создание эпохи");
        view.addObject("epoch", new Epoch());
        return view;
    }

    @RequestMapping(value = "/admin/epoches/add", method = RequestMethod.POST)
    public String epochesPost(@ModelAttribute("epoch") Epoch epoch, RedirectAttributes redirectAttributes) {
        Epoch e = epochRepository.save(epoch);
        redirectAttributes.addFlashAttribute("success", "Эпоха успешно создана. Теперь вы можете добавить фотографии");
        return "redirect:/admin/epoches/photo/" + e.getId();
    }

    @RequestMapping(value = "/admin/epoches/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id, HttpServletRequest request) {
        View view = new View("epoche/edit", true);
        view.addObject("title", "Редактирование эпохи");
        view.addObject("epoch", epochRepository.findOne(id));
        return view;
    }

    @RequestMapping(value = "/admin/epoches/edit/{id}", method = RequestMethod.POST)
    public String editPost(Epoch epoch, RedirectAttributes redirectAttributes) {
        if(epochRepository.save(epoch) != null) {
            redirectAttributes.addFlashAttribute("success", "Эпоха успешно отредактирована");
        }
        return "redirect:/admin/epoches";
    }

    @RequestMapping(value = "/admin/epoches/photo/{id}", method = RequestMethod.GET)
    public ModelAndView photosList(@PathVariable("id") Long id) {
        View view = new View("epoche/photo", true);
        Epoch epoch = epochRepository.findOne(id);
        if(epoch != null) {
            view.addObject("title", "Фотоальбом эпохи \"" + epoch.getName() + "\"");
            view.addObject("epoch", epoch);
        }
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/epoches/upload", method = RequestMethod.POST)
    public Boolean saveFile(@ModelAttribute UploadedFile uploadedFile, @RequestParam("objectId") Long objectId) {
        MultipartFile multipartFile = uploadedFile.getMultipartFile();
        String file = fileHelper.upload(multipartFile);

        Photo photo = new Photo();
        photo.setEpoch(new Epoch(objectId));
        photo.setFile(file);
        photoRepository.save(photo);

        return true;
    }
}
