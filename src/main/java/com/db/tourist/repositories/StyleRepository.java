package com.db.tourist.repositories;

import com.db.tourist.models.Style;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StyleRepository extends JpaRepository<Style, Long> {
    List<Style> findAllByOrderByNameAsc();
}
