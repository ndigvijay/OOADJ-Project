// BillController.java

package com.nihal.demo.Controllers;

import com.nihal.demo.Models.OrderModel;
import com.nihal.demo.Repository.OrderRepo;
import com.nihal.demo.Services.BillGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BillController{

    private final OrderRepo orderRepo;

    @Autowired
    public BillController(OrderRepo orderRepo) {
        this.orderRepo = orderRepo;
    }

    @PostMapping("/generateBill")
    public String generateBill(@RequestBody OrderModel order) {
        return BillGenerator.generateBill(order);
    }

    // This endpoint is just for demonstration purposes.
    // You should implement email sending logic in your backend.
    @PostMapping("/sendBillEmail")
    public String sendBillEmail(@RequestBody String bill) {
        // Code to send bill via email
        return "Bill sent successfully!";
    }
    @GetMapping("/mybill")
    public String Bill(){
        return "billgenerator";
    }
}
