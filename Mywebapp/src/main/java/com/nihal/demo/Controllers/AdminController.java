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
}
