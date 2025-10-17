package com.finquest.backend.validator;

import com.finquest.backend.exception.custom.InvalidAmountSpentException;
import com.finquest.backend.model.Spent;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class SpentValidator {

    public void validate(Spent spent) {
        if (spent.getAmountSpent().compareTo(BigDecimal.ZERO) <= 0) {
            throw new InvalidAmountSpentException("Valor do gasto inválido");
        }
    }
}