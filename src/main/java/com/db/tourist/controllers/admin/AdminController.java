package com.db.tourist.controllers.admin;

import com.db.tourist.services.PhotoService;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {
    @Autowired
    private PhotoService photoService;

    @RequestMapping(value = "/admin/login", method = RequestMethod.GET)
    public ModelAndView login(String error, String logout) {
        View view = new View("login", true);
        view.addObject("title", "Вход в админ-панель");
        if (error != null)
            view.addObject("error", true);
        if (logout != null)
            view.addObject("message", "Вы успешно вышли");
        return view;
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public ModelAndView main() {
        View view = new View("main", true);
        view.addObject("title", "Главная");
        return view;
    }

    @RequestMapping(value = "/admin/photo/delete", method = RequestMethod.POST)
    @ResponseBody
    public Boolean deletePhoto(@RequestParam("photo") String photo) {
        return photoService.deletePhoto(photo);
    }
}
