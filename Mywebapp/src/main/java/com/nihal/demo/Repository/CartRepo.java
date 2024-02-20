package com.nihal.demo.Repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import com.nihal.demo.Models.CartModel;
import org.bson.types.ObjectId;

public interface CartRepo extends MongoRepository<CartModel, ObjectId> {

}
