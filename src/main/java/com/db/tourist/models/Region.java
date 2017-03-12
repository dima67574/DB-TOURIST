package com.db.tourist.models;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "region")
public class Region extends BaseEntity {

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "region", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private List<District> districts = new ArrayList<>();

    public Region() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<District> getDistricts() {
        return districts;
    }

    public void setDistricts(List<District> districts) {
        this.districts = districts;
    }
}
