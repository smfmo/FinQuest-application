package com.finquest.backend.model;

import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "app_user",
        schema = "public")
@EntityListeners(AuditingEntityListener.class)
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "name")
    private String name;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "email")
    private String email;

    @OneToMany(mappedBy = "user",
                cascade = CascadeType.ALL,
                orphanRemoval = true)
    private List<Spent> spents;

    @OneToMany(mappedBy = "user",
                cascade = CascadeType.ALL,
                orphanRemoval = true)
    private List<IndividualGoal> individualGoals;

    @CreatedDate
    private LocalDateTime createdDate;

    public User() {}

    public User(String name, String username, String password, String email,
                List<Spent> spents, LocalDateTime createdDate) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.spents = spents;
        this.createdDate = createdDate;
    }

    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public List<Spent> getSpents() {
        return spents;
    }
    public void setSpents(List<Spent> spents) {
        this.spents = spents;
    }
    public LocalDateTime getCreatedDate() {
        return createdDate;
    }
    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
}
