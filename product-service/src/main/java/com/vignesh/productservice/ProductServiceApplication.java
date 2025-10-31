package com.vignesh.productservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ProductServiceApplication {

    @GetMapping("/")
    public String home() {
        return "✅ Product Service is running successfully!";
    }

    @GetMapping("/actuator/health")
    public String health() {
        return "healthy";
    }

    public static void main(String[] args) {
        SpringApplication.run(ProductServiceApplication.class, args);
    }
}
