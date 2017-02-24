package com.db.tourist.models;

import javax.persistence.*;

@Entity
@Table(name = "photo")
public class Photo extends BaseEntity {
    @Column(name = "file")
    private String file;

    @ManyToOne(fetch = FetchType.EAGER)
    private Epoch epoch;

    @ManyToOne(fetch = FetchType.EAGER)
    private Style style;

    @ManyToOne(fetch = FetchType.EAGER)
    private Type type;

    @ManyToOne(fetch = FetchType.EAGER)
    private Object object;

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

    public Style getStyle() {
        return style;
    }

    public void setStyle(Style style) {
        this.style = style;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
