package com.db.tourist.controllers;

import com.db.tourist.models.Photo;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.utils.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class CommonController {

    @Autowired
    private FileHelper fileHelper;

    @Autowired
    private PhotoRepository photoRepository;

    @RequestMapping(value = "/photo", method = RequestMethod.GET)
    @ResponseBody
    public void display(String name, HttpServletResponse response) throws IOException {
        fileHelper.getFile(response, name);
    }

    @RequestMapping(value = "/admin/photo/delete", method = RequestMethod.POST)
    @ResponseBody
    public Boolean display(@RequestParam("photo") String photo) {
        if(fileHelper.delete(photo)) {
            Photo p = photoRepository.findByFile(photo);
            photoRepository.delete(p);
            return true;
        }
        return false;
    }
}
