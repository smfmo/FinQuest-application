package com.finquest.backend.validator;

import com.finquest.backend.exception.custom.UserMismatchException;
import com.finquest.backend.model.UserOwned;
import com.finquest.backend.security.SecurityService;
import org.springframework.stereotype.Component;

@Component
public class UserOwnershipValidator {

    private final SecurityService service;

    public UserOwnershipValidator(SecurityService service) {
        this.service = service;
    }

    public <T extends UserOwned> void validateUserOwnerShip(T entity) {
        if (!entity.getUser().getId().equals(service.getUserAuthenticated().getId())) {
            throw new UserMismatchException("Não é possível salvar, Id incompatível");
        }
    }
}
