package com.db.tourist.repositories;

import com.db.tourist.models.StaticPage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StaticPageRepository extends JpaRepository<StaticPage, Long> {
    StaticPage findOneByUrl(String url);
}
