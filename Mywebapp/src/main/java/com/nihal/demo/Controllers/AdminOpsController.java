package com.nihal.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminOpsController {
    
    @GetMapping("/admin/operations")
    public String adminOperations() {
        return "adminOps";
    }
    
}

