package com.finquest.backend.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UserRequestDTO(
        @NotBlank(message = "Nome obrigatório")
        @Size(min = 15, max = 255)
        String name,
        @NotBlank(message = "Nome de usuário obrigatório")
        @Size(min = 15, max = 255)
        String username,
        @NotBlank(message = "Senha é obrigatória")
        @Size(min = 15, max = 255)
        String password,
        @NotBlank(message = "Email é obrigatório")
        @Email(message = "Deve ser um email válido")
        String email
) {}
