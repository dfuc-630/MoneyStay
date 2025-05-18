package com.example.LaptopShop.domain;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "transactions")
public class Transactions {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String transactiondate;

    private String effectivedate;

    private String description;

    private String transactioncode;

    private String debit;
    private String credit;
    private String balance;

    @ManyToOne
    @JoinColumn(name = "category_id") // đây là cột foreign key trong bảng transactions
    private Categories category;

    // Default constructor
    public Transactions() {
    }

    // Parameterized constructor
    public Transactions(String transactiondate, String effectivedate, String description,
            String transactioncode, String debit, String credit, String balance) {
        this.transactiondate = transactiondate;
        this.effectivedate = effectivedate;
        this.description = description;
        this.transactioncode = transactioncode;
        this.debit = debit;
        this.credit = credit;
        this.balance = balance;
    }

    // Getters and Setters
    public Categories getCategory() {
        return category;
    }

    public void setCategory(Categories category) {
        this.category = category;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTransactiondate() {
        return transactiondate;
    }

    public void setTransactiondate(String transactiondate) {
        this.transactiondate = transactiondate;
    }

    public String getEffectivedate() {
        return effectivedate;
    }

    public void setEffectivedate(String effectivedate) {
        this.effectivedate = effectivedate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTransactioncode() {
        return transactioncode;
    }

    public void setTransactioncode(String transactioncode) {
        this.transactioncode = transactioncode;
    }

    public String getDebit() {
        return debit;
    }

    public void setDebit(String debit) {
        this.debit = debit;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }
}