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
