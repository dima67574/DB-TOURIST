package com.db.tourist.services.Impl;

import com.db.tourist.models.Object;
import com.db.tourist.models.Photo;
import com.db.tourist.models.Type;
import com.db.tourist.repositories.ObjectRepository;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.repositories.TypeRepository;
import com.db.tourist.services.TypeService;
import com.db.tourist.utils.FileHelper;
import com.db.tourist.utils.UploadedFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {
    @Autowired
    private TypeRepository typeRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileHelper fileHelper;

    public List<Type> findAll() {
        return typeRepository.findAll();
    }

    public Type findOne(Long id) {
        return typeRepository.findOne(id);
    }

    public Type save(Type type) {
        return typeRepository.save(type);
    }

    public void delete(Long id) {
        typeRepository.delete(id);
    }

    public Boolean uploadPhoto(UploadedFile file, Long id) {
        MultipartFile multipartFile = file.getMultipartFile();
        String uploadedFile = fileHelper.upload(multipartFile);
        Photo photo = new Photo();
        photo.setType(typeRepository.findOne(id));
        photo.setFile(uploadedFile);
        return photoRepository.save(photo) != null;
    }

    public List<Type> findAllByOrderByNameAsc() {
        return typeRepository.findAllByOrderByNameAsc();
    }
}
