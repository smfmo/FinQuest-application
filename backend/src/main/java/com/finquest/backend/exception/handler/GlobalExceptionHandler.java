package com.finquest.backend.exception.handler;

import com.finquest.backend.exception.custom.ExistingUsernameException;
import com.finquest.backend.exception.custom.InvalidAmountSpentException;
import com.finquest.backend.exception.custom.UserMismatchException;
import com.finquest.backend.exception.custom.WalletOwnershipException;
import com.finquest.backend.exception.response.ErrorResponseDTO;
import com.finquest.backend.exception.response.FieldErrorResponseDTO;
import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import java.util.List;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.UNPROCESSABLE_ENTITY)
    public ErrorResponseDTO handlerMethodArgumentNotValidException(MethodArgumentNotValidException e) {

        List<FieldError> fieldErrors = e.getFieldErrors();

        List<FieldErrorResponseDTO> listErrors = fieldErrors
                .stream()
                .map(fe -> new FieldErrorResponseDTO(fe.getField(), fe.getDefaultMessage()))
                .toList();

        return new ErrorResponseDTO(HttpStatus.UNPROCESSABLE_ENTITY.value(),
                "Validation Error", listErrors);
    }

    @ExceptionHandler(UserMismatchException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public ErrorResponseDTO handlerUserMismatchException(UserMismatchException e) {
        return new ErrorResponseDTO(HttpStatus.FORBIDDEN.value(), e.getMessage(), List.of());
    }

    @ExceptionHandler(WalletOwnershipException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public ErrorResponseDTO handleWalletOwnershipException(WalletOwnershipException e) {
        return new ErrorResponseDTO(HttpStatus.FORBIDDEN.value(), e.getMessage(), List.of());
    }

    @ExceptionHandler(InvalidAmountSpentException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponseDTO handleInvalidAmountSpentException(InvalidAmountSpentException e) {
        return new ErrorResponseDTO(HttpStatus.CONFLICT.value(), e.getMessage(), List.of());
    }

    @ExceptionHandler(ExistingUsernameException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponseDTO handleExistingUsernameException(ExistingUsernameException e) {
        return new ErrorResponseDTO(HttpStatus.CONFLICT.value(), e.getMessage(), List.of());
    }
}
