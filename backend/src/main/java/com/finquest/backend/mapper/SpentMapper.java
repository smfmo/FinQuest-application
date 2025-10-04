package com.finquest.backend.mapper;

import com.finquest.backend.dto.request.SpentRequestDTO;
import com.finquest.backend.dto.response.SpentResponseDTO;
import com.finquest.backend.model.Spent;
import com.finquest.backend.repository.UserRepository;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public abstract class SpentMapper {

    @Autowired
    UserRepository repository;

    @Mapping(target = "user", expression = "java( repository.findById(dto.userId()).orElse(null) )")
    public abstract Spent toEntity(SpentRequestDTO dto);

    public abstract SpentResponseDTO toDto(Spent spent);

    public abstract List<SpentResponseDTO> toDto(List<Spent> spents);
}
