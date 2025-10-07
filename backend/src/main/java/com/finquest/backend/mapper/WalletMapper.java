package com.finquest.backend.mapper;

import com.finquest.backend.dto.request.WalletRequestDTO;
import com.finquest.backend.dto.response.WalletResponseDTO;
import com.finquest.backend.model.Wallet;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface WalletMapper {

    Wallet toEntity(WalletRequestDTO dto);

    WalletResponseDTO toDto(Wallet entity);
}
