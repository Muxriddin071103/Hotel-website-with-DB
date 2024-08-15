package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.enums.Role;

import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User {
    private String id = UUID.randomUUID().toString();
    private String name;
    private String email;
    private String password;
    private boolean isActive;
    private Role role;

    public User(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
        role = Role.USER;
        isActive = true;
    }
}
