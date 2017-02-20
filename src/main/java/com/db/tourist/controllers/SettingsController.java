package com.db.tourist.controllers;

import com.db.tourist.services.*;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
public class SettingsController {

    @Autowired
    private UserService userService;

    @Autowired
    private EpochService epochService;

    @Autowired
    private StyleService styleService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private SettingsService settingsService;

    @RequestMapping(value = "/settings", method = RequestMethod.GET)
    public ModelAndView settings() {
        View view = new View("settings");
        view.addObject("title", "Настройки");
        view.addObject("epochList", epochService.findAll());
        view.addObject("styleList", styleService.findAll());
        view.addObject("typeList", typeService.findAll());
        view.addObject("user", userService.findOne(userService.getUser().getId()));
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/settings/savePreferences", method = RequestMethod.POST)
    public Boolean savePreferences(@RequestParam(value = "epochs[]", required = false) List<Long> epochs,
                                 @RequestParam(value = "types[]", required = false) List<Long> types,
                                 @RequestParam(value = "styles[]", required = false) List<Long> styles) {
        return settingsService.savePreferences(epochs, types, styles);
    }

    @ResponseBody
    @RequestMapping(value = "/settings/saveEmail", method = RequestMethod.POST)
    public Boolean saveEmail(@RequestParam("email") String email) {
        return settingsService.saveEmail(email);
    }

    @ResponseBody
    @RequestMapping(value = "/settings/changePassword", method = RequestMethod.POST)
    public Map<String, Integer> changePassword(@RequestParam("oldPassword") String oldPassword,
                                                     @RequestParam("password") String password) {
        return Collections.singletonMap("status", userService.changePassword(oldPassword, password));
    }
}
