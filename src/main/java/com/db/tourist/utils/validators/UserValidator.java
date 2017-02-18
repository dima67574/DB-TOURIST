package com.db.tourist.utils.validators;

import com.db.tourist.models.User;
import com.db.tourist.repositories.UserRepository;
import com.db.tourist.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator{

    @Autowired
    UserService userService;

    @Autowired
    UserRepository userRepository;

    public boolean supports(Class<?> clazz) {
        return User.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {}

    public void validate(Object target, Errors errors, Boolean isUpdate) {

        User user = (User) target;
        User oldUser = null;
        if(isUpdate)
            oldUser = userService.findOne(user.getId());

        //Логин
        String login = user.getLogin();
        User existUser = userRepository.findByLogin(login);
        if(oldUser != null && existUser != null && !user.getLogin().equals(oldUser.getLogin())
                || oldUser == null && existUser != null) {
            errors.rejectValue("login", null, "Пользователь с таким логином уже существует");
        }

        //Email
        String email = user.getEmail();
        existUser = userRepository.findByEmail(email);
        if(oldUser != null && existUser != null && !existUser.getEmail().equals(oldUser.getEmail())
                || oldUser == null && existUser != null) {
            errors.rejectValue("email", null, "Пользователь с данным email адресом уже существует");
        }
    }
}
