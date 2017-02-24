package com.db.tourist.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "type")
public class Type extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition="LONGTEXT")
    private String description;

    @OneToMany(mappedBy = "type", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private Set<Photo> photos = new HashSet<>();

    @ManyToMany(cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "user_type", joinColumns = @JoinColumn(name = "type_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
    private Set<User> userList = new HashSet<>();

    @ManyToMany(cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "object_type", joinColumns = @JoinColumn(name = "type_id"), inverseJoinColumns = @JoinColumn(name = "object_id"))
    private Set<Object> objectList = new HashSet<>();

    public Type() {
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
}
