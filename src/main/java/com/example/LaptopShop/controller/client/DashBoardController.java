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
import com.example.LaptopShop.domain.Income;
import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.repository.CategoryRepository;
import com.example.LaptopShop.repository.IncomeRepository;
import com.example.LaptopShop.repository.TransactionsRepository;

@Controller
public class DashBoardController {
    private final TransactionsRepository transactionsRepository;
    private final CategoryRepository categoriesRepository;
    private final IncomeRepository incomeRepository;

    public DashBoardController(TransactionsRepository transactionsRepository, CategoryRepository categoriesRepository,
            IncomeRepository incomeRepository) {
        this.transactionsRepository = transactionsRepository;
        this.categoriesRepository = categoriesRepository;
        this.incomeRepository = incomeRepository;
    }

    @GetMapping("/client/income")
    public String getIncomePage(Model model) {
        List<Transactions> transactions = transactionsRepository.findAll();
        model.addAttribute("incomeTransactions", transactions); // đổi tên để khớp view

        List<Income> incomes = incomeRepository.findAll();
        model.addAttribute("income", incomes);
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
