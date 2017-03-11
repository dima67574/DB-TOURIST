package com.db.tourist.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

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

    @ManyToOne(fetch = FetchType.EAGER)
    private Photo cover;

    @OneToMany(mappedBy = "epoch", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private Set<Photo> photos = new LinkedHashSet<>();

    @ManyToMany(cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "user_epoch", joinColumns = @JoinColumn(name = "epoch_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
    private Set<User> userList = new HashSet<>();

    @ManyToMany(cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "object_epoch", joinColumns = @JoinColumn(name = "epoch_id"), inverseJoinColumns = @JoinColumn(name = "object_id"))
    private Set<Object> objectList = new HashSet<>();

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

    public Set<Photo> getPhotos() {
        return photos;
    }

    public void setPhotos(Set<Photo> photos) {
        this.photos = photos;
    }

    public Set<User> getUserList() {
        return userList;
    }

    public void setUserList(Set<User> userList) {
        this.userList = userList;
    }

    public Set<Object> getObjectList() {
        return objectList;
    }

    public void setObjectList(Set<Object> objectList) {
        this.objectList = objectList;
    }

    public Photo getCover() {
        return cover;
    }

    public void setCover(Photo cover) {
        this.cover = cover;
    }
}
