package com.finquest.backend.service;

import com.finquest.backend.model.Wallet;
import com.finquest.backend.repository.WalletRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.UUID;

@Service
public class WalletService {

    private final WalletRepository repository;

    public WalletService(WalletRepository repository) {
        this.repository = repository;
    }

    public Wallet addBalance(UUID id, BigDecimal amount) {
        Wallet wallet = getById(id);
        wallet.setBalance(wallet.getBalance().add(amount));
        return repository.save(wallet);
    }

    public Wallet getById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Wallet not found with id: " + id));
    }
}
