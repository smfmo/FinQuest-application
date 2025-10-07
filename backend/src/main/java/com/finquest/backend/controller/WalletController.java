package com.finquest.backend.controller;

import com.finquest.backend.dto.request.WalletRequestDTO;
import com.finquest.backend.dto.response.WalletResponseDTO;
import com.finquest.backend.mapper.WalletMapper;
import com.finquest.backend.model.Wallet;
import com.finquest.backend.service.WalletService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.UUID;

@RestController
@RequestMapping("/wallets")
public class WalletController {

    private final WalletService service;
    private final WalletMapper mapper;

    public WalletController(WalletService service,  WalletMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @PostMapping("{id}")
    public ResponseEntity<WalletResponseDTO> addBalance(@PathVariable UUID id,
                                                        @RequestBody WalletRequestDTO request) {
        Wallet wallet = service.addBalance(id, request.amount());
        return ResponseEntity.ok(mapper.toDto(wallet));
    }
}
