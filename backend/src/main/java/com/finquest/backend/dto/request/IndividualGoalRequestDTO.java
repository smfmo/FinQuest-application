package com.finquest.backend.dto.request;

import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.UUID;

public record IndividualGoalRequestDTO(
        @NotBlank(message = "Titulo obrigatório")
        @Size(min = 5, max = 100)
        String title,
        @NotBlank(message = "Descrição obrigatória")
        String description,
        @NotNull(message = "Prazo obrigatório")
        @Future
        LocalDateTime term,
        UUID userId
) {}
