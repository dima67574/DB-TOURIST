package com.db.tourist.services.Impl;

import com.db.tourist.models.Locality;
import com.db.tourist.repositories.LocalityRepository;
import com.db.tourist.services.LocalityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LocalityServiceImpl implements LocalityService{

    @Autowired
    private LocalityRepository localityRepository;

    public List<Locality> findAll() {
        return localityRepository.findAll();
    }

    public void delete(Long id) {
        localityRepository.delete(id);
    }

    public Locality findOne(Long id) {
        return localityRepository.findOne(id);
    }

    public Locality save(Locality locality) {
        return localityRepository.save(locality);
    }

    public List<Locality> findByDistrictId(Long id) {
        return localityRepository.findByDistrictId(id);
    }

    public List<Locality> findAllByOrderByNameAsc() {
        return localityRepository.findAllByOrderByNameAsc();
    }
}
