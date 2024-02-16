package com.nihal.demo.Repository;

import com.nihal.demo.Models.OrderModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface OrderRepo extends MongoRepository<OrderModel, ObjectId> {

}
