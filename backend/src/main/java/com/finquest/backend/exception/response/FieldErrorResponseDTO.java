package com.finquest.backend.exception.response;

public record FieldErrorResponseDTO(
        String field,
        String error
) {}
