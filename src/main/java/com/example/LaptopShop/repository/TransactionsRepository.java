package com.example.LaptopShop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.LaptopShop.domain.Transactions;

@Repository
public interface TransactionsRepository extends JpaRepository<Transactions, Long> {

}
