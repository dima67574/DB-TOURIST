package com.db.tourist.services.Impl;

import com.db.tourist.models.Epoch;
import com.db.tourist.models.Style;
import com.db.tourist.models.Type;
import com.db.tourist.models.User;
import com.db.tourist.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SettingsServiceImpl implements SettingsService {

    @Autowired
    private EpochService epochService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private StyleService styleService;

    @Autowired
    private UserService userService;

    public Boolean savePreferences(List<Long> epochs, List<Long> types, List<Long> styles) {
        User user = userService.getUser();
        List<Epoch> epochList = new ArrayList<>();
        List<Type> typeList = new ArrayList<>();
        List<Style> styleList = new ArrayList<>();
        if(epochs != null) epochs.forEach(id -> epochList.add(epochService.findOne(id)));
        if(types != null) types.forEach(id -> typeList.add(typeService.findOne(id)));
        if(styles != null) styles.forEach(id -> styleList.add(styleService.findOne(id)));
        user.setEpochList(epochList);
        user.setTypeList(typeList);
        user.setStyleList(styleList);
        return userService.save(user) != null;
    }

    public Boolean saveEmail(String email) {
        User user = userService.getUser();
        user.setEmail(email);
        return userService.save(user) != null;
    }
}
