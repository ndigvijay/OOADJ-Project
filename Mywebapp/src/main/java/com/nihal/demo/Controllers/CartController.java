package com.nihal.demo.Controllers;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.nihal.demo.Models.CartModel;
import com.nihal.demo.Models.ItemModel;
import org.bson.json.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.nihal.demo.Services.CartService;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @PostMapping("/add")
    public ResponseEntity<String> addItemToCart(@RequestBody ItemModel request) {
        try {
            String itemName = request.getName();
            int quantity = request.getQuantity();

            if(quantity == 0) {
                cartService.removeItemFromCart(itemName);
            }
            cartService.addItemToCart(itemName, quantity);
            return ResponseEntity.ok("Item added successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @PatchMapping("/update-quantity/{itemName}")
    public ResponseEntity<String> updateQuantity(@PathVariable String itemName, @RequestParam int quantityChange) {
        try {
            cartService.updateQuantity(itemName, quantityChange);
            return ResponseEntity.ok("Quantity updated successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/remove/{itemName}")
    public ResponseEntity<String> removeItemFromCart(@PathVariable String itemName) {
        try {
            cartService.removeItemFromCart(itemName);
            return ResponseEntity.ok("Item removed successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/view")
    public ResponseEntity<CartModel> viewCart() {
        CartModel cart=cartService.viewCart();
        return ResponseEntity.ok().body(cart);
    }

    @GetMapping("/mycart")
    public String cart() {
        return "cart";
    }
}
