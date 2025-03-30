package com.example.LaptopShop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.LaptopShop.service.TransactionCacheService;

@Controller
public class DashBoardController {
    private TransactionCacheService transactionCacheService;

    public DashBoardController(TransactionCacheService transactionCacheService) {
        this.transactionCacheService = transactionCacheService;
    }

    @GetMapping("/client/income")
    public String getIncomePage(Model model) {
        List<Map<String, String>> transactions = this.transactionCacheService.getTransactions();
        // Kiểm tra nếu transactions chưa có dữ liệu
        if (transactions == null) {
            transactions = new ArrayList<>();
        }

        // Lọc các giao dịch có income (credit > 0)
        List<Map<String, String>> incomeTransactions = transactions.stream()
                .filter(t -> {
                    String credit = t.get("credit");
                    return credit != null && !credit.trim().isEmpty() && !credit.equals("0") && !credit.equals("--");
                })
                .collect(Collectors.toList());

        // Đưa dữ liệu vào model để hiển thị trên JSP
        model.addAttribute("incomeTransactions", incomeTransactions);
        return "client/manage/income";
    }

    @GetMapping("/client/expense")
    public String getExpensePage(Model model) {
        List<Map<String, String>> transactions = this.transactionCacheService.getTransactions();
        // Kiểm tra nếu transactions chưa có dữ liệu
        if (transactions == null) {
            transactions = new ArrayList<>();
        }

        // Lọc các giao dịch có outcome (debit > 0)
        List<Map<String, String>> outcomeTransactions = transactions.stream()
                .filter(t -> {
                    String debit = t.get("debit");
                    return debit != null && !debit.trim().isEmpty() && !debit.equals("0") && !debit.equals("--");
                })
                .collect(Collectors.toList());

        // Đưa dữ liệu vào model để hiển thị trên JSP
        model.addAttribute("outcomeTransactions", outcomeTransactions);
        return "client/manage/expense";
    }

    @GetMapping("/client/debt")
    public String getDebtPage(Model model) {
        return "client/manage/debt";
    }
}
