package com.db.tourist.models;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "district")
public class District extends BaseEntity {

    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    private Region region;

    @OneToMany(mappedBy = "district", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private List<Locality> localities = new ArrayList<>();

    public District() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Region getRegion() {
        return region;
    }

    public void setRegion(Region region) {
        this.region = region;
    }

    public List<Locality> getLocalities() {
        return localities;
    }

    public void setLocalities(List<Locality> localities) {
        this.localities = localities;
    }
}
