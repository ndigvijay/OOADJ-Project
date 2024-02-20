package com.nihal.demo.Models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ItemModel {
    @Id
    private int id;

    private String name;

    private float price;

    private String category;

    public int quantity;
}
