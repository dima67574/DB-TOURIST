package com.db.tourist.services.Impl;

import com.db.tourist.models.Comment;
import com.db.tourist.repositories.CommentRepository;
import com.db.tourist.services.CommentService;
import com.db.tourist.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private UserService userService;

    public List<Comment> findChecked() {
        return commentRepository.findByCheckedIsTrue();
    }

    public List<Comment> findNotChecked() {
        return commentRepository.findByCheckedIsFalse();
    }

    public Integer getNotCheckedCount() {
        return commentRepository.getNotCheckedCount();
    }

    public Comment findOne(Long id) {
        return commentRepository.findOne(id);
    }

    public void delete(Long id) {
        commentRepository.delete(id);
    }

    public Boolean check(Long id) {
        Comment comment = commentRepository.findOne(id);
        comment.setChecked(true);
        comment.setModerator(userService.getUser());
        return commentRepository.save(comment) != null;
    }
}
