package com.finquest.backend.exception.custom;

public class InvalidAmountSpentException extends RuntimeException {
    public InvalidAmountSpentException(String message) {
        super(message);
    }
}
