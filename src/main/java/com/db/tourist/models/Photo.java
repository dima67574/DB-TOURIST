package com.db.tourist.models;

import javax.persistence.*;

@Entity
@Table(name = "photo")
public class Photo extends BaseEntity {
    @Column(name = "file")
    private String file;

    @ManyToOne(fetch = FetchType.EAGER)
    private Epoch epoch;

    public Photo() {
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public Epoch getEpoch() {
        return epoch;
    }

    public void setEpoch(Epoch epoch) {
        this.epoch = epoch;
    }
}
