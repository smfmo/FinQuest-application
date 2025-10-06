package com.finquest.backend.controller;

import com.finquest.backend.dto.request.IndividualGoalRequestDTO;
import com.finquest.backend.dto.response.IndividualGoalResponseDTO;
import com.finquest.backend.mapper.IndividualGoalMapper;
import com.finquest.backend.model.IndividualGoal;
import com.finquest.backend.service.IndividualGoalService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/individualGoals")
public class IndividualGoalController {

    private final IndividualGoalService service;
    private final IndividualGoalMapper mapper;

    public IndividualGoalController(IndividualGoalService service, IndividualGoalMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @PostMapping
    public ResponseEntity<IndividualGoalResponseDTO> save(@RequestBody IndividualGoalRequestDTO request) {
        IndividualGoal goal = mapper.toEntity(request);
        var entitySaved = service.save(goal);
        return ResponseEntity.ok(mapper.toDto(entitySaved));
    }

    @GetMapping
    public ResponseEntity<List<IndividualGoalResponseDTO>> findAll() {
        List<IndividualGoal> result = service.findAll();
        return ResponseEntity.ok(mapper.toDto(result));
    }
}
