package com.db.tourist.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "locality")
public class Locality extends BaseEntity {

    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    private District district;

    @OneToMany(mappedBy = "locality", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private Set<Object> objects = new HashSet<>();

    public Locality() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
    }

    public Set<Object> getObjects() {
        return objects;
    }

    public void setObjects(Set<Object> objects) {
        this.objects = objects;
    }
}
