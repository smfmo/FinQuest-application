package com.finquest.backend.controller;

import com.finquest.backend.dto.request.UserRequestDTO;
import com.finquest.backend.dto.response.UserResponseDTO;
import com.finquest.backend.mapper.UserMapper;
import com.finquest.backend.model.User;
import com.finquest.backend.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService service;
    private final UserMapper mapper;

    public UserController(UserService service, UserMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @PostMapping
    public ResponseEntity<UserResponseDTO> save(@RequestBody UserRequestDTO request) {
        User user = mapper.toEntity(request);
        var entitySaved = service.save(user);

        return ResponseEntity.ok(mapper.toDto(entitySaved));
    }

    @GetMapping
    public ResponseEntity<List<UserResponseDTO>> findAll() {
        List<User> users = service.findAll();
        return ResponseEntity.ok(mapper.toDto(users));
    }
}
