package com.db.tourist.services.Impl;

import com.db.tourist.models.District;
import com.db.tourist.repositories.DistrictRepository;
import com.db.tourist.services.DistrictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DistrictServiceImpl implements DistrictService {

    @Autowired
    private DistrictRepository districtRepository;

    public List<District> findAll() {
        return districtRepository.findAll();
    }

    public void delete(Long id) {
        districtRepository.delete(id);
    }

    public District findOne(Long id) {
        return districtRepository.findOne(id);
    }

    public District save(District district) {
        return districtRepository.save(district);
    }

    public List<District> findByRegionId(Long id) {
        return districtRepository.findByRegionId(id);
    }
}
