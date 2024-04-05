package com.nihal.demo.Repository;//package com.nihal.demo.Repository;


import com.nihal.demo.Models.ItemModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ItemRepository extends MongoRepository<ItemModel, ObjectId> {
    boolean existsByName(String itemName);
    ItemModel getItemByName(String itemName);
}
