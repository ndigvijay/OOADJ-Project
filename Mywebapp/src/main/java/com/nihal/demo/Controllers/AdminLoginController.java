package com.nihal.demo.Controllers;

import com.nihal.demo.Models.AdminModel;
import com.nihal.demo.Repository.AdminRepo;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.SecretKey;
import java.util.*;
import java.util.List;

@Controller
public class AdminLoginController {
    private final AdminRepo adminRepo;

    @Autowired
    public AdminLoginController(AdminRepo adminRepo){
        this.adminRepo=adminRepo;
    }

    @PostMapping("/admin/login")
    public ResponseEntity<String> LoginAdmin(@RequestBody AdminModel request){
        String username=request.getUsername();
//        System.out.println("request username"+username);
        List<AdminModel> admins = adminRepo.findByUsername(username);
        if(admins.size()==0){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("no admin found");
        }
        if (admins.get(0).getPassword().equals(request.getPassword())) {
            String token = generateToken(username);
            return ResponseEntity.ok().header("Authorization", "Bearer " + token).body("Login successful");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid username or password");
        }

    }

    @GetMapping("/admin/login")
    public String AdminLogin(){
        return "adminlogin";
    }

    private static final SecretKey SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);
    private String generateToken(String username) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    public static String verifyToken(String token) {
        try {
            Jws<Claims> claimsJws = Jwts.parserBuilder()
                    .setSigningKey(SECRET_KEY)
                    .build()
                    .parseClaimsJws(token);
            return claimsJws.getBody().getSubject();
        } catch (Exception e) {
            // Token verification failed
            return null;
        }
    }
}




