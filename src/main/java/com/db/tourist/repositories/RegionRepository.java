package com.db.tourist.repositories;

import com.db.tourist.models.Region;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RegionRepository extends JpaRepository<Region, Long> {
    List<Region> findAllByOrderByNameAsc();
}
