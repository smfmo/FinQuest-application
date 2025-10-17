package com.finquest.backend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UserRequestDTO(
        @NotBlank(message = "Nome obrigatório")
        @Size(min = 15, max = 255)
        String name,
        String username,
        String password,
        String email
) {}
