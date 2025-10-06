package com.finquest.backend.service;

import com.finquest.backend.model.IndividualGoal;
import com.finquest.backend.repository.IndividualGoalRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class IndividualGoalService {

    private final IndividualGoalRepository repository;

    public IndividualGoalService(IndividualGoalRepository repository) {
        this.repository = repository;
    }

    @Transactional
    public IndividualGoal save(IndividualGoal goal) {
        return repository.save(goal);
    }

    public List<IndividualGoal> findAll() {
        return repository.findAll();
    }
}
