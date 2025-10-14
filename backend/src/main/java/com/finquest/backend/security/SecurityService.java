package com.finquest.backend.security;

import com.finquest.backend.model.UserEntity;
import com.finquest.backend.service.UserEntityService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class SecurityService {

    private final UserEntityService service;

    public SecurityService(UserEntityService service) {
        this.service = service;
    }

    public UserEntity getUserAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        String username = authentication.getName();
        return service.getByUsername(username);
    }
}
