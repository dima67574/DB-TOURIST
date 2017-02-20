package com.db.tourist.services;

import com.db.tourist.models.Type;

import java.util.List;

public interface TypeService {
    List<Type> findAll();

    Type findOne(Long id);
}
