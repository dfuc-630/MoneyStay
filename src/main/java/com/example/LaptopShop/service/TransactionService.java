package com.example.LaptopShop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.repository.TransactionsRepository;

@Service
public class TransactionService {
    private final TransactionsRepository transactionsRepository;

    public TransactionService(TransactionsRepository transactionsRepository) {
        this.transactionsRepository = transactionsRepository;
    }

    public List<Transactions> getAllTransaction() {
        return this.transactionsRepository.findAll();

    }

}
