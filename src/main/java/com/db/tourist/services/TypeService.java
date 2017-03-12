package com.db.tourist.services;

import com.db.tourist.models.Type;
import com.db.tourist.utils.UploadedFile;

import java.util.List;

public interface TypeService {
    List<Type> findAll();

    Type findOne(Long id);

    void delete(Long id);

    Type save(Type type);

    Boolean uploadPhoto(UploadedFile file, Long id);

    List<Type> findAllByOrderByNameAsc();
}
