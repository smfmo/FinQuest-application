package com.finquest.backend.model;

import com.finquest.backend.model.enums.Category;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "spent",
        schema = "public")
@Getter @Setter
public class Spent extends Audit {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String title;

    private String description;

    private LocalDateTime date;

    @Enumerated(EnumType.STRING)
    private Category category;

    private BigDecimal amountSpent;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Spent() {}
}
