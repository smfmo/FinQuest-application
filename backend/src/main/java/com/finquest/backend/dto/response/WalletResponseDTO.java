package com.finquest.backend.dto.response;

import java.math.BigDecimal;
import java.util.UUID;

public record WalletResponseDTO(
        UUID id,
        BigDecimal balance
) {}
