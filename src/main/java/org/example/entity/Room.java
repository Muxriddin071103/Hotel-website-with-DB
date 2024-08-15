package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.enums.TypeRoom;

import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Room {
    private String id = UUID.randomUUID().toString();
    private String name;
    private String description;
    private String imageUrl;
    private double pricePerNight;
    private boolean available;
    private TypeRoom typeRoom;
}
