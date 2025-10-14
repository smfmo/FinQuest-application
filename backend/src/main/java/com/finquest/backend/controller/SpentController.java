package com.finquest.backend.controller;

import com.finquest.backend.dto.request.SpentRequestDTO;
import com.finquest.backend.dto.response.SpentResponseDTO;
import com.finquest.backend.mapper.SpentMapper;
import com.finquest.backend.model.Spent;
import com.finquest.backend.service.SpentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/spents")
public class SpentController {

    private final SpentService service;
    private final SpentMapper mapper;

    public SpentController(SpentService service,  SpentMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @PostMapping
    public ResponseEntity<SpentResponseDTO> save(@RequestBody SpentRequestDTO request) {
        Spent spent = mapper.toEntity(request);
        var entitySaved = service.save(spent);

        return ResponseEntity.ok(mapper.toDto(entitySaved));
    }

    @GetMapping
    public ResponseEntity<List<SpentResponseDTO>> findAll() {
        List<Spent> spents = service.findAllByUserAuthenticated();
        return ResponseEntity.ok(mapper.toDto(spents));
    }
}
