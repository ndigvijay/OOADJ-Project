package com.nihal.demo.Controllers;

import com.nihal.demo.Models.ItemModel;
import com.nihal.demo.Services.AdminService;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @PostMapping("/add-item")
    public ResponseEntity<String> addItem(@RequestBody ItemModel item) {
        try {
            // Check if the item already exists
            if (adminService.isItemExists(item.getName())) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("Item already exists!");
            } else {
                adminService.addItem(item);
                return ResponseEntity.ok("Item added successfully!");
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/remove-item/{itemId}")
    public ResponseEntity<String> removeItem(@PathVariable ObjectId itemId) {
        try {
            adminService.removeItem(itemId);
            return ResponseEntity.ok("Item removed successfully!");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/view-items")
    public ResponseEntity<List<ItemModel>> viewItems() {
        List<ItemModel> items = adminService.getAllItems();
        return ResponseEntity.ok().body(items);
    }
    @PutMapping("/update-item/{itemId}")
    public ResponseEntity<String> updateItem(@PathVariable ObjectId itemId, @RequestBody ItemModel updatedItem) {
        try {
            if (!adminService.isItemExistsById(itemId)) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Item not found!");
            }
            updatedItem.setId(itemId.toString());
            adminService.updateItem(updatedItem);
            return ResponseEntity.ok("Item updated successfully!");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/get-item/{itemId}")
    public ResponseEntity<ItemModel> getItem(@PathVariable ObjectId itemId) {
        try {
            ItemModel item = adminService.getItemById(itemId);
            if (item != null) {
                return ResponseEntity.ok().body(item);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            // Create an ItemModel object with the error message
            ItemModel errorItem = new ItemModel();
            errorItem.setName("Error");
            errorItem.setImage("Error");
            errorItem.setPrice(0.0f);
            errorItem.setCategory("Error");
            errorItem.setQuantity(0);
            errorItem.setId("Error");

            // Return the error message within the ItemModel object
            return ResponseEntity.internalServerError().body(errorItem);
        }
    }

}
