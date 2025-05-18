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

import com.example.LaptopShop.domain.Categories;
import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.repository.CategoryRepository;
import com.example.LaptopShop.repository.TransactionsRepository;

@Controller
public class DashBoardController {
    private final TransactionsRepository transactionsRepository;
    private final CategoryRepository categoriesRepository;

    public DashBoardController(TransactionsRepository transactionsRepository, CategoryRepository categoriesRepository) {
        this.transactionsRepository = transactionsRepository;
        this.categoriesRepository = categoriesRepository;
    }

    @GetMapping("/client/income")
    public String getIncomePage(Model model) {
        // List<Map<String, String>> transactions =
        // this.transactionCacheService.getTransactions();
        // // Kiểm tra nếu transactions chưa có dữ liệu
        // if (transactions == null) {
        // transactions = new ArrayList<>();
        // }

        // // Lọc các giao dịch có income (credit > 0)
        // List<Map<String, String>> incomeTransactions = transactions.stream()
        // .filter(t -> {
        // String credit = t.get("credit");
        // return credit != null && !credit.trim().isEmpty() && !credit.equals("0") &&
        // !credit.equals("--");
        // })
        // .collect(Collectors.toList());

        // // Đưa dữ liệu vào model để hiển thị trên JSP
        // model.addAttribute("incomeTransactions", incomeTransactions);
        return "client/manage/income";
    }

    @GetMapping("/client/expense")
    public String getExpensePage(Model model) {
        List<Transactions> transactions = transactionsRepository.findAll();
        model.addAttribute("outcomeTransactions", transactions); // đổi tên để khớp view

        List<Categories> categories = categoriesRepository.findAll();
        model.addAttribute("category", categories);
        return "client/manage/expense";

    }

    @GetMapping("/client/transaction")
    public String getDebtPage(Model model) {
        return "client/manage/transaction";

    }
}
