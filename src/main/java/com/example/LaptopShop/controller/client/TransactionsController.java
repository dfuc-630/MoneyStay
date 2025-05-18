package com.example.LaptopShop.controller.client;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.LaptopShop.service.CategoryService;
import com.example.LaptopShop.service.TransactionCacheService;

@Controller
public class TransactionsController {

    private TransactionCacheService transactionCacheService;
    private CategoryService categoryService;

    public TransactionsController(TransactionCacheService transactionCacheService, CategoryService categoryService) {
        this.transactionCacheService = transactionCacheService;
        this.categoryService = categoryService;
    }

    @GetMapping("/client/transaction/create")
    public String getDebtPage(Model model) {
        List<Map<String, String>> transactions = this.transactionCacheService.getTransactions();
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("transaction", transactions);
        return "client/manage/transaction_create";

    }
}
