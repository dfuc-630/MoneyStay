package com.example.LaptopShop.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.service.TransactionService;

@Controller
public class DashboardController {
    private final TransactionService transactionService;

    public DashboardController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @GetMapping("/admin")
    public String getDashBoard() {
        return "admin/dashboard/show";
    }

    @GetMapping("/client")
    public String getDashBoardClient(Model model,
            @ModelAttribute("transactions") List<Map<String, String>> transactions) {
        // List<Transactions> transactions =
        // this.transactionService.getAllTransaction();
        model.addAttribute("transactions", transactions);
        return "admin/dashboard/show2";
    }
}
