package com.db.tourist.models;

import javax.persistence.*;

@Entity
@Table(name = "object_year")
public class ObjectYear extends BaseEntity {
    @Column(name = "year")
    private Integer year;

    @ManyToOne(fetch = FetchType.LAZY)
    private Object object;

    public ObjectYear() {
    }

    public ObjectYear(Object object, Integer year) {
        this.object = object;
        this.year = year;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
