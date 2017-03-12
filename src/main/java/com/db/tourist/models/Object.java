package com.db.tourist.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "object")
public class Object extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition="LONGTEXT")
    private String description;

    @ManyToOne(fetch = FetchType.EAGER)
    private Locality locality;

    @ManyToOne(fetch = FetchType.EAGER)
    private Object parent;

    @OneToMany(mappedBy = "parent", fetch = FetchType.EAGER, cascade= CascadeType.REMOVE, orphanRemoval = true)
    private Set<Object> childObjects = new HashSet<>();

    @OneToMany(mappedBy = "object", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private Set<Photo> photos = new LinkedHashSet<>();

    @OneToMany(mappedBy = "object", fetch = FetchType.EAGER, cascade= CascadeType.ALL, orphanRemoval = true)
    private Set<ObjectYear> yearList = new HashSet<>();

    @Column(name = "x_coordinate")
    private String xCoordinate;

    @Column(name = "y_coordinate")
    private String yCoordinate;

    @Column(name = "address")
    private String address;

    @ManyToOne(fetch = FetchType.EAGER)
    private User author;

    @ManyToMany(fetch = FetchType.EAGER, cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "object_epoch", joinColumns = @JoinColumn(name = "object_id"), inverseJoinColumns = @JoinColumn(name = "epoch_id"))
    private Set<Epoch> epochList = new HashSet<>();

    @ManyToMany(fetch = FetchType.EAGER, cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "object_type", joinColumns = @JoinColumn(name = "object_id"), inverseJoinColumns = @JoinColumn(name = "type_id"))
    private Set<Type> typeList = new HashSet<>();

    @ManyToMany(fetch = FetchType.EAGER, cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "object_style", joinColumns = @JoinColumn(name = "object_id"), inverseJoinColumns = @JoinColumn(name = "style_id"))
    private Set<Style> styleList = new HashSet<>();

    @ManyToOne(fetch = FetchType.EAGER)
    private Photo cover;

    public Object() {
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

    public Locality getLocality() {
        return locality;
    }

    public void setLocality(Locality locality) {
        this.locality = locality;
    }

    public Object getParent() {
        return parent;
    }

    public void setParent(Object parent) {
        this.parent = parent;
    }

    public Set<Object> getChildObjects() {
        return childObjects;
    }

    public void setChildObjects(Set<Object> childObjects) {
        this.childObjects = childObjects;
    }

    public String getxCoordinate() {
        return xCoordinate;
    }

    public void setxCoordinate(String xCoordinate) {
        this.xCoordinate = xCoordinate;
    }

    public String getyCoordinate() {
        return yCoordinate;
    }

    public void setyCoordinate(String yCoordinate) {
        this.yCoordinate = yCoordinate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Set<Epoch> getEpochList() {
        return epochList;
    }

    public void setEpochList(Set<Epoch> epochList) {
        this.epochList = epochList;
    }

    public Set<Type> getTypeList() {
        return typeList;
    }

    public void setTypeList(Set<Type> typeList) {
        this.typeList = typeList;
    }

    public Set<Style> getStyleList() {
        return styleList;
    }

    public void setStyleList(Set<Style> styleList) {
        this.styleList = styleList;
    }

    public Set<Photo> getPhotos() {
        return photos;
    }

    public void setPhotos(Set<Photo> photos) {
        this.photos = photos;
    }

    public Set<ObjectYear> getYearList() {
        return yearList;
    }

    public void setYearList(Set<ObjectYear> yearList) {
        this.yearList = yearList;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Photo getCover() {
        return cover;
    }

    public void setCover(Photo cover) {
        this.cover = cover;
    }

    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Object object = o;

        return getId() != null ? getId().equals(object.getId()) : object.getId() == null;
    }

    @Override
    public int hashCode() {
        return getId() != null ? getId().hashCode() : 0;
    }
}
