package com.finquest.backend.service;

import com.finquest.backend.model.UserEntity;
import com.finquest.backend.model.Wallet;
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

    public List<UserEntity> findAll() {
        return repository.findAll();
    }

    public UserEntity getById(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + id));
    }

    @Transactional
    public UserEntity save(UserEntity userEntity) {
        Wallet wallet = new Wallet();
        userEntity.setWallet(wallet);
        wallet.setUser(userEntity);
        return repository.save(userEntity);
    }

    @Transactional
    public UserEntity update(UUID id, UserEntity updatedUser) {
        UserEntity existingUser = getById(id);

        existingUser.setName(updatedUser.getName());
        existingUser.setEmail(updatedUser.getEmail());
        existingUser.setPassword(updatedUser.getPassword());

        return repository.save(existingUser);
    }

    public void delete(UUID id) {
        UserEntity existingUser = getById(id);
        repository.delete(existingUser);
    }
}
