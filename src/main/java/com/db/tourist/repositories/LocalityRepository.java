package com.db.tourist.repositories;

import com.db.tourist.models.Locality;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LocalityRepository extends JpaRepository<Locality, Long> {
    List<Locality> findByDistrictId(Long id);
    List<Locality> findAllByOrderByNameAsc();
}
