package com.example.java.basic.sgp.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("")
public class HomeController {
	
	@GetMapping("/")
	public String test4() {
		return "Running";
	}
	
}
