package com.nihal.demo.Repository;

import com.nihal.demo.Models.FeedbackModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface FeedbackRepo extends MongoRepository<FeedbackModel, ObjectId> {
}
