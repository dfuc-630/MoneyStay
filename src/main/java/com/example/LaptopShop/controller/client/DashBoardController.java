package com.example.LaptopShop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import ch.qos.logback.core.model.Model;

@Controller
public class DashBoardController {

    @GetMapping("/client/income")
    public String getIncomePage(Model model) {
        return "client/manage/income";
    }

    @GetMapping("/client/expense")
    public String getExpensePage(Model model) {
        return "client/manage/expense";
    }

    @GetMapping("/client/debt")
    public String getDebtPage(Model model) {
        return "client/manage/debt";
    }
}
