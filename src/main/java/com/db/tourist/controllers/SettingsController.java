package com.db.tourist.controllers;

import com.db.tourist.models.Epoch;
import com.db.tourist.models.Style;
import com.db.tourist.models.Type;
import com.db.tourist.models.User;
import com.db.tourist.repositories.EpochRepository;
import com.db.tourist.repositories.StyleRepository;
import com.db.tourist.repositories.TypeRepository;
import com.db.tourist.services.UserService;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
public class SettingsController {

    @Autowired
    private UserService userService;

    @Autowired
    private EpochRepository epochRepository;

    @Autowired
    private StyleRepository styleRepository;

    @Autowired
    private TypeRepository typeRepository;

    @RequestMapping(value = "/settings", method = RequestMethod.GET)
    public ModelAndView settings() {
        View view = new View("settings");
        view.addObject("epochList", epochRepository.findAll());
        view.addObject("styleList", styleRepository.findAll());
        view.addObject("typeList", typeRepository.findAll());
        view.addObject("user", userService.findOne(userService.getUser().getId()));
        view.addObject("title", "Настройки");
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/settings/savePreferences", method = RequestMethod.POST)
    public Boolean saveEducation(@RequestParam(value = "epoches[]", required = false) List<Long> epoches,
                                 @RequestParam(value = "types[]", required = false) List<Long> types,
                                 @RequestParam(value = "styles[]", required = false) List<Long> styles) {
        User user = userService.getUser();
        List<Epoch> epochList = new ArrayList<>();
        List<Type> typeList = new ArrayList<>();
        List<Style> styleList = new ArrayList<>();
        if(epoches != null) epoches.forEach(id -> epochList.add(new Epoch(id)));
        if(types != null) types.forEach(id -> typeList.add(new Type(id)));
        if(styles != null) styles.forEach(id -> styleList.add(new Style(id)));
        user.setEpochList(epochList);
        user.setTypeList(typeList);
        user.setStyleList(styleList);
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
