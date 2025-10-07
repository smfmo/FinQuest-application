package com.finquest.backend.service;

import com.finquest.backend.dto.request.IndividualGoalRequestDTO;
import com.finquest.backend.model.IndividualGoal;
import com.finquest.backend.repository.IndividualGoalRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.UUID;

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

    public IndividualGoal getById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Goal not found with id: " + id));
    }

    @Transactional
    public IndividualGoal partialUpdate(UUID id, IndividualGoalRequestDTO updatedIndividualGoal) {
        IndividualGoal existingGoal = getById(id);

        if (updatedIndividualGoal.title() != null) {
            existingGoal.setTitle(updatedIndividualGoal.title());
        }
        if (updatedIndividualGoal.description() != null) {
            existingGoal.setDescription(updatedIndividualGoal.description());
        }
        if (updatedIndividualGoal.term() != null) {
            existingGoal.setTerm(updatedIndividualGoal.term());
        }

        return repository.save(existingGoal);
    }
}
