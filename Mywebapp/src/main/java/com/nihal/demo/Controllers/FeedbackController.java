package com.nihal.demo.Controllers;

import com.nihal.demo.Models.FeedbackModel;
import com.nihal.demo.Repository.FeedbackRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class FeedbackController {
    private final FeedbackRepo feedbackRepo;

    @Autowired
    public FeedbackController(FeedbackRepo feedbackRepo){
        this.feedbackRepo = feedbackRepo;
    }

    @PostMapping("/user/feedback")
    public ResponseEntity<String> postFeedback(@RequestBody FeedbackModel feedback){
        feedbackRepo.save(feedback);
        return ResponseEntity.status(HttpStatus.CREATED).body("Feedback submitted successfully");
    }

    @GetMapping("/user/feedback")
    public String feedback(){
        return "feedback";
    }
}
