package com.db.tourist.services;

import com.db.tourist.models.Photo;

import javax.servlet.http.HttpServletResponse;

public interface PhotoService {
    Boolean deletePhoto(String photo);
    void displayPhoto(HttpServletResponse response, String photo);
    Photo findOne(Long id);
}
