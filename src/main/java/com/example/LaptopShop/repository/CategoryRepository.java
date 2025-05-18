package com.example.LaptopShop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.LaptopShop.domain.Categories;

@Repository
public interface CategoryRepository extends JpaRepository<Categories, Integer> {

}
