package com.finquest.backend.repository;

import com.finquest.backend.model.IndividualGoal;
import com.finquest.backend.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface IndividualGoalRepository extends JpaRepository<IndividualGoal, UUID> {
    List<IndividualGoal> findByUser(UserEntity user);
}
