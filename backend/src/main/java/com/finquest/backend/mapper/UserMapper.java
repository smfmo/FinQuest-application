package com.finquest.backend.mapper;

import com.finquest.backend.dto.request.UserRequestDTO;
import com.finquest.backend.dto.response.UserResponseDTO;
import com.finquest.backend.model.UserEntity;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {

    UserEntity toEntity(UserRequestDTO dto);

    UserResponseDTO toDto(UserEntity user);

    List<UserResponseDTO> toDto(List<UserEntity> users);
}
