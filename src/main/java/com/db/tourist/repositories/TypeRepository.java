package com.db.tourist.repositories;

import com.db.tourist.models.Type;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TypeRepository extends JpaRepository<Type, Long> {
    List<Type> findAllByOrderByNameAsc();
}
