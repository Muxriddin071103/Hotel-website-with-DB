package org.example.entity;

import java.time.OffsetDateTime;
import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.enums.ReservationStatus;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Reservation {
    private UUID id = UUID.randomUUID();
    private UUID userId;
    private UUID roomId;
    private String userName;
    private String roomName;
    private OffsetDateTime checkInDate;
    private OffsetDateTime checkOutDate;
    private double totalAmount;
    private boolean confirmed;
    private ReservationStatus status;
}
