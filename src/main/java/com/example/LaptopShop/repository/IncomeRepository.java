package com.example.LaptopShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.LaptopShop.domain.Income;

@Repository
public interface IncomeRepository extends JpaRepository<Income, Integer> {

}
