package com.finquest.backend.dto.response;

import java.time.LocalDateTime;

public record IndividualGoalResponseDTO(
        String title,
        String description,
        LocalDateTime term,
        boolean completed,
        Integer score,
        UserResponseDTO user,
        LocalDateTime createdDate,
        LocalDateTime lastModifiedDate
) {}
