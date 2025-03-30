package com.example.LaptopShop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class TransactionCacheService {
    private List<Map<String, String>> transactions = new ArrayList<>();

    public List<Map<String, String>> getTransactions() {
        return transactions;
    }

    public void setTransactions(List<Map<String, String>> transactions) {
        this.transactions = transactions;
    }
}
