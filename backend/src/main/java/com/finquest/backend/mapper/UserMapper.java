package com.finquest.backend.mapper;

import com.finquest.backend.dto.request.UserRequestDTO;
import com.finquest.backend.dto.response.UserResponseDTO;
import com.finquest.backend.model.User;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {

    User toEntity(UserRequestDTO dto);

    UserResponseDTO toDto(User user);

    List<UserResponseDTO> toDto(List<User> users);
}
