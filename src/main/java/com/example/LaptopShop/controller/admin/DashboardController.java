package com.example.LaptopShop.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.LaptopShop.domain.Categories;
import com.example.LaptopShop.domain.Income;
import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.repository.CategoryRepository;
import com.example.LaptopShop.repository.IncomeRepository;
import com.example.LaptopShop.repository.TransactionsRepository;
import com.example.LaptopShop.service.BankTransactionService;
import com.example.LaptopShop.service.TransactionCacheService;
import com.example.LaptopShop.service.TransactionService;

@Controller
public class DashboardController {
    private final TransactionService transactionService;
    private final BankTransactionService bankTransactionService;
    private final IncomeRepository incomeRepository;
    private final TransactionsRepository transactionsRepository;
    private final CategoryRepository categoriesRepository;

    public DashboardController(TransactionService transactionService, BankTransactionService bankTransactionService,
            IncomeRepository incomeRepository, TransactionsRepository transactionsRepository,
            CategoryRepository categoriesRepository) {
        this.transactionService = transactionService;
        this.bankTransactionService = bankTransactionService;
        this.incomeRepository = incomeRepository;
        this.transactionsRepository = transactionsRepository;
        this.categoriesRepository = categoriesRepository;
    }

    @GetMapping("/admin")
    public String getDashBoard() {
        return "redirect:/admin/user";
    }

    @GetMapping("/crawl_data")
    public String getData(Model model) throws InterruptedException {
        bankTransactionService.getBankTransactions();
        return "redirect:/client";
    }

    @GetMapping("/client")
    public String getDashBoardClient(Model model) throws InterruptedException {

        List<Transactions> transactions = transactionsRepository.findAll();
        model.addAttribute("transactions", transactions);

        List<Categories> categories = categoriesRepository.findAll();
        model.addAttribute("categories", categories);

        List<Income> incomes = incomeRepository.findAll();
        model.addAttribute("incomes", incomes);

        return "admin/dashboard/show2";
    }

    @PostMapping("/updateTransactionCategory")
    public String updateTransactionCategory(@ModelAttribute Transactions transaction) {
        Transactions cuTransactions = transactionsRepository.getById(transaction.getId());
        Categories categories = categoriesRepository.getById(transaction.getCategory().getId());
        // if (cuTransactions.getCategory() != null &&
        // cuTransactions.getCategory().getId() != null) {
        // Categories category =
        // categoriesRepository.findById(cuTransactions.getCategory().getId()).orElse(null);
        // cuTransactions.setCategory(category);
        // }
        cuTransactions.setCategory(categories);
        transactionsRepository.save(cuTransactions);

        return "redirect:/client";
    }

    @PostMapping("/updateTransactionIncome")
    public String updateTransactionIncome(@ModelAttribute Transactions transaction) {
        Transactions cuTransactions = transactionsRepository.getById(transaction.getId());
        Income incomes = incomeRepository.getById(transaction.getIncome().getId());
        // if (cuTransactions.getCategory() != null &&
        // cuTransactions.getCategory().getId() != null) {
        // Categories category =
        // categoriesRepository.findById(cuTransactions.getCategory().getId()).orElse(null);
        // cuTransactions.setCategory(category);
        // }
        cuTransactions.setIncome(incomes);
        transactionsRepository.save(cuTransactions);

        return "redirect:/client";
    }
}
