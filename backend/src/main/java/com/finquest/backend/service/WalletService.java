package com.finquest.backend.service;

import com.finquest.backend.model.Wallet;
import com.finquest.backend.repository.WalletRepository;
import com.finquest.backend.validator.WalletOwnershipValidator;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.UUID;

@Service
public class WalletService {

    private final WalletRepository repository;
    private final WalletOwnershipValidator walletOwnershipValidator;

    public WalletService(WalletRepository repository, WalletOwnershipValidator walletOwnershipValidator) {
        this.repository = repository;
        this.walletOwnershipValidator = walletOwnershipValidator;
    }

    public Wallet addBalance(UUID id, BigDecimal amount) {
        Wallet wallet = getById(id);
        walletOwnershipValidator.validate(wallet);
        wallet.setBalance(wallet.getBalance().add(amount));
        return repository.save(wallet);
    }

    public Wallet getById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Wallet not found with id: " + id));
    }
}
