package com.finquest.backend.dto.response;

import com.finquest.backend.model.enums.Category;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record SpentResponseDTO(
        String title,
        String description,
        LocalDateTime date,
        Category category,
        BigDecimal amountSpent,
        UserResponseDTO user
) {}
