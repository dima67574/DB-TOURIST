package com.db.tourist.services;

import com.db.tourist.models.Region;

import java.util.List;

public interface RegionService {
    List<Region> findAll();

    void delete(Long id);

    Region findOne(Long id);

    Region save(Region region);
}
