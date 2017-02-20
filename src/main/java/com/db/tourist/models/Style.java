package com.db.tourist.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "style")
public class Style extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition="LONGTEXT")
    private String description;

    public Style() {
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
}
