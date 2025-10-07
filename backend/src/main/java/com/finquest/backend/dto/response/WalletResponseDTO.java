package com.finquest.backend.dto.response;

import java.math.BigDecimal;

public record WalletResponseDTO(
        BigDecimal balance
) {}
