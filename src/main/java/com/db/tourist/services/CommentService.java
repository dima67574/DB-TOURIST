package com.db.tourist.services;

import com.db.tourist.models.Comment;

import java.util.List;

public interface CommentService {
    List<Comment> findChecked();

    List<Comment> findNotChecked();

    Integer getNotCheckedCount();

    Comment findOne(Long id);

    void delete(Long id);

    Boolean check(Long id);
}
