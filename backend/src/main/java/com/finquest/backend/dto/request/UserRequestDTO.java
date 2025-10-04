package com.finquest.backend.dto.request;

public record UserRequestDTO(
        String name,
        String username,
        String password,
        String email
) {}
