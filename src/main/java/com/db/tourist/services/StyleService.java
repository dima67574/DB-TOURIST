package com.db.tourist.services;

import com.db.tourist.models.Style;
import com.db.tourist.utils.UploadedFile;

import java.util.List;

public interface StyleService {
    List<Style> findAll();

    Style findOne(Long id);

    void delete(Long id);

    Style save(Style style);

    Boolean uploadPhoto(UploadedFile file, Long id);

    List<Style> findAllByOrderByNameAsc();
}
