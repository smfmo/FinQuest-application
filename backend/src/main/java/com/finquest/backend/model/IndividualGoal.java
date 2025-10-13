package com.finquest.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "individual_goal",
        schema = "public")
@Getter @Setter
public class IndividualGoal extends Audit {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "term")
    private LocalDateTime term;

    @Column(name = "completed")
    private boolean completed = false;

    @Column(name = "score")
    private final Integer score = 20;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    public IndividualGoal() {}
}
