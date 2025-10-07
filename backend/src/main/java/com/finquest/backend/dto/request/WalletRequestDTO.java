package com.finquest.backend.dto.request;

import java.math.BigDecimal;

public record WalletRequestDTO(
        BigDecimal amount
) {}
