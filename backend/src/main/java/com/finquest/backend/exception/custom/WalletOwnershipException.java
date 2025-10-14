package com.finquest.backend.exception.custom;

public class WalletOwnershipException extends RuntimeException {
    public WalletOwnershipException(String message) {
        super(message);
    }
}
