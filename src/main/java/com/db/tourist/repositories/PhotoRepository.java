package com.db.tourist.repositories;

import com.db.tourist.models.Photo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PhotoRepository extends JpaRepository<Photo, Long> {
    Photo findByFile(String file);
}
