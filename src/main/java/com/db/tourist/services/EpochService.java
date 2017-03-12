package com.db.tourist.services;

import com.db.tourist.models.Epoch;
import com.db.tourist.utils.UploadedFile;

import java.util.List;

public interface EpochService {
    List<Epoch> findAll();

    Epoch findOne(Long id);

    void delete(Long id);

    Epoch save(Epoch epoch);

    Boolean uploadPhoto(UploadedFile file, Long id);

    List<Epoch> findAllByOrderByNameAsc();
}
