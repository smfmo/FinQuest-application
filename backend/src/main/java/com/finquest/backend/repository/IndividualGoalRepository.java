package com.finquest.backend.repository;

import com.finquest.backend.model.IndividualGoal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface IndividualGoalRepository extends JpaRepository<IndividualGoal, UUID> {
}
