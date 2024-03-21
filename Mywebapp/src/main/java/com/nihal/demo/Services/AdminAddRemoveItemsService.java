package com.nihal.demo.AdminFunctionality;


import com.nihal.demo.Models.ItemModel;
import com.nihal.demo.Models.OrderModel;
import com.nihal.demo.Repository.MenuRepo;
import com.nihal.demo.Repository.OrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    private final MenuRepo menuRepository;
    private final OrderRepo orderRepository;

    @Autowired
    public AdminServiceImpl(MenuRepo menuRepository, OrderRepo orderRepository) {
        this.menuRepository = menuRepository;
        this.orderRepository = orderRepository;
    }

    @Override
    public void addItemToMenu(ItemModel item) {
        menuRepository.save(item);
    }

    @Override
    public void removeItemFromMenu(String itemName) {
        menuRepository.deleteByItemName(itemName);
    }

    @Override
    public List<Order> viewOrders() {
        return orderRepository.findAll();
    }   
    
    @Override
public void updateMenuItem(String itemName, String newName, float price, String desc, String category) {
    ItemModel item = menuRepository.findByItemName(itemName);
    if (item != null) {
        item.setItemName(newName);
        item.setPrice(price);
        item.setDescription(desc);
        item.setCategory(category);
        menuRepository.save(item);
    } else {
        
        throw new IllegalArgumentException("Item with name " + itemName + " not found");
    }
}

}

// //MenuRepo=>
// package com.nihal.demo.Repository;

// import com.nihal.demo.Models.ItemModel;
// import org.springframework.data.mongodb.repository.MongoRepository;
// import org.bson.types.ObjectId;

// public interface MenuRepository extends MongoRepository<ItemModel, ObjectId> {
//     ItemModel findByItemName(String itemName);
//     void deleteByItemName(String itemName);
// }
