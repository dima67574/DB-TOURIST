package com.db.tourist.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "region")
public class Region extends BaseEntity {

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "region", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private Set<District> districts = new HashSet<>();

    public Region() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<District> getDistricts() {
        return districts;
    }

    public void setDistricts(Set<District> districts) {
        this.districts = districts;
    }
}
