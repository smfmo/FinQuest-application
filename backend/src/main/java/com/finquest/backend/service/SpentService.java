package com.finquest.backend.service;

import com.finquest.backend.model.Spent;
import com.finquest.backend.model.UserEntity;
import com.finquest.backend.model.Wallet;
import com.finquest.backend.repository.SpentRepository;
import com.finquest.backend.security.SecurityService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class SpentService {

    private final SpentRepository repository;
    private final SecurityService securityService;

    public SpentService(SpentRepository repository, SecurityService securityService) {
        this.repository = repository;
        this.securityService = securityService;
    }

    @Transactional
    public Spent save(Spent spent) {
        UserEntity user = spent.getUser();
        Wallet wallet = user.getWallet();

        wallet.setBalance(wallet.getBalance().subtract(spent.getAmountSpent()));

        return repository.save(spent);
    }

    public List<Spent> findAllByUserAuthenticated() {
        UserEntity user = securityService.getUserAuthenticated();
        return repository.findByUser(user);
    }
}
