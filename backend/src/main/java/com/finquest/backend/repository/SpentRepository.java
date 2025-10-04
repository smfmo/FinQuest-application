package com.finquest.backend.repository;

import com.finquest.backend.model.Spent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface SpentRepository extends JpaRepository<Spent, UUID> {

}
