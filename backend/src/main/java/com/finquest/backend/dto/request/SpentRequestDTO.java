package com.finquest.backend.dto.request;

import com.finquest.backend.model.enums.Category;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record SpentRequestDTO(
        @NotBlank(message = "Título Obrigatório")
        @Size(min = 5, max = 100)
        String title,
        @NotBlank(message = "Descrição deve ser obrigatória")
        String description,
        @FutureOrPresent
        @NotNull(message = "Data obrigatória")
        LocalDateTime date,
        @NotNull(message = "Categoria obrigatória")
        Category category,
        BigDecimal amountSpent,
        UUID userId
) {}
