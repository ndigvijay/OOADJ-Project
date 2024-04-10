// BillGenerator.java

package com.nihal.demo.Services;

import com.nihal.demo.Models.OrderModel;
import com.nihal.demo.Models.ItemModel;

public class BillGenerator {
    
    public static String generateBill(OrderModel order) {
        // Generate bill logic here
        double totalAmount = 0.0;
        StringBuilder bill = new StringBuilder();
        bill.append("Bill for Order ID: ").append(order.getOrderId()).append("\n");
        bill.append("Items:\n");
        for (ItemModel item : order.getItems()) {
            bill.append(item.getName()).append(" - $").append(item.getPrice()).append("\n");
            totalAmount += item.getPrice();
        }
        bill.append("Total Amount: $").append(totalAmount).append("\n");
        return bill.toString();
    }
}
