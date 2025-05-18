package com.example.LaptopShop.service;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.json.JSONArray;
import org.json.JSONObject;
import com.example.LaptopShop.domain.Transactions;
import com.example.LaptopShop.domain.dto.TransactionResponseDTO;
import com.example.LaptopShop.repository.TransactionsRepository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.time.Duration;

@Service
public class BankService {

    @Autowired
    private BrowserService browserService;

    @Autowired
    private TransactionsRepository transactionRepository;

    private String keyshare;
    private String pinshare;
    private int previousTransactionCount = 0;

    private final RestTemplate restTemplate = new RestTemplate();

    public void setCredentials(String keyshare, String pinshare) {
        this.keyshare = keyshare;
        this.pinshare = pinshare;
    }

    public boolean login() {
        try {
            WebDriver browser = browserService.setupBrowser();
            browser.get("https://neo.vpbank.com.vn/notification.html");

            // Enable notifications via JavaScript
            ((JavascriptExecutor) browser).executeScript(
                    "Object.defineProperty(Notification, 'permission', {" +
                            "    get: function() { return 'granted'; }" +
                            "});");

            if (keyshare == null || pinshare == null) {
                return false;
            }

            WebElement keyShareInput = browserService.findElement(By.id("keyShare"), 30);
            WebElement pinShareInput = browserService.findElement(By.id("pinShare"), 30);

            if (keyShareInput == null || pinShareInput == null) {
                return false;
            }

            keyShareInput.sendKeys(keyshare);
            pinShareInput.sendKeys(pinshare);

            WebElement submitButton = browserService.findElement(By.id("btnSubmit"), 30);
            if (submitButton == null) {
                return false;
            }

            submitButton.click();
            Thread.sleep(3000);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<TransactionResponseDTO> extractVisibleTransactions() {
        List<TransactionResponseDTO> transactions = new ArrayList<>();
        WebDriver browser = browserService.setupBrowser();

        try {
            // Wait for data list to load
            WebDriverWait wait = new WebDriverWait(browser, Duration.ofSeconds(20));
            wait.until(ExpectedConditions.presenceOfElementLocated(By.id("dataList")));

            // Find all tables within dataList
            List<WebElement> tables = browser.findElements(By.cssSelector("#dataList table"));

            for (WebElement table : tables) {
                if (!table.isDisplayed()) {
                    continue;
                }

                List<WebElement> rows = table.findElements(By.tagName("tr"));
                TransactionResponseDTO transaction = new TransactionResponseDTO();

                for (WebElement row : rows) {
                    List<WebElement> tds = row.findElements(By.tagName("td"));
                    if (tds.size() != 2) {
                        continue;
                    }

                    String label = tds.get(0).getText().trim();
                    String value = tds.get(1).getText().trim();

                    if (label.contains("Tài khoản")) {
                        transaction.setAccount(label.replaceAll("Tài khoản", "").trim());
                        transaction.setAmount(safeDecimal(value));
                    } else if (label.contains("Số dư sau giao dịch")) {
                        transaction.setBalance(safeDecimal(value));
                    } else if (label.contains("Nội dung")) {
                        transaction.setDescription(value);
                    } else if (label.contains("Thời gian")) {
                        transaction.setTransactionDate(parseDateTime(value));
                    }
                }

                if (transaction.getAccount() != null && transaction.getAmount() != null) {
                    transactions.add(transaction);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactions;
    }

    private BigDecimal safeDecimal(String value) {
        try {
            if (value == null || value.isEmpty()) {
                return BigDecimal.ZERO;
            }

            String cleaned = value
                    .replace('\u2212', '-')
                    .replace(",", "")
                    .replace("VND", "")
                    .trim();

            return new BigDecimal(cleaned);
        } catch (Exception e) {
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }

    private LocalDateTime parseDateTime(String timeStr) {
        try {
            timeStr = timeStr.trim();

            // If time doesn't have seconds, add ":00"
            if (timeStr.matches("\\d{2}/\\d{2}/\\d{4} \\d{2}:\\d{2}")) {
                timeStr += ":00";
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            return LocalDateTime.parse(timeStr, formatter);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<TransactionResponseDTO> crawlData() {
        try {
            WebDriver browser = browserService.setupBrowser();
            browser.get("https://neo.vpbank.com.vn/notification-list.html");
            Thread.sleep(3000);

            List<TransactionResponseDTO> transactions = extractVisibleTransactions();
            int currentTransactionCount = 0;
            List<TransactionResponseDTO> newTransactions = new ArrayList<>();

            // Process transactions in reverse order (oldest to newest)
            for (int i = transactions.size() - 1; i >= 0; i--) {
                currentTransactionCount++;
                if (currentTransactionCount > previousTransactionCount) {
                    newTransactions.add(transactions.get(i));
                }
            }

            // Save new transactions to database
            if (!newTransactions.isEmpty()) {
                for (TransactionResponseDTO txn : newTransactions) {
                    saveTransaction(txn);
                }
            }

            // Update previous transaction count
            if (currentTransactionCount > previousTransactionCount) {
                previousTransactionCount = currentTransactionCount;
            }

            return transactions;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    private void saveTransaction(TransactionResponseDTO txn) {
        try {
            String description = txn.getDescription();

            Pattern senderPattern = Pattern.compile("NHAN TU (\\d+)");
            Pattern transactionIdPattern = Pattern.compile("TRACE (\\d+)");

            Matcher senderMatcher = senderPattern.matcher(description);
            Matcher transactionIdMatcher = transactionIdPattern.matcher(description);

            String senderBankUserName = senderMatcher.find() ? senderMatcher.group(1) : "";
            String transactionId = transactionIdMatcher.find() ? transactionIdMatcher.group(1) : "";

            // Transactions transaction = new Transactions(
            // txn.getAmount(),
            // txn.getBalance(),
            // description,
            // txn.getTransactionDate(),
            // senderBankUserName,
            // transactionId);

            // transactionRepository.save(transaction);

            // Check for reference ID in description for webhook
            Pattern referencePattern = Pattern.compile("\\bSL\\d{9}\\b");
            Matcher referenceMatcher = referencePattern.matcher(description);

            if (referenceMatcher.find()) {
                String referenceId = referenceMatcher.group(0);
                sendWebhook(txn, referenceId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendWebhook(TransactionResponseDTO txn, String referenceId) {
        try {
            Map<String, Object> payload = new HashMap<>();
            payload.put("account", txn.getAccount());
            payload.put("amount", txn.getAmount().toString());
            payload.put("balance", txn.getBalance().toString());
            payload.put("description", txn.getDescription());

            if (txn.getTransactionDate() != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                payload.put("time", txn.getTransactionDate().format(formatter));
            } else {
                payload.put("time", null);
            }

            payload.put("reference_id", referenceId);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(payload, headers);

            restTemplate.postForEntity(
                    "https://test-api.soulence.avtvn.com/api/v1/webhook/payment/",
                    request,
                    String.class);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String extractAuthKeyFromLogs() {
        WebDriver browser = browserService.setupBrowser();
        try {
            List<LogEntry> logs = browser.manage().logs().get("performance").getAll();

            for (LogEntry log : logs) {
                JSONObject messageJson = new JSONObject(log.getMessage());
                JSONObject message = messageJson.getJSONObject("message");

                if ("Network.requestWillBeSent".equals(message.getString("method"))) {
                    JSONObject params = message.getJSONObject("params");
                    JSONObject request = params.getJSONObject("request");
                    String requestUrl = request.getString("url");

                    if (requestUrl.contains("GetNonSecureNotificationShare")) {
                        JSONObject headers = request.getJSONObject("headers");

                        // Try to find authkey in headers
                        String authkey = null;
                        if (headers.has("authkey")) {
                            authkey = headers.getString("authkey");
                        } else if (headers.has("AuthKey")) {
                            authkey = headers.getString("AuthKey");
                        } else if (headers.has("Authorization")) {
                            authkey = headers.getString("Authorization");
                        }

                        return authkey;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<TransactionResponseDTO> apiFetchTransactions(String authkey) {
        WebDriver browser = browserService.setupBrowser();

        try {
            Map<String, String> headers = new HashMap<>();
            headers.put("accept", "application/json");
            headers.put("accept-encoding", "gzip, deflate, br, zstd");
            headers.put("accept-language", "en-US,en;q=0.9");
            headers.put("authkey", authkey);
            headers.put("content-type", "application/json");
            headers.put("priority", "u=1, i");
            headers.put("referer", "https://neo.vpbank.com.vn/notification-list.html");
            headers.put("sec-ch-ua", "\"Google Chrome\";v=\"135\", \"Not-A.Brand\";v=\"8\", \"Chromium\";v=\"135\"");
            headers.put("sec-ch-ua-mobile", "?0");
            headers.put("sec-ch-ua-platform", "\"Windows\"");
            headers.put("sec-fetch-dest", "empty");
            headers.put("sec-fetch-mode", "cors");
            headers.put("sec-fetch-site", "same-origin");
            headers.put("user-agent",
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36");
            headers.put("x-requested-with", "XMLHttpRequest");

            StringBuilder headersJson = new StringBuilder("{\n");
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                headersJson.append("\"").append(entry.getKey()).append("\": \"")
                        .append(entry.getValue()).append("\",\n");
            }
            headersJson.append("}");

            String script = String.format(
                    "const headers = %s;\n" +
                            "fetch(\"https://neo.vpbank.com.vn/cb/odata/ns/authenticationservice/GetNonSecureNotificationShare\", {\n"
                            +
                            "    method: \"GET\",\n" +
                            "    headers: headers,\n" +
                            "    credentials: \"include\"\n" +
                            "})\n" +
                            ".then(response => response.text())\n" +
                            ".then(text => {\n" +
                            "    window.myFetchResponse = text;\n" +
                            "    console.log(\"=== RESPONSE TEXT ===\");\n" +
                            "    console.log(text);\n" +
                            "})\n" +
                            ".catch(error => {\n" +
                            "    console.error(\"Fetch error:\", error);\n" +
                            "    window.myFetchResponse = \"ERROR: \" + error;\n" +
                            "});",
                    headersJson.toString());

            ((JavascriptExecutor) browser).executeScript(script);
            Thread.sleep(5000);
            String responseText = (String) ((JavascriptExecutor) browser)
                    .executeScript("return window.myFetchResponse;");

            if (responseText == null || responseText.trim().length() < 100) {
                return Collections.emptyList();
            }

            return parseNotificationTransactions(responseText);

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    private List<TransactionResponseDTO> parseNotificationTransactions(String responseText) {
        List<TransactionResponseDTO> results = new ArrayList<>();

        try {
            JSONObject data = new JSONObject(responseText);
            JSONObject d = data.getJSONObject("d");
            JSONArray notifications = d.getJSONArray("results");

            for (int i = 0; i < notifications.length(); i++) {
                JSONObject item = notifications.getJSONObject(i);
                String content = item.getString("Content");

                if (content.isEmpty()) {
                    continue;
                }

                // Parse VPBank notification format
                Pattern pattern = Pattern.compile(
                        "VPB:(\\d{2}/\\d{2}/\\d{4} \\d{2}:\\d{2})\\|([X\\d]+)\\|(-?\\d+)VND\\|(\\d+)VND\\|(.+)");
                Matcher matcher = pattern.matcher(content);

                if (matcher.find()) {
                    String dateStr = matcher.group(1);
                    String account = matcher.group(2);
                    String amountStr = matcher.group(3);
                    String balanceStr = matcher.group(4);
                    String description = matcher.group(5).trim();

                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                    LocalDateTime parsedDate;
                    try {
                        parsedDate = LocalDateTime.parse(dateStr, formatter);
                    } catch (Exception e) {
                        parsedDate = null;
                    }

                    TransactionResponseDTO transaction = new TransactionResponseDTO();
                    transaction.setAccount(account);
                    transaction.setAmount(new BigDecimal(amountStr));
                    transaction.setBalance(new BigDecimal(balanceStr));
                    transaction.setDescription(description);
                    transaction.setTransactionDate(parsedDate);

                    results.add(transaction);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }
}
