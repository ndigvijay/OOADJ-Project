package com.nihal.demo.Controllers;

import com.nihal.demo.Models.AdminModel;
import com.nihal.demo.Repository.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Controller
public class AdminSignupController {
    private final AdminRepo adminRepo;

    @Autowired
    public AdminSignupController(AdminRepo adminRepo) {
        this.adminRepo = adminRepo;
    }

    @PostMapping("admin/signup")
    public ResponseEntity<String> addUsers(@RequestBody AdminModel request) {
        String username = request.getUsername();
//        System.out.println("request username"+username);
        List<AdminModel> admins = adminRepo.findByUsername(username);
        System.out.println("existing admin"+admins);
        if(admins.size()!=0){
            return ResponseEntity.status(HttpStatus.CONFLICT).body("username already exists");
        }
        adminRepo.save(request);
        return ResponseEntity.status(HttpStatus.CREATED).body("user created");
    }
    @GetMapping("admin/signup")
    public String AdminLogin(){
        return "adminsignup";
    }
}
