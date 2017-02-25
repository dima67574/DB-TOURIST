package com.db.tourist.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "user")
public class User extends BaseEntity {

    @Column(name = "name")
    private String name;

    @Column(name = "surname")
    private String surname;

    @Column(name = "patronymic")
    private String patronymic;

    @Column(name = "login")
    private String login;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "token")
    private String token;

    @Column(name = "phone_number")
    private String phoneNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    private Role role;

    @Column(name = "banned", columnDefinition = "boolean default false", nullable = false)
    private Boolean banned;

    @ManyToMany(fetch = FetchType.EAGER, cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "user_epoch", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "epoch_id"))
    private Set<Epoch> epochList = new HashSet<>();

    @ManyToMany(fetch = FetchType.EAGER, cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "user_type", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "type_id"))
    private Set<Type> typeList = new HashSet<>();

    @ManyToMany(fetch = FetchType.EAGER, cascade ={CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "user_style", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "style_id"))
    private Set<Style> styleList = new HashSet<>();

    @OneToMany(mappedBy = "author", fetch = FetchType.EAGER, cascade=CascadeType.REMOVE, orphanRemoval = true)
    private Set<Object> objects = new HashSet<>();

    public User() {
        banned = false;
    }

    public String getFio() {
        return surname + " " + name.substring(0, 1) + ". " + patronymic.substring(0, 1) + ".";
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Boolean getBanned() {
        return banned;
    }

    public void setBanned(Boolean banned) {
        this.banned = banned;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPatronymic() {
        return patronymic;
    }

    public void setPatronymic(String patronymic) {
        this.patronymic = patronymic;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
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

    public Set<Object> getObjects() {
        return objects;
    }

    public void setObjects(Set<Object> objects) {
        this.objects = objects;
    }
}
