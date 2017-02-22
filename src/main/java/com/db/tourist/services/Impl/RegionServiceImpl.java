package com.db.tourist.services.Impl;

import com.db.tourist.models.Region;
import com.db.tourist.repositories.RegionRepository;
import com.db.tourist.services.RegionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegionServiceImpl implements RegionService {

    @Autowired
    private RegionRepository regionRepository;

    public List<Region> findAll() {
        return regionRepository.findAll();
    }

    public void delete(Long id) {
        regionRepository.delete(id);
    }

    public Region findOne(Long id) {
        return regionRepository.findOne(id);
    }

    public Region save(Region region) {
        return regionRepository.save(region);
    }
}
