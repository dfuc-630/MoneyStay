package com.example.LaptopShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.LaptopShop.domain.BudgetTarget;

@Repository
public interface BudgetTargetRepository extends JpaRepository<BudgetTarget, Long> {
}