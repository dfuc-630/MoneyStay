package com.example.LaptopShop.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.service.BankTransactionService;
import com.example.LaptopShop.service.TransactionCacheService;
import com.example.LaptopShop.service.TransactionService;

@Controller
public class DashboardController {
    private final TransactionService transactionService;
    private final BankTransactionService bankTransactionService;
    private TransactionCacheService transactionCacheService;

    public DashboardController(TransactionService transactionService, BankTransactionService bankTransactionService,
            TransactionCacheService transactionCacheService) {
        this.transactionService = transactionService;
        this.bankTransactionService = bankTransactionService;
        this.transactionCacheService = transactionCacheService;
    }

    @GetMapping("/admin")
    public String getDashBoard() {
        return "admin/dashboard/show";
    }

    @GetMapping("/client")
    public String getDashBoardClient(Model model) {
        List<Map<String, String>> transactionsCache = this.transactionCacheService.getTransactions();
        if (transactionsCache.size() != 0) {
            model.addAttribute("transactions", transactionsCache);
        } else {
            List<Map<String, String>> transactions = this.bankTransactionService.getBankTransactions();
            model.addAttribute("transactions", transactions);
            transactionCacheService.setTransactions(transactions);
        }

        return "admin/dashboard/show2";
    }
}
