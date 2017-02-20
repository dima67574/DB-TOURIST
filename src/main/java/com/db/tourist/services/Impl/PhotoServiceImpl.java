package com.db.tourist.services.Impl;

import com.db.tourist.models.Photo;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.services.PhotoService;
import com.db.tourist.utils.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Service
public class PhotoServiceImpl implements PhotoService {
    @Autowired
    private FileHelper fileHelper;

    @Autowired
    private PhotoRepository photoRepository;

    public Boolean deletePhoto(String photo) {
        if(fileHelper.delete(photo)) {
            Photo p = photoRepository.findByFile(photo);
            if(p != null) {
                photoRepository.delete(p);
                return true;
            }
        }
        return false;
    }

    public void displayPhoto(HttpServletResponse response, String photo) {
        try {
            fileHelper.getFile(response, photo);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
