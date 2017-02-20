package com.db.tourist.services.Impl;

import com.db.tourist.models.Style;
import com.db.tourist.repositories.StyleRepository;
import com.db.tourist.services.StyleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StyleServiceImpl implements StyleService {

    @Autowired
    private StyleRepository styleRepository;

    public List<Style> findAll() {
        return styleRepository.findAll();
    }

    public Style findOne(Long id) {
        return styleRepository.findOne(id);
    }
}
