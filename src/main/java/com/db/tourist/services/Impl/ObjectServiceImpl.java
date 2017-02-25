package com.db.tourist.services.Impl;

import com.db.tourist.models.*;
import com.db.tourist.models.Object;
import com.db.tourist.repositories.ObjectRepository;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.services.*;
import com.db.tourist.utils.FileHelper;
import com.db.tourist.utils.UploadedFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class ObjectServiceImpl implements ObjectService {
    @Autowired
    private ObjectRepository objectRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileHelper fileHelper;

    @Autowired
    private EpochService epochService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private StyleService styleService;

    @Autowired
    private UserService userService;

    public List<Object> findAll() {
        return objectRepository.findAll();
    }

    public void delete(Long id) {
        objectRepository.delete(id);
    }

    public Object save(Object object, List<Long> epochs, List<Long> types, List<Long> styles, List<Integer> years) {
        Set<Epoch> epochList = new HashSet<>();
        Set<Type> typeList = new HashSet<>();
        Set<Style> styleList = new HashSet<>();
        Set<ObjectYear> yearList = new HashSet<>();
        if(epochs != null) epochs.forEach(id -> epochList.add(epochService.findOne(id)));
        if(types != null) types.forEach(id -> typeList.add(typeService.findOne(id)));
        if(styles != null) styles.forEach(id -> styleList.add(styleService.findOne(id)));
        if(object.getParent() != null && object.getParent().getId() == null) object.setParent(null);
        if(object.getId() == null) object.setAuthor(userService.getUser());
        Object o = objectRepository.save(object);
        o.setEpochList(epochList);
        o.setTypeList(typeList);
        o.setStyleList(styleList);
        if(years != null) years.forEach(year -> yearList.add(new ObjectYear(o, year)));
        o.setYearList(yearList);
        return objectRepository.save(o);
    }

    public Object findOne(Long id) {
        return objectRepository.findOne(id);
    }

    public Boolean uploadPhoto(UploadedFile file, Long id) {
        MultipartFile multipartFile = file.getMultipartFile();
        String uploadedFile = fileHelper.upload(multipartFile);
        Photo photo = new Photo();
        photo.setObject(objectRepository.findOne(id));
        photo.setFile(uploadedFile);
        return photoRepository.save(photo) != null;
    }

    public List<Object> findByLocalityId(Long id) {
        return objectRepository.findByLocalityId(id);
    }


}
