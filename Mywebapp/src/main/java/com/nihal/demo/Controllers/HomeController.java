package com.nihal.demo.Controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class HomeController {
    @GetMapping("/home")
    public String Home() {
        return "home";
    }

    @GetMapping("/menu")
    public String Menu() {
        return "menu";
    }

    @GetMapping("/menu/jp")
    public String JP_Menu() {
        return "japanese";
    }
}
