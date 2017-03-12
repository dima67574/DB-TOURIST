package com.db.tourist.services;

import com.db.tourist.models.Locality;

import java.util.List;

public interface LocalityService {
    List<Locality> findAll();

    void delete(Long id);

    Locality findOne(Long id);

    Locality save(Locality locality);

    List<Locality> findByDistrictId(Long id);

    List<Locality> findAllByOrderByNameAsc();
}
