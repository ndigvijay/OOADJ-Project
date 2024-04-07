package com.nihal.demo.Repository;

import com.nihal.demo.Models.OrderModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface OrderRepo extends MongoRepository<OrderModel, ObjectId> {

    List<OrderModel> findByOrderId(String orderId);
}