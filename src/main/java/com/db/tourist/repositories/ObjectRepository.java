package com.db.tourist.repositories;

import com.db.tourist.models.Object;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ObjectRepository extends JpaRepository<Object, Long> {
    List<Object> findByLocalityId(Long id);
    List<Object> findAllByOrderByNameAsc();
    List<Object> findByLocalityIdOrderByNameAsc(Long id);
}
