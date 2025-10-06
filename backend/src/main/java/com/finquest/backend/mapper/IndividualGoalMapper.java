package com.finquest.backend.mapper;

import com.finquest.backend.dto.request.IndividualGoalRequestDTO;
import com.finquest.backend.dto.response.IndividualGoalResponseDTO;
import com.finquest.backend.model.IndividualGoal;
import com.finquest.backend.repository.UserRepository;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public abstract class IndividualGoalMapper {

    @Autowired
    UserRepository repository;

    @Mapping(target = "user", expression = "java(repository.findById(dto.userId()).orElse(null))")
    public abstract IndividualGoal toEntity(IndividualGoalRequestDTO dto);

    public abstract IndividualGoalResponseDTO toDto(IndividualGoal entity);

    public abstract List<IndividualGoalResponseDTO> toDto(List<IndividualGoal> entities);
}
