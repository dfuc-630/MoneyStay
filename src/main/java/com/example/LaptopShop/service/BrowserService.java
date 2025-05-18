package com.example.LaptopShop.service;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.springframework.beans.factory.annotation.Value;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

@Service
public class BrowserService {

    private WebDriver browser;

    @Value("${browser.headless:false}")
    private boolean headless;

    @PostConstruct
    public void init() {
        WebDriverManager.chromedriver().setup();
    }

    public WebDriver setupBrowser() {
        if (browser != null) {
            return browser;
        }

        ChromeOptions options = new ChromeOptions();

        if (headless) {
            options.addArguments("--headless=new");
            options.addArguments("--disable-gpu");
            options.addArguments("--window-size=1920,1080");
        }

        // Set notification permissions
        Map<String, Object> prefs = new HashMap<>();
        prefs.put("profile.default_content_setting_values.notifications", 1);
        prefs.put("profile.managed_default_content_settings.notifications", 1);

        Map<String, Object> contentSettings = new HashMap<>();
        contentSettings.put("setting", 1);

        Map<String, Object> notificationPref = new HashMap<>();
        notificationPref.put("https://neo.vpbank.com.vn:443,*", contentSettings);

        prefs.put("profile.content_settings.exceptions.notifications", notificationPref);

        options.setExperimentalOption("prefs", prefs);
        options.setExperimentalOption("excludeSwitches", new String[] { "enable-automation" });
        options.setExperimentalOption("useAutomationExtension", false);
        options.addArguments("--disable-blink-features=AutomationControlled");

        Map<String, Object> loggingPrefs = new HashMap<>();
        loggingPrefs.put("performance", "ALL");
        options.setCapability("goog:loggingPrefs", loggingPrefs);

        browser = new ChromeDriver(options);
        return browser;
    }

    public WebElement findElement(By by, int timeoutSeconds) {
        WebDriverWait wait = new WebDriverWait(browser, Duration.ofSeconds(timeoutSeconds));
        return wait.until(ExpectedConditions.presenceOfElementLocated(by));
    }

    @PreDestroy
    public void cleanup() {
        if (browser != null) {
            browser.quit();
            browser = null;
        }
    }
}