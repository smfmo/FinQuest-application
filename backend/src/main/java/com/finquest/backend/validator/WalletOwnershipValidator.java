package com.finquest.backend.validator;

import com.finquest.backend.exception.custom.WalletOwnershipException;
import com.finquest.backend.model.Wallet;
import com.finquest.backend.security.SecurityService;
import org.springframework.stereotype.Component;

@Component
public class WalletOwnershipValidator {

    private final SecurityService service;

    public WalletOwnershipValidator(SecurityService service) {
        this.service = service;
    }

    public void validate(Wallet wallet) {
        if (!service.getUserAuthenticated().getWallet().getId().equals(wallet.getId())) {
            throw new WalletOwnershipException("Não é possível adicionar saldo, carteira não corresponde ao usuário");
        }
    }
}
