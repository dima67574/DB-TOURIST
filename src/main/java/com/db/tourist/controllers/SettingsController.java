package com.db.tourist.controllers;

import com.db.tourist.models.User;
import com.db.tourist.services.UserService;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collections;
import java.util.Map;

@Controller
public class SettingsController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/settings", method = RequestMethod.GET)
    public ModelAndView settings() {
        View view = new View("settings");
        view.addObject("user", userService.getUser());
        view.addObject("title", "Настройки");
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/settings/saveEducation", method = RequestMethod.POST)
    public Boolean saveEducation(@RequestParam("learningWords") Integer learningWords,
                                 @RequestParam("trainingWords") Integer trainingWords) {
        User user = userService.getUser();
        return userService.save(user) != null ? true : false;
    }

    @ResponseBody
    @RequestMapping(value = "/settings/saveEmail", method = RequestMethod.POST)
    public Boolean saveEducation(@RequestParam("email") String email) {
        User user = userService.getUser();
        user.setEmail(email);
        return userService.save(user) != null ? true : false;
    }

    @ResponseBody
    @RequestMapping(value = "/settings/changePassword", method = RequestMethod.POST)
    public Map<String, Integer> changePasswordSubmit(@RequestParam("oldPassword") String oldPassword,
                                                     @RequestParam("password") String password) {
        Integer status = userService.changePassword(oldPassword, password);
        return Collections.singletonMap("status", status);
    }
}
