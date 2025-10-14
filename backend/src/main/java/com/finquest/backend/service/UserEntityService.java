package com.finquest.backend.service;

import com.finquest.backend.model.UserEntity;
import com.finquest.backend.model.Wallet;
import com.finquest.backend.repository.UserEntityRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.UUID;

@Service
public class UserEntityService {

    private final UserEntityRepository repository;
    private final PasswordEncoder encoder;

    public UserEntityService(UserEntityRepository repository, PasswordEncoder encoder) {
        this.repository = repository;
        this.encoder = encoder;
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
        userEntity.setPassword(encoder.encode(userEntity.getPassword()));
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

    public UserEntity getByUsername(String username) {
        return repository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));
    }
}
