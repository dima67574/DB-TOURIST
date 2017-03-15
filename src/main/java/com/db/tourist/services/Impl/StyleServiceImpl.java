package com.db.tourist.services.Impl;

import com.db.tourist.models.Object;
import com.db.tourist.models.Photo;
import com.db.tourist.models.Style;
import com.db.tourist.repositories.ObjectRepository;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.repositories.StyleRepository;
import com.db.tourist.services.StyleService;
import com.db.tourist.utils.FileHelper;
import com.db.tourist.utils.UploadedFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class StyleServiceImpl implements StyleService {

    @Autowired
    private StyleRepository styleRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileHelper fileHelper;

    public List<Style> findAll() {
        return styleRepository.findAll();
    }

    public Style findOne(Long id) {
        return styleRepository.findOne(id);
    }

    public Style save(Style style) {
        return styleRepository.save(style);
    }

    public void delete(Long id) {
        styleRepository.delete(id);
    }

    public Boolean uploadPhoto(UploadedFile file, Long id) {
        MultipartFile multipartFile = file.getMultipartFile();
        String uploadedFile = fileHelper.upload(multipartFile);
        Photo photo = new Photo();
        photo.setStyle(styleRepository.findOne(id));
        photo.setFile(uploadedFile);
        return photoRepository.save(photo) != null;
    }

    public List<Style> findAllByOrderByNameAsc() {
        return styleRepository.findAllByOrderByNameAsc();
    }
}
