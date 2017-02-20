package com.db.tourist.models;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "epoch")
public class Epoch extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition="LONGTEXT")
    private String description;

    @Column(name = "start_year")
    private Integer startYear;

    @Column(name = "finish_year")
    private Integer finishYear;

    @OneToMany(mappedBy = "epoch", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private List<Photo> photos = new ArrayList<>();

    @ManyToMany(cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "user_epoch", joinColumns = @JoinColumn(name = "epoch_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<User> userList = new ArrayList<>();

    public Epoch() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getStartYear() {
        return startYear;
    }

    public void setStartYear(Integer startYear) {
        this.startYear = startYear;
    }

    public Integer getFinishYear() {
        return finishYear;
    }

    public void setFinishYear(Integer finishYear) {
        this.finishYear = finishYear;
    }

    public List<Photo> getPhotos() {
        return photos;
    }

    public void setPhotos(List<Photo> photos) {
        this.photos = photos;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}
