package com.nihal.demo.Controllers;

import com.nihal.demo.Models.ItemModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.nihal.demo.Services.CartService;

@RestController
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @PostMapping("/add")
    public ResponseEntity<String> addItemToCart(@RequestBody ItemModel item) {
        try {
            if(item.quantity == 0) {
                cartService.removeItemFromCart(item.getId());
            }
            cartService.addItemToCart(item);
            return ResponseEntity.ok("Item added successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @PatchMapping("/update-quantity/{itemId}")
    public ResponseEntity<String> updateQuantity(@PathVariable int itemId, @RequestParam int quantityChange) {
        try {
            cartService.updateQuantity(itemId, quantityChange);
            return ResponseEntity.ok("Quantity updated successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/remove/{itemId}")
    public ResponseEntity<String> removeItemFromCart(@PathVariable int itemId) {
        try {
            cartService.removeItemFromCart(itemId);
            return ResponseEntity.ok("Item removed successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/view")
    public ResponseEntity<String> viewCart() {
        return ResponseEntity.ok(String.valueOf(cartService.viewCart()));
    }
}
