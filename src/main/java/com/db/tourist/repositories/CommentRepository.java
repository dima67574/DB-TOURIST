package com.db.tourist.repositories;

import com.db.tourist.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByCheckedIsTrue();

    List<Comment> findByCheckedIsFalse();

    @Query("select count(f) from Comment f where f.checked = 0")
    Integer getNotCheckedCount();

    List<Comment> findByObjectIdAndUserId(Long objectId, Long userId);

    List<Comment> findByObjectIdAndCheckedIsTrueOrderByDateDesc(Long objectId);
}
