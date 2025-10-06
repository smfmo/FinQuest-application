package com.finquest.backend.dto.request;

import java.time.LocalDateTime;
import java.util.UUID;

public record IndividualGoalRequestDTO(
        String title,
        String description,
        LocalDateTime term,
        UUID userId
) {}
