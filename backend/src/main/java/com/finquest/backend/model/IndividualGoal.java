package com.finquest.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "individual_goal",
        schema = "public")
@Getter @Setter
@EntityListeners(AuditingEntityListener.class)
public class IndividualGoal {

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
    private User user;

    @CreatedDate
    private LocalDateTime createdDate;

    @LastModifiedDate
    private LocalDateTime lastModifiedDate;

    public IndividualGoal() {}

    public IndividualGoal(UUID id, String title, String description, LocalDateTime term,
                            boolean completed, User user) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.term = term;
        this.completed = completed;
        this.user = user;
    }
}
