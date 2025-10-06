package com.finquest.backend.model;

import com.finquest.backend.model.enums.Category;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "spent",
        schema = "public")
@Getter @Setter
@EntityListeners(AuditingEntityListener.class)
public class Spent {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String title;

    private String description;

    private LocalDateTime date;

    @Enumerated(EnumType.STRING)
    private Category category;

    private Double amountSpent;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @CreatedDate
    private LocalDateTime createdDate;

    public Spent() {}

    public Spent(UUID id, String title, String description,
                 LocalDateTime date, Category category, Double amountSpent, User user) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.date = date;
        this.category = category;
        this.amountSpent = amountSpent;
        this.user = user;
    }
}
