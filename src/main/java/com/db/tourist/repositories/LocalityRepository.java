package com.db.tourist.repositories;

import com.db.tourist.models.Locality;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocalityRepository extends JpaRepository<Locality, Long> {
}
