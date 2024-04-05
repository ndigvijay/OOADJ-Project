package com.nihal.demo.Models;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ItemModel implements Cloneable {
    private String id;

    private String name;

    public String image;

    private float price;

    private String category;

    public int quantity;

    ItemModel(String Name, int Quantity){
        this.name=Name;
        this.quantity=Quantity;
    }
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}

