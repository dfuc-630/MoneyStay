package com.example.LaptopShop.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.LaptopShop.domain.dto.KeyShareDTO;
import com.example.LaptopShop.domain.dto.TransactionResponseDTO;
import com.example.LaptopShop.service.BankService;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BankController {

    @Autowired
    private BankService bankService;

    @GetMapping("/bank/transactions")
    public String getBankTransactions(Model model, HttpSession session) {
        String authkey = (String) session.getAttribute("authkey");

        if (authkey == null) {
            // Setup browser and navigate to login page
            bankService.login();
            return "keyshare";
        } else {
            // Already have authkey, try to fetch transactions
            return "bankTransactions";
        }
    }

    @PostMapping("/api/submit-key")
    @ResponseBody
    public ResponseEntity<String> submitKey(@RequestBody KeyShareDTO keyShareDTO) {
        bankService.setCredentials(keyShareDTO.getKeyshare(), keyShareDTO.getPinshare());
        return ResponseEntity.ok("{\"status\": \"ok\"}");
    }

    @GetMapping("/api/crawl-data")
    @ResponseBody
    public ResponseEntity<List<TransactionResponseDTO>> crawlData() {
        List<TransactionResponseDTO> transactions = bankService.crawlData();
        return ResponseEntity.ok(transactions);
    }

    @GetMapping("/api/fetch-transactions")
    @ResponseBody
    public ResponseEntity<List<TransactionResponseDTO>> fetchTransactions(HttpSession session) {
        boolean loginSuccess = bankService.login();

        // Navigate to notification page to get authkey
        bankService.login();
        String authkey = bankService.extractAuthKeyFromLogs();
        session.setAttribute("authkey", authkey);

        // Use authkey to fetch transactions
        List<TransactionResponseDTO> transactions = bankService.apiFetchTransactions(authkey);
        return ResponseEntity.ok(transactions);
    }
}