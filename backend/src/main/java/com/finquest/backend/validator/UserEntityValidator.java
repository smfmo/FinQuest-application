package com.finquest.backend.validator;

import com.finquest.backend.exception.custom.ExistingUsernameException;
import com.finquest.backend.model.UserEntity;
import com.finquest.backend.repository.UserEntityRepository;
import org.springframework.stereotype.Component;
import java.util.Optional;

@Component
public class UserEntityValidator {

    private final UserEntityRepository repository;

    public UserEntityValidator(UserEntityRepository repository) {
        this.repository = repository;
    }

    public void validateUsername(UserEntity user) {
        Optional<UserEntity> existingUser = repository.findByUsername(user.getUsername());

        if (existingUser.isPresent()) {
            throw new ExistingUsernameException("Username already exists");
        }
    }
}
