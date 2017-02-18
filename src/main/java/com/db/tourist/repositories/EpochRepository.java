package com.db.tourist.repositories;

import com.db.tourist.models.Epoch;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EpochRepository extends JpaRepository<Epoch, Long> {
}
