package com.db.tourist.controllers;

import com.db.tourist.models.User;
import com.db.tourist.services.UserService;
import com.db.tourist.utils.View;
import com.db.tourist.utils.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class UsersController {

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/admin/users", method = RequestMethod.GET)
    public ModelAndView list() {
        View view = new View("users/list", true);
        view.addObject("title", "Управление пользователями");
        view.addObject("users", userService.findAll());
        view.addObject("user", userService.getUser());
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/users/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long id) {
        userService.delete(id);
    }

    @ResponseBody
    @RequestMapping(value = "/admin/users/activate", method = RequestMethod.POST)
    public Boolean activate(@RequestParam("id") Long id) {
        User user = userService.findOne(id);
        if(user != null) {
            return userService.save(user) != null;
        } else {
            return false;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/admin/users/lock", method = RequestMethod.POST)
    public Boolean lock(@RequestParam("id") Long id) {
        return userService.lockUser(id, true);
    }

    @ResponseBody
    @RequestMapping(value = "/admin/users/unlock", method = RequestMethod.POST)
    public Boolean unlock(@RequestParam("id") Long id) {
        return userService.lockUser(id, false);
    }

    @RequestMapping(value = "/admin/users/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id) {
        View view = new View("users/edit", true);
        view.addObject("title", "Редактирование пользователя");
        view.addObject("user", userService.findOne(id));
        return view;
    }

    @RequestMapping(value = "/admin/users/edit/{id}", method = RequestMethod.POST)
    public ModelAndView edit(User user, BindingResult result, RedirectAttributes redirectAttributes) {

        userValidator.validate(user, result, true);

        if (result.hasErrors()) {
            return new View("users/edit", true);
        }

        User updatedUser = userService.update(user);
        if(updatedUser != null) {
            redirectAttributes.addFlashAttribute("success", "Пользователь " + updatedUser.getFio() + " успешно отредактирован");
        }
        return new ModelAndView("redirect:/admin/users");
    }
}
