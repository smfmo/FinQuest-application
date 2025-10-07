package com.finquest.backend.dto.request;

import com.finquest.backend.model.enums.Category;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record SpentRequestDTO(
        String title,
        String description,
        LocalDateTime date,
        Category category,
        BigDecimal amountSpent,
        UUID userId
) {}
