package com.vehiclemgmt.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "vehicles_table")
public class Vehicles {
    @Id
    private int vehicle_id;
    @Column
    private String make;
    @Column
    private String model;
    @Column
    private int year;
    @Column
    private String fuel_type;
    @ManyToOne
    @JoinColumn(name = "owner_id", referencedColumnName = "owner_id")
    private Owner owner;
}