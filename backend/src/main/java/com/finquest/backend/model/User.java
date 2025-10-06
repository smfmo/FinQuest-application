package com.finquest.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "app_user",
        schema = "public")
@Getter @Setter
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
}
