package com.finquest.backend.repository;

import com.finquest.backend.model.Spent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface SpentRepository extends JpaRepository<Spent, UUID> {

}
