package com.db.tourist.services;

import com.db.tourist.models.Object;
import com.db.tourist.utils.UploadedFile;

import java.util.List;

public interface ObjectService {
    List<Object> findAll();

    Object findOne(Long id);

    void delete(Long id);

    Object save(Object object, List<Long> epochs, List<Long> types, List<Long> styles, List<Integer> years);

    Boolean uploadPhoto(UploadedFile file, Long id);

    List<Object> findByLocalityId(Long id);
}
