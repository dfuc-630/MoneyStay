package com.example.LaptopShop.controller.client;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.LaptopShop.domain.BudgetTarget;
import com.example.LaptopShop.domain.Categories;
import com.example.LaptopShop.domain.Income;
import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.repository.BudgetTargetRepository;
import com.example.LaptopShop.repository.CategoryRepository;
import com.example.LaptopShop.repository.IncomeRepository;
import com.example.LaptopShop.repository.TransactionsRepository;

@Controller
public class DashBoardController {
    private final TransactionsRepository transactionsRepository;
    private final CategoryRepository categoriesRepository;
    private final IncomeRepository incomeRepository;
    @Autowired
    private BudgetTargetRepository budgetTargetRepository;

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

    @GetMapping("/client/budget")
    public String showBudgetPage(Model model) {
        model.addAttribute("budgetTarget", new BudgetTarget());
        model.addAttribute("categories", categoriesRepository.findAll());
        model.addAttribute("incomes", incomeRepository.findAll());
        model.addAttribute("budgetTargets", budgetTargetRepository.findAll());

        // Notifications logic
        List<Transactions> transactions = transactionsRepository.findAll();
        List<String> notifications = new ArrayList<>();
        for (Transactions t : transactions) {
            String cleanedDebit = t.getDebit().replaceAll("[^\\d]", "");
            if (cleanedDebit != null && cleanedDebit != "") {
                if (Integer.parseInt(cleanedDebit) > 5000000) {
                    notifications.add("Chi tiêu lớn: " + t.getDescription() + " - " + cleanedDebit);
                }
            }

            String cleanedCredit = t.getCredit().replaceAll("[^\\d]", "");
            if (cleanedCredit != null && cleanedCredit != "") {
                if (Integer.parseInt(cleanedCredit) > 10000000) {
                    notifications.add("Thu nhập lớn: " + t.getDescription() + " - " + cleanedCredit);
                }
            }

        }
        model.addAttribute("notifications", notifications);

        return "client/manage/budget"; // JSP file
    }

    @PostMapping("/client/budget/save")
    public String saveBudgetTarget(@ModelAttribute BudgetTarget budgetTarget) {
        budgetTargetRepository.save(budgetTarget);
        return "redirect:/client/budget";
    }

    @PostMapping("/client/budget/delete/{id}")
    public String deleteBudgetTarget(@PathVariable Long id) {
        budgetTargetRepository.deleteById(id);
        return "redirect:/client/budget";
    }

    @GetMapping("/client/budget/view/{id}")
    public String viewBudgetTarget(@PathVariable("id") Long id, Model model) {
        BudgetTarget target = budgetTargetRepository.getById(id);
        model.addAttribute("target", target);

        List<Transactions> outComeTransactions = transactionsRepository.findByCategory(target.getCategory());
        model.addAttribute("outComeTransactions", outComeTransactions);

        List<Transactions> inComeTransactions = transactionsRepository.findByIncome(target.getIncome());
        model.addAttribute("inComeTransactions", inComeTransactions);

        // Tính tổng chi tiêu tháng này
        LocalDate currentDate = LocalDate.now();
        int currentMonth = currentDate.getMonthValue();
        int currentYear = currentDate.getYear();

        int totalDebitThisMonth = 0;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/M/yyyy[ H:mm:ss]");

        for (Transactions t : outComeTransactions) {
            try {
                if (t.getTransactiondate() != null && t.getDebit() != null && !t.getDebit().equals("--")) {
                    LocalDate txDate = LocalDate.parse(t.getTransactiondate().trim(), formatter);
                    if (txDate.getMonthValue() == currentMonth && txDate.getYear() == currentYear) {
                        String debitStr = t.getDebit().replace(",", "").replace("VND", "").trim();
                        totalDebitThisMonth += Integer.parseInt(debitStr);
                    }
                }
            } catch (Exception e) {
                // Có thể log lỗi nếu cần
            }
        }
        int totalCreditThisMonth = 0;
        for (Transactions t : inComeTransactions) {
            try {
                if (t.getTransactiondate() != null && t.getCredit() != null && !t.getCredit().equals("--")) {
                    LocalDate txDate = LocalDate.parse(t.getTransactiondate().trim(), formatter);
                    if (txDate.getMonthValue() == currentMonth && txDate.getYear() == currentYear) {
                        String debitStr = t.getCredit().replace(",", "").replace("VND", "").trim();
                        totalCreditThisMonth += Integer.parseInt(debitStr);
                    }
                }
            } catch (Exception e) {
                // Có thể log lỗi nếu cần
            }
        }
        model.addAttribute("totalCreditThisMonth", totalCreditThisMonth);
        model.addAttribute("totalDebitThisMonth", totalDebitThisMonth);
        return "client/manage/budgetview"; // JSP mới để hiển thị thông tin chi tiết
    }

}
