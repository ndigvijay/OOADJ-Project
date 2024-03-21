package com.nihal.demo.Repository;

public interface MenuRepo extends MongoRepository<ItemModel, ObjectId>{
    ItemModel findByItemName(String itemName);
    void deleteByItemName(String itemName);
}






//MenuRepository=>
// package com.nihal.demo.Repository;

// import com.nihal.demo.Models.ItemModel;
// import org.springframework.data.mongodb.repository.MongoRepository;
// import org.bson.types.ObjectId;

// public interface MenuRepository extends MongoRepository<ItemModel, ObjectId> {
//     ItemModel findByItemName(String itemName);
//     void deleteByItemName(String itemName);
// }
