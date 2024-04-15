package com.nihal.demo.Controllers;

import com.nihal.demo.Models.CartModel;
import com.nihal.demo.Models.OrderModel;
import com.nihal.demo.Models.OrderStatus;
import com.nihal.demo.Repository.OrderRepo;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.nihal.demo.Services.CartService;

import java.security.Key;
import java.util.Date;
import java.util.List;

@Controller
public class PlaceOrderController {
    private final OrderRepo orderRepo;
    private  final CartService cartService;

    @Autowired
    public PlaceOrderController(OrderRepo orderRepo, CartService cartService){
        this.orderRepo=orderRepo;
        this.cartService = cartService;
    }


    public static Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
    @PostMapping("user/order")
    public ResponseEntity<String> placeOrder() {
        CartModel cart = cartService.viewCart();
        OrderModel orderFromCart = new OrderModel();
        orderFromCart.setItems(cart.getItemList());
        OrderModel savedOrder = orderRepo.save(orderFromCart);

        // Generate JWT token with order ID as payload
        
        // String jwtToken = Jwts.builder()
        //         .setSubject(savedOrder.getOrderId())
        //         .setIssuedAt(new Date())
        //         .signWith(key)
        //         .compact();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(savedOrder.getOrderId());
    }
    @GetMapping("user/order/{orderId}")
    public ResponseEntity<List<OrderModel>> viewOrder(@PathVariable String orderId){
        List<OrderModel> orders = orderRepo.findByOrderId(orderId);
        for (OrderModel order : orders) {
            order.setStatus(OrderStatus.PENDING);
        }
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(orders);
    }

    @GetMapping("admin/order")
    public ResponseEntity<List<OrderModel>> viewAdminOrder(){
        List<OrderModel> orders = orderRepo.findAll();
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(orders);
    }
    @PostMapping("decodeToken")
    public ResponseEntity<String> decodeToken(@RequestBody String jwtToken) {
        Claims claims = Jwts.parserBuilder()
            .setSigningKey(key)
            .build()
            .parseClaimsJws(jwtToken)
            .getBody();
        String orderId = claims.getSubject();
        return ResponseEntity.ok(orderId);
    }
        
}
