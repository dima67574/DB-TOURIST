package com.db.tourist.controllers;import com.db.tourist.models.User;import com.db.tourist.services.ObjectService;import com.db.tourist.services.PhotoService;import com.db.tourist.services.UserService;import com.db.tourist.utils.UserValidator;import com.db.tourist.utils.View;import com.db.tourist.utils.captcha.Captcha;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.validation.BindingResult;import org.springframework.web.bind.annotation.*;import org.springframework.web.servlet.ModelAndView;import org.springframework.web.servlet.mvc.support.RedirectAttributes;import javax.servlet.ServletException;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import javax.transaction.Transactional;import java.io.IOException;@Controllerpublic class UserController {    @Autowired    private UserValidator userValidator;    @Autowired    private UserService userService;    @Autowired    private PhotoService photoService;    @Autowired    private ObjectService objectService;    @Autowired    private Captcha captcha;    @RequestMapping(value = "/photo", method = RequestMethod.GET)    @ResponseBody    public void displayPhoto(String name, HttpServletResponse response) {        photoService.displayPhoto(response, name);    }    @RequestMapping(value = "/captcha", method = RequestMethod.GET)    public void captcha(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {        captcha.captcha(req, resp);    }    @Transactional    @RequestMapping(value = "/", method = RequestMethod.GET)    public ModelAndView home() {        View view = new View("main");        view.addObject("title", "Главная");        view.addObject("objects", objectService.findRelevant(20));        view.addObject("noTitle", true);        return view;    }    @RequestMapping(value = "/map", method = RequestMethod.GET)    public ModelAndView maps(String xCoordinate, String yCoordinate) {        View view = new View("map");        view.addObject("title", "Карта");        view.addObject("xCoordinate", xCoordinate);        view.addObject("yCoordinate", yCoordinate);        view.addObject("objects", objectService.findAll());        return view;    }    @Transactional    @RequestMapping(value = "/preferences", method = RequestMethod.GET)    public ModelAndView preferences() {        View view = new View("preferences");        view.addObject("title", "Стоит посетить");        view.addObject("objects", objectService.findRelevant(null));        return view;    }    @RequestMapping(value = "/login", method = RequestMethod.GET)    public ModelAndView login(String error) {        View view = new View("login");        view.addObject("title", "Вход");        if (error != null)            view.addObject("error", true);        return view;    }    @RequestMapping(value = "/denied", method = RequestMethod.GET)    public String denied() {        return "redirect:/";    }    @RequestMapping(value = "/registration", method = RequestMethod.GET)    public ModelAndView registration(Model model) {        View view = new View("registration");        view.addObject("title", "Регистрация");        view.addObject("user", model.asMap().get("user") != null ? (User)model.asMap().get("user") : new User());        return view;    }    @RequestMapping(value = "/registration", method = RequestMethod.POST)    public ModelAndView registration(@RequestParam("captcha") String captchaReq, User user, BindingResult result,                                         HttpServletRequest request,                                         RedirectAttributes redirectAttributes) {        if (!captchaReq.equals(captcha.getGeneratedKey(request))) {            redirectAttributes.addFlashAttribute("error", "Введен неверный код с изображения");            redirectAttributes.addFlashAttribute("user", user);        } else {            userValidator.validate(user, result, false);            if (result.hasErrors()) {                View view = new View("registration");                view.addObject("title", "Регистрация");                return view;            }            User registered = userService.create(user);            if(registered != null) {                userService.authentication(registered);                redirectAttributes.addFlashAttribute("success", "Регистрация завершена. Теперь вы можете указать свои предпочтения");                return new ModelAndView("redirect:/settings");            } else {                redirectAttributes.addFlashAttribute("error", "При регистрации произошла ошибка");                redirectAttributes.addFlashAttribute("user", user);            }        }        return new ModelAndView("redirect:/registration");    }    @RequestMapping(value = "/restore", method = RequestMethod.GET)    public ModelAndView restore() {        View view = new View("restore/requestForm");        view.addObject("title", "Восстановление доступа");        return view;    }    @RequestMapping(value = "/restore", method = RequestMethod.POST)    public ModelAndView restore(@RequestParam("email") String email,                                    HttpServletRequest request,                                    RedirectAttributes redirectAttributes) {        User user = userService.findByEmail(email);        if(user != null) {            if(!user.getBanned()) {                if (userService.sendRestoreRequest(user, request)) {                    redirectAttributes.addFlashAttribute("info", "Ссылка для восстановления доступа отправлена на <b>" + user.getEmail() + "</b>");                } else {                    redirectAttributes.addFlashAttribute("error", "Произошла ошибка");                }            } else {                redirectAttributes.addFlashAttribute("error", "Ваш аккаунт заблокирован");            }        } else {            redirectAttributes.addFlashAttribute("error", "Пользователь с указанным email не найден");        }        return new ModelAndView("redirect:/restore");    }    @RequestMapping(value = "/profile", method = RequestMethod.GET)    public ModelAndView profile() {        View view = new View("profile");        view.addObject("title", "Просмотр профиля");        view.addObject("user", userService.findOne(userService.getUser().getId()));        return view;    }    @RequestMapping(value = "/profile/{login}", method = RequestMethod.GET)    public ModelAndView profile(@PathVariable("login") String login) {        View view = new View("profile");        view.addObject("title", "Просмотр профиля");        view.addObject("user", userService.findByLogin(login));        return view;    }    @RequestMapping(value = "/restore/confirm/{token}", method = RequestMethod.GET)    public ModelAndView confirmRestore(@PathVariable("token") String token) {        View view = new View("restore/setPassword");        view.addObject("title", "Восстановление доступа");        User user = userService.findByToken(token);        if(user != null) {            view.addObject("token", token);        } else {            view.addObject("error", "Ссылка для восстановления не верна, либо просрочена");            view.addObject("hideForm", true);        }        return view;    }    @RequestMapping(value = "/restore/confirm/{token}", method = RequestMethod.POST)    public String confirmRestore(@PathVariable("token") String token,                                           @RequestParam("password") String password,                                           RedirectAttributes redirectAttributes) {        User user = userService.findByToken(token);        if(user != null) {            if(userService.changePassword(user, password, true)) {                userService.authentication(user);                redirectAttributes.addFlashAttribute("success", "Пароль успешно изменен");                return "redirect:/";            } else {                redirectAttributes.addFlashAttribute("error", "Старый и новый пароли совпадают, придумайте новый пароль");                return "redirect:/restore/confirm/" + token;            }        }        return "redirect:/restore";    }}