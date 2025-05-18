package com.example.LaptopShop.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;
import org.openqa.selenium.support.ui.WebDriverWait;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.repository.TransactionsRepository;

@Service
public class BankTransactionService {
    private WebDriver browser;
    private final TransactionService transactionService;
    private final TransactionsRepository transactionsRepository;

    public BankTransactionService(TransactionService transactionService,
            TransactionsRepository transactionsRepository) {
        this.transactionService = transactionService;
        this.transactionsRepository = transactionsRepository;
        // Cấu hình Logging Preferences
        LoggingPreferences logPrefs = new LoggingPreferences();
        logPrefs.enable(LogType.PERFORMANCE, Level.ALL);

        // Cấu hình ChromeOptions
        ChromeOptions options = new ChromeOptions();
        options.setCapability("goog:loggingPrefs", logPrefs);

        // Khởi tạo ChromeDriver
        browser = new ChromeDriver(options);
    }

    public void getBankTransactions() throws InterruptedException {
        browser.get("https://neo.vpbank.com.vn/main.html#/Signin");
        Thread.sleep(3000);
        // Nhập thông tin đăng nhập
        WebElement usernameInput = findElementWithTimeout(browser, By.id("__input0-inner"), 30);
        WebElement passwordInput = findElementWithTimeout(browser, By.id("__input1-inner"), 30);

        if (usernameInput == null || passwordInput == null) {
            // model.addAttribute("error", "Không tìm thấy ô nhập tài khoản/mật khẩu.");
            // return "error";
        }
        usernameInput.sendKeys("0886502356");
        passwordInput.sendKeys("Phuc06032004@");

        // Click nút đăng nhập
        WebElement loginButton = findElementWithTimeout(browser, By.id("loginComponent---signin--loginBtn-inner"),
                30);
        if (loginButton == null) {
            // model.addAttribute("error", "Không tìm thấy nút đăng nhập.");
            // return "error";
        }
        loginButton.click();
        Thread.sleep(3000);
        // Tìm và click nút tra cứu giao dịch
        WebDriverWait wait = new WebDriverWait(browser, Duration.ofSeconds(100));
        WebElement transactionHistoryButton = wait.until(ExpectedConditions.presenceOfElementLocated(
                By.id("__icon1-sap.banking.ui.shared.customAccountSummary---accountSummaryView--favouriteAccountsList-0")));
        if (transactionHistoryButton == null) {
            // model.addAttribute("error", "Không tìm thấy nút tra cứu giao dịch.");
            // return "error";
        }
        transactionHistoryButton.click();
        Thread.sleep(3000);
        // Lấy dữ liệu giao dịch
        getDataTransactions(browser);
        // if (transactions == null || transactions.isEmpty()) {
        // redirectAttributes.addFlashAttribute("error", "Không tìm thấy dữ liệu giao
        // dịch.");
        // return "redirect:/client";
        // }

        // redirectAttributes.addFlashAttribute("transactions", transactions);
        // System.out.println(transactions);
        // return transactions;
    }

    private WebElement findElementWithTimeout(WebDriver browser, By by, int timeoutInSeconds) {
        try {
            return new WebDriverWait(browser, Duration.ofSeconds(timeoutInSeconds))
                    .until(driver -> driver.findElement(by));
        } catch (Exception e) {
            return null;
        }
    }

    private void getDataTransactions(WebDriver browser) {
        try {
            WebDriverWait wait = new WebDriverWait(browser, Duration.ofSeconds(60));
            WebElement transactionTable = wait.until(ExpectedConditions.presenceOfElementLocated(
                    By.id("accountDetails--transactionHistoryListItem-listUl")));

            List<WebElement> rows = transactionTable.findElements(By.tagName("tr"));
            if (rows.size() < 1) {
                System.err.println("Không tìm thấy dữ liệu giao dịch.");
                return;
            }
            for (int i = 1; i < rows.size(); i++) { // Bỏ qua hàng tiêu đề
                List<WebElement> cells = rows.get(i).findElements(By.tagName("td"));
                Transactions transaction = new Transactions();
                transaction.setTransactiondate(cells.get(1).getText());
                transaction.setEffectivedate(cells.get(2).getText());
                transaction.setDescription(cells.get(3).getText());
                transaction.setTransactioncode(cells.get(4).getText());
                transaction.setDebit(cells.get(5).getText().strip());
                transaction.setCredit(cells.get(6).getText().strip());
                transaction.setBalance(cells.get(7).getText().strip());
                transactionsRepository.save(transaction);
            }

            return;
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy dữ liệu giao dịch: " + e.getMessage());
        }
        return;
    }

    private String getTokenFromLogs(WebDriver browser, String tokenKey) {
        try {
            List<LogEntry> logs = browser.manage().logs().get("performance").getAll();
            for (LogEntry entry : logs) {
                String message = entry.getMessage();
                if (message.contains(tokenKey)) {
                    return message.split(tokenKey + "\":\"")[1].split("\"")[0];
                }
            }
        } catch (Exception e) {
            System.err.println("Error getting token: " + e.getMessage());
        }
        return null;
    }
}
