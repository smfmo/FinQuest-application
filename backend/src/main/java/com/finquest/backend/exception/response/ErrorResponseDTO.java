package com.finquest.backend.exception.response;

import java.util.List;

public record ErrorResponseDTO(
        int statusCode,
        String message,
        List<FieldErrorResponseDTO> errors
) {}
