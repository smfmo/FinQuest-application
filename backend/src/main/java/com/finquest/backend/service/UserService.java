package com.finquest.backend.service;

import com.finquest.backend.model.User;
import com.finquest.backend.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    public List<User> findAll() {
        return repository.findAll();
    }

    public User getById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + id));
    }

    @Transactional
    public User save(User user) {
        return repository.save(user);
    }

    @Transactional
    public User update(UUID id, User updatedUser) {
        User existingUser = getById(id);

        existingUser.setName(updatedUser.getName());
        existingUser.setEmail(updatedUser.getEmail());
        existingUser.setPassword(updatedUser.getPassword());

        return repository.save(existingUser);
    }

    public void delete(UUID id) {
        User existingUser = getById(id);
        repository.delete(existingUser);
    }
}
