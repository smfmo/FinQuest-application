package com.finquest.backend.repository;

import com.finquest.backend.model.IndividualGoal;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface IndividualGoalRepository extends JpaRepository<IndividualGoal, UUID> {
}
