package com.nihal.demo.Repository;
import java.util.List;

import com.nihal.demo.Models.AdminModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface AdminRepo extends MongoRepository<AdminModel, ObjectId> {
    List<AdminModel> findByUsername(String username);

}
