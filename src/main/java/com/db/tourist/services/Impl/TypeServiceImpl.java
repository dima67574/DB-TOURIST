package com.db.tourist.services.Impl;

import com.db.tourist.models.Type;
import com.db.tourist.repositories.TypeRepository;
import com.db.tourist.services.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {
    @Autowired
    private TypeRepository typeRepository;

    public List<Type> findAll() {
        return typeRepository.findAll();
    }

    public Type findOne(Long id) {
        return typeRepository.findOne(id);
    }
}
