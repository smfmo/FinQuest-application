package com.finquest.backend.service;

import com.finquest.backend.model.Spent;
import com.finquest.backend.repository.SpentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SpentService {

    private final SpentRepository repository;

    public SpentService(SpentRepository repository) {
        this.repository = repository;
    }

    @Transactional
    public Spent save(Spent spent) {
        return repository.save(spent);
    }

    public List<Spent> findAll() {
        return repository.findAll();
    }

}
