package com.db.tourist.models;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "comment")
public class Comment extends BaseEntity {
    @Column(name = "text", columnDefinition="LONGTEXT")
    private String text;

    @Column(name = "mark")
    private Integer mark;

    @Column(name = "checked", columnDefinition = "boolean default false", nullable = false)
    private Boolean checked;

    @Column(name = "date")
    private Date date;

    @ManyToOne(fetch = FetchType.EAGER)
    private Object object;

    @ManyToOne(fetch = FetchType.EAGER)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    private User moderator;

    public Comment() {
        checked = false;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Integer getMark() {
        return mark;
    }

    public void setMark(Integer mark) {
        this.mark = mark;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getModerator() {
        return moderator;
    }

    public void setModerator(User moderator) {
        this.moderator = moderator;
    }
}
