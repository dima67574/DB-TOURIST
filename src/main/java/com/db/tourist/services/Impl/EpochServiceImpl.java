package com.db.tourist.services.Impl;

import com.db.tourist.models.Epoch;
import com.db.tourist.models.Photo;
import com.db.tourist.repositories.EpochRepository;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.services.EpochService;
import com.db.tourist.utils.FileHelper;
import com.db.tourist.utils.UploadedFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class EpochServiceImpl implements EpochService {
    @Autowired
    private EpochRepository epochRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileHelper fileHelper;

    public List<Epoch> findAll() {
        return epochRepository.findAll();
    }

    public void delete(Long id) {
        epochRepository.delete(id);
    }

    public Epoch save(Epoch epoch) {
        return epochRepository.save(epoch);
    }

    public Epoch findOne(Long id) {
        return epochRepository.findOne(id);
    }

    public Boolean uploadPhoto(UploadedFile file, Long id) {
        MultipartFile multipartFile = file.getMultipartFile();
        String uploadedFile = fileHelper.upload(multipartFile);
        Photo photo = new Photo();
        photo.setEpoch(epochRepository.findOne(id));
        photo.setFile(uploadedFile);
        return photoRepository.save(photo) != null;
    }

    public List<Epoch> findAllByOrderByNameAsc() {
        return epochRepository.findAllByOrderByNameAsc();
    }
}
