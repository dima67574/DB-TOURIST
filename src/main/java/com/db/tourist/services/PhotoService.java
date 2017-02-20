package com.db.tourist.services;

import javax.servlet.http.HttpServletResponse;

public interface PhotoService {
    Boolean deletePhoto(String photo);
    void displayPhoto(HttpServletResponse response, String photo);
}
