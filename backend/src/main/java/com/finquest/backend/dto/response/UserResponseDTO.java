package com.finquest.backend.dto.response;

import java.util.UUID;

public record UserResponseDTO(
        UUID id,
        String name,
        String username,
        String email,
        WalletResponseDTO wallet
) {}
