package com.db.tourist.repositories;

import com.db.tourist.models.Epoch;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EpochRepository extends JpaRepository<Epoch, Long> {
    List<Epoch> findAllByOrderByNameAsc();
}
