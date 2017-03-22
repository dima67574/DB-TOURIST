package com.db.tourist.services.Impl;

import com.db.tourist.models.Comment;
import com.db.tourist.repositories.CommentRepository;
import com.db.tourist.repositories.ObjectRepository;
import com.db.tourist.services.CommentService;
import com.db.tourist.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private ObjectRepository objectRepository;

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

    public Boolean send(Long objectId, Integer rate, String text, Long userId) {
        Comment c = new Comment();
        c.setDate(new Date());
        c.setChecked(false);
        c.setMark(rate);
        c.setObject(objectRepository.findOne(objectId));
        c.setUser(userService.findOne(userId));
        c.setText(text);
        return commentRepository.save(c) != null;
    }

    public List<Comment> getComments(Long objectId) {
        return commentRepository.findByObjectIdAndCheckedIsTrueOrderByDateDesc(objectId);
    }

    public Integer checkCommented(Long objectId) {
        if(!userService.isAuthentificated())
            return 3;
        List<Comment> comments = commentRepository.findByObjectIdAndUserId(objectId, userService.getUser().getId());
        if(!comments.isEmpty()) {
            Comment c = comments.get(0);
            if(!c.getChecked()) {
                return 1;
            } else {
                return 2;
            }
        }
        return 0;
    }
}
