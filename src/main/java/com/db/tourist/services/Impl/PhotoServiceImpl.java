package com.db.tourist.services.Impl;

import com.db.tourist.models.*;
import com.db.tourist.models.Object;
import com.db.tourist.repositories.*;
import com.db.tourist.services.PhotoService;
import com.db.tourist.utils.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.IOException;

@Service
public class PhotoServiceImpl implements PhotoService {
    @Autowired
    private FileHelper fileHelper;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private ObjectRepository objectRepository;

    @Autowired
    private EpochRepository epochRepository;

    @Autowired
    private StyleRepository styleRepository;

    @Autowired
    private TypeRepository typeRepository;

    @Transactional
    public Boolean deletePhoto(String photo) {
        if(fileHelper.delete(photo)) {
            Photo p = photoRepository.findByFile(photo);
            if(p != null) {
                if(p.getObject() != null) {
                    Object o = p.getObject();
                    if(o.getCover() != null && o.getCover().getId().equals(p.getId())) {
                        o.setCover(null);
                        objectRepository.save(o);
                    }
                }
                if(p.getEpoch() != null) {
                    Epoch o = p.getEpoch();
                    if(o.getCover() != null && o.getCover().getId().equals(p.getId())) {
                        o.setCover(null);
                        epochRepository.save(o);
                    }
                }
                if(p.getType() != null) {
                    Type o = p.getType();
                    if(o.getCover() != null && o.getCover().getId().equals(p.getId())) {
                        o.setCover(null);
                        typeRepository.save(o);
                    }
                }
                if(p.getStyle() != null) {
                    Style o = p.getStyle();
                    if(o.getCover() != null && o.getCover().getId().equals(p.getId())) {
                        o.setCover(null);
                        styleRepository.save(o);
                    }
                }
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

    public Photo findOne(Long id) {
        return photoRepository.findOne(id);
    }
}
