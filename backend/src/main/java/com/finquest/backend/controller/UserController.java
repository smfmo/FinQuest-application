package com.finquest.backend.controller;

import com.finquest.backend.dto.request.UserRequestDTO;
import com.finquest.backend.dto.response.UserResponseDTO;
import com.finquest.backend.mapper.UserMapper;
import com.finquest.backend.model.UserEntity;
import com.finquest.backend.service.UserEntityService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserEntityService service;
    private final UserMapper mapper;

    public UserController(UserEntityService service, UserMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @PostMapping
    public ResponseEntity<UserResponseDTO> save(@RequestBody UserRequestDTO request) {
        UserEntity user = mapper.toEntity(request);
        var entitySaved = service.save(user);

        return ResponseEntity.ok(mapper.toDto(entitySaved));
    }

    @GetMapping
    public ResponseEntity<List<UserResponseDTO>> findAll() {
        List<UserEntity> users = service.findAll();
        return ResponseEntity.ok(mapper.toDto(users));
    }
}
