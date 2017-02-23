package com.db.tourist.repositories;

import com.db.tourist.models.District;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DistrictRepository extends JpaRepository<District, Long> {
    List<District> findByRegionId(Long id);
}
