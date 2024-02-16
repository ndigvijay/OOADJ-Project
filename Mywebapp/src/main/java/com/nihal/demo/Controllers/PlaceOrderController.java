package com.nihal.demo.Controllers;

import com.nihal.demo.Models.OrderModel;
import com.nihal.demo.Repository.OrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class PlaceOrderController {
    private final OrderRepo orderRepo;

    @Autowired
    public PlaceOrderController(OrderRepo orderRepo){
        this.orderRepo=orderRepo;
    }

    @PostMapping("user/order")
    public ResponseEntity<String> placeOrder(@RequestBody OrderModel order){
        orderRepo.save(order);
        return ResponseEntity.status(HttpStatus.CREATED).body("Order placed successfully");
    }
}
