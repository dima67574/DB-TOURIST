package com.db.tourist.services;

import com.db.tourist.models.Style;

import java.util.List;

public interface StyleService {
    List<Style> findAll();

    Style findOne(Long id);
}
