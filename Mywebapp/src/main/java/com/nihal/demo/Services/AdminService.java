package com.nihal.demo.Services;

import com.nihal.demo.Models.ItemModel;
import com.nihal.demo.Repository.ItemRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private ItemRepository itemRepository;

    public void addItem(ItemModel item) {
        itemRepository.save(item);
    }

    public void removeItem(ObjectId itemId) {
        itemRepository.deleteById(itemId);
    }

    public List<ItemModel> getAllItems() {
        return itemRepository.findAll();
    }
    public boolean isItemExists(String itemName) {
        // Check if an item with the same name already exists
        return itemRepository.existsByName(itemName);
    }
    public void updateItem(ItemModel updatedItem) {
        itemRepository.save(updatedItem);
    }

    public ItemModel getItemById(ObjectId itemId) {
        return itemRepository.findById(itemId).orElse(null);
    }

    public boolean isItemExistsById(ObjectId itemId) {
        return itemRepository.existsById(itemId);
    }
}
