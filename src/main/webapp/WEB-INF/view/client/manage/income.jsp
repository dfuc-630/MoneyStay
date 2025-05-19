<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Income Transactions</title>
                    <link href="/css/styles.css" rel="stylesheet" />

                    <style>
                        /* Color definitions for both buttons and table cells */
                        .cat-salary,
                        .btn-salary {
                            color: #4CAF50 !important;
                            font-weight: bold;
                        }

                        .cat-other-income,
                        .btn-other-income {
                            color: #2196F3 !important;
                            font-weight: bold;
                        }

                        .cat-transferred-in,
                        .btn-transferred-in {
                            color: #9C27B0 !important;
                            font-weight: bold;
                        }

                        .cat-interest,
                        .btn-interest {
                            color: #FF9800 !important;
                            font-weight: bold;
                        }

                        .cat-uncategorized-income,
                        .btn-uncategorized-income {
                            color: #E91E63 !important;
                            font-weight: bold;
                        }


                        /* Button styles when active */
                        .category-btn.active,
                        .time-filter-btn.active,
                        .sorting-btn.active {
                            background-color: #f8f9fa;
                            border-color: #343a40;
                            font-weight: bold;
                        }

                        /* Matching border colors for buttons */
                        .btn-salary {
                            border-color: #4CAF50 !important;
                        }

                        .btn-other-income {
                            border-color: #2196F3 !important;
                        }

                        .btn-transferred-in {
                            border-color: #9C27B0 !important;
                        }

                        .btn-interest {
                            border-color: #FF9800 !important;
                        }

                        .btn-uncategorized-income {
                            border-color: #E91E63 !important;
                        }


                        /* Summary box styling */
                        .summary-box {
                            background-color: #f8f9fa;
                            border-radius: 8px;
                            padding: 15px;
                            margin-bottom: 20px;
                            border: 1px solid #ddd;
                        }

                        .summary-title {
                            font-weight: bold;
                            margin-bottom: 10px;
                        }

                        .summary-value {
                            font-size: 1.5rem;
                            font-weight: bold;
                            color: #4CAF50;
                        }

                        /* Date range selector */
                        .date-range-selector {
                            margin-bottom: 15px;
                        }
                    </style>

                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../../admin/layout/header2.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../../admin/layout/sidebar2.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid">
                                    <h2 class="text-center text-primary">Danh sách giao dịch thu nhập</h2>

                                    <!-- Summary boxes for total incomes -->
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <div class="summary-box">
                                                <div class="summary-title">Tổng thu nhập hiện tại</div>
                                                <div class="summary-value" id="current-total">0</div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="summary-box">
                                                <div class="summary-title">Tổng thu nhập tháng này</div>
                                                <div class="summary-value" id="monthly-total">0</div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="summary-box">
                                                <div class="summary-title">Tổng thu nhập tuần này</div>
                                                <div class="summary-value" id="weekly-total">0</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Date range selector -->
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="date-range-selector">
                                                <div class="input-group">
                                                    <span class="input-group-text">Từ ngày</span>
                                                    <input type="date" id="start-date" class="form-control">
                                                    <span class="input-group-text">Đến ngày</span>
                                                    <input type="date" id="end-date" class="form-control">
                                                    <button class="btn btn-primary" id="apply-date-filter">Áp
                                                        dụng</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3 text-end">
                                                <button class="btn btn-outline-primary m-1 time-filter-btn active"
                                                    data-timefilter="all">Tất cả</button>
                                                <button class="btn btn-outline-primary m-1 time-filter-btn"
                                                    data-timefilter="thisWeek">Tuần này</button>
                                                <button class="btn btn-outline-primary m-1 time-filter-btn"
                                                    data-timefilter="thisMonth">Tháng này</button>
                                                <button class="btn btn-outline-primary m-1 time-filter-btn"
                                                    data-timefilter="lastMonth">Tháng trước</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Income category buttons -->
                                    <div class="mb-3 text-center">
                                        <button class="btn btn-outline-primary m-1 category-btn active"
                                            data-category="all">All</button>
                                        <button class="btn btn-outline-secondary m-1 category-btn btn-salary"
                                            data-category="Salary">Salary</button>
                                        <button class="btn btn-outline-secondary m-1 category-btn btn-other-income"
                                            data-category="Other Income">Other Income</button>
                                        <button class="btn btn-outline-secondary m-1 category-btn btn-transferred-in"
                                            data-category="Transferred In">Transferred In</button>
                                        <button class="btn btn-outline-secondary m-1 category-btn btn-interest"
                                            data-category="Interest">Interest</button>
                                        <button
                                            class="btn btn-outline-secondary m-1 category-btn btn-uncategorized-income"
                                            data-category="Uncategorized Income">Uncategorized Income</button>

                                    </div>

                                    <!-- Sorting options -->
                                    <div class="mb-3">
                                        <div class="btn-group">
                                            <button class="btn btn-outline-secondary sorting-btn" data-sort="date-desc">
                                                <i class="fas fa-calendar-alt"></i> Ngày (Mới nhất)
                                            </button>
                                            <button class="btn btn-outline-secondary sorting-btn" data-sort="date-asc">
                                                <i class="fas fa-calendar-alt"></i> Ngày (Cũ nhất)
                                            </button>
                                            <button class="btn btn-outline-secondary sorting-btn"
                                                data-sort="amount-asc">
                                                <i class="fas fa-sort-amount-up-alt"></i> Số tiền (Thấp đến cao)
                                            </button>
                                            <button class="btn btn-outline-secondary sorting-btn"
                                                data-sort="amount-desc">
                                                <i class="fas fa-sort-amount-down"></i> Số tiền (Cao đến thấp)
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Income transactions table -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Ngày giao dịch</th>
                                                    <th>Ngày hiệu lực</th>
                                                    <th>Mô tả</th>
                                                    <th>Mã giao dịch</th>
                                                    <th>Số tiền chi</th>
                                                    <th class="text-end">Số tiền nhận (Income)</th>
                                                    <th class="text-end">Số dư</th>
                                                    <th>Thể loại</th>
                                                </tr>
                                            </thead>
                                            <tbody id="transaction-tbody">
                                                <c:forEach var="transaction" items="${incomeTransactions}">
                                                    <tr class="transaction-row"
                                                        data-category="${transaction.income.groupName}"
                                                        data-date="${transaction.transactiondate}"
                                                        data-amount="${transaction.credit}">
                                                        <td>${transaction.transactiondate}</td>
                                                        <td>${transaction.effectivedate}</td>
                                                        <td>${transaction.description}</td>
                                                        <td>${transaction.transactioncode}</td>
                                                        <td>${transaction.debit}</td>
                                                        <td class="text-end text-success">
                                                            <strong>${transaction.credit}</strong>
                                                        </td>
                                                        <td class="text-end">${transaction.balance}</td>
                                                        <td class="category-cell"
                                                            data-group="${transaction.income.groupName}">
                                                            ${transaction.income.name}
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </main>

                            <jsp:include page="../../admin/layout/footer2.jsp" />
                        </div>
                    </div>

                    <!-- Script for filtering and sorting transactions -->
                    <script>
                        $(document).ready(function () {
                            // Apply colors to categories immediately
                            applyColorsToCategories();

                            // Set default dates
                            setDefaultDates();

                            // Make sure rows have proper data attributes for filtering and sorting
                            prepareRowData();

                            // Initialize with all transactions visible and date-desc sort as default
                            $(".sorting-btn[data-sort='date-desc']").addClass("active");
                            sortTransactions("date-desc");
                            calculateTotals();

                            // Category filter functionality
                            $(".category-btn").click(function () {
                                // Update active state
                                $(".category-btn").removeClass("active");
                                $(this).addClass("active");

                                // Apply filters
                                applyFilters();
                                calculateTotals();
                            });

                            // Time filter functionality
                            $(".time-filter-btn").click(function () {
                                // Update active state
                                $(".time-filter-btn").removeClass("active");
                                $(this).addClass("active");

                                // Apply filters
                                applyFilters();
                                calculateTotals();
                            });

                            // Date range filter
                            $("#apply-date-filter").click(function () {
                                // Clear time filter buttons active state
                                $(".time-filter-btn").removeClass("active");

                                // Apply filters
                                applyFilters();
                                calculateTotals();
                            });

                            // Sorting functionality
                            $(".sorting-btn").click(function () {
                                // Update active state
                                $(".sorting-btn").removeClass("active");
                                $(this).addClass("active");

                                // Apply sorting
                                sortTransactions($(this).data("sort"));
                            });

                            // Function to ensure each row has correct data attributes
                            function prepareRowData() {
                                $(".transaction-row").each(function () {
                                    // Get date from first cell if not set
                                    if (!$(this).data("date")) {
                                        const dateText = $(this).find("td:first").text().trim();
                                        $(this).attr("data-date", dateText);
                                    }

                                    // Get amount from credit column (6th column) if not set
                                    if (!$(this).data("amount")) {
                                        const amountText = $(this).find("td:eq(5)").text().trim();
                                        let cleanAmount = amountText.replace(/[^\d,.]/g, '');
                                        cleanAmount = cleanAmount.replace(/,/g, '');
                                        $(this).attr("data-amount", cleanAmount);
                                    }

                                    // Get category from category cell if not set
                                    if (!$(this).data("category")) {
                                        const groupName = $(this).find(".category-cell").data("group");
                                        if (groupName) {
                                            $(this).attr("data-category", groupName);
                                        }
                                    }
                                });
                            }

                            // Function to set default dates
                            function setDefaultDates() {
                                const today = new Date();
                                const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

                                // Format dates as YYYY-MM-DD
                                const formatDate = (date) => {
                                    const year = date.getFullYear();
                                    const month = String(date.getMonth() + 1).padStart(2, '0');
                                    const day = String(date.getDate()).padStart(2, '0');
                                    return `${year}-${month}-${day}`;
                                };

                                $("#start-date").val(formatDate(startOfMonth));
                                $("#end-date").val(formatDate(today));
                            }

                            // Function to parse dates correctly
                            function parseTransactionDate(dateStr) {
                                // Check the format of dateStr and parse accordingly
                                if (!dateStr) return null;

                                // Handle DD/MM/YYYY HH:MM:SS format
                                if (dateStr.includes('/') && dateStr.includes(':')) {
                                    // Extract just the date part DD/MM/YYYY
                                    const datePart = dateStr.split(' ')[0];
                                    const parts = datePart.split('/');

                                    if (parts.length === 3) {
                                        // Format is DD/MM/YYYY
                                        const day = parseInt(parts[0]);
                                        const month = parseInt(parts[1]) - 1; // Months are 0-indexed in JS
                                        const year = parseInt(parts[2]);

                                        const date = new Date(year, month, day);
                                        return date;
                                    }
                                }
                                // Handle DD/MM/YYYY format without time
                                else if (dateStr.includes('/')) {
                                    const parts = dateStr.split('/');
                                    if (parts.length === 3) {
                                        // Format is DD/MM/YYYY
                                        const day = parseInt(parts[0]);
                                        const month = parseInt(parts[1]) - 1; // Months are 0-indexed in JS
                                        const year = parseInt(parts[2]);

                                        const date = new Date(year, month, day);
                                        return date;
                                    }
                                }
                                // Check if format is YYYY-MM-DD
                                else if (dateStr.includes('-')) {
                                    const date = new Date(dateStr);
                                    return date;
                                }

                                // Try standard parsing as fallback
                                const date = new Date(dateStr);
                                if (!isNaN(date.getTime())) {
                                    return date;
                                }

                                console.error("Failed to parse date:", dateStr);
                                return null;
                            }

                            // Function to apply all filters (category and time)
                            function applyFilters() {
                                const selectedCategory = $(".category-btn.active").data("category") || "all";
                                const selectedTimeFilter = $(".time-filter-btn.active").data("timefilter") || "all";
                                const startDate = $("#start-date").val() ? new Date($("#start-date").val()) : null;
                                const endDate = $("#end-date").val() ? new Date($("#end-date").val()) : null;

                                // Set end date to end of day
                                if (endDate) {
                                    endDate.setHours(23, 59, 59, 999);
                                }

                                $(".transaction-row").each(function () {
                                    const rowCategory = $(this).data("category");
                                    const rowDateStr = $(this).data("date");
                                    const rowDate = parseTransactionDate(rowDateStr);

                                    if (!rowDate) {
                                        $(this).hide();
                                        return;
                                    }

                                    let showByCategory = (selectedCategory === "all" || rowCategory === selectedCategory);
                                    let showByTime = true;

                                    // Apply time filter
                                    if (selectedTimeFilter && selectedTimeFilter !== "all") {
                                        const today = new Date();
                                        const currentDay = today.getDay(); // 0 = Sunday, 6 = Saturday

                                        // Calculate start of week (Sunday)
                                        const startOfWeek = new Date(today);
                                        startOfWeek.setDate(today.getDate() - currentDay);
                                        startOfWeek.setHours(0, 0, 0, 0);

                                        // Calculate start of month
                                        const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

                                        // Calculate start of last month
                                        const startOfLastMonth = new Date(today.getFullYear(), today.getMonth() - 1, 1);
                                        const endOfLastMonth = new Date(today.getFullYear(), today.getMonth(), 0, 23, 59, 59, 999);

                                        if (selectedTimeFilter === "thisWeek") {
                                            showByTime = rowDate >= startOfWeek && rowDate <= today;
                                        } else if (selectedTimeFilter === "thisMonth") {
                                            showByTime = rowDate >= startOfMonth && rowDate <= today;
                                        } else if (selectedTimeFilter === "lastMonth") {
                                            showByTime = rowDate >= startOfLastMonth && rowDate <= endOfLastMonth;
                                        }
                                    } else if (startDate && endDate) {
                                        // Apply custom date range
                                        showByTime = rowDate >= startDate && rowDate <= endDate;
                                    }

                                    // Show/hide based on combined filters
                                    if (showByCategory && showByTime) {
                                        $(this).show();
                                    } else {
                                        $(this).hide();
                                    }
                                });
                            }

                            // Function to sort transactions
                            function sortTransactions(sortType) {
                                const tbody = $("#transaction-tbody");
                                const rows = tbody.find("tr").toArray();

                                rows.sort(function (a, b) {
                                    if (sortType === "date-asc" || sortType === "date-desc") {
                                        const dateAStr = $(a).data("date");
                                        const dateBStr = $(b).data("date");

                                        const dateA = parseTransactionDate(dateAStr);
                                        const dateB = parseTransactionDate(dateBStr);

                                        if (!dateA && !dateB) return 0;
                                        if (!dateA) return 1;
                                        if (!dateB) return -1;

                                        return sortType === "date-asc" ?
                                            dateA.getTime() - dateB.getTime() :
                                            dateB.getTime() - dateA.getTime();
                                    } else {
                                        // For amount sorting, extract and parse the amounts
                                        let amountAText = $(a).data("amount") || "0";
                                        let amountBText = $(b).data("amount") || "0";

                                        if (typeof amountAText !== 'string') amountAText = String(amountAText);
                                        if (typeof amountBText !== 'string') amountBText = String(amountBText);

                                        // Clean up the amounts (remove currency symbols, commas)
                                        let cleanAmountA = amountAText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                        let cleanAmountB = amountBText.replace(/[^\d,.]/g, '').replace(/,/g, '');

                                        const amountA = parseFloat(cleanAmountA) || 0;
                                        const amountB = parseFloat(cleanAmountB) || 0;

                                        return sortType === "amount-asc" ?
                                            amountA - amountB :
                                            amountB - amountA;
                                    }
                                });

                                // Re-append sorted rows
                                $.each(rows, function (index, row) {
                                    tbody.append(row);
                                });
                            }

                            // Calculate totals for displayed transactions
                            function calculateTotals() {
                                let currentTotal = 0;
                                let monthlyTotal = 0;
                                let weeklyTotal = 0;

                                const today = new Date();
                                const currentMonth = today.getMonth();
                                const currentYear = today.getFullYear();

                                // Calculate start of week (Sunday)
                                const currentDay = today.getDay();
                                const startOfWeek = new Date(today);
                                startOfWeek.setDate(today.getDate() - currentDay);
                                startOfWeek.setHours(0, 0, 0, 0);

                                // Calculate start and end of current month
                                const startOfMonth = new Date(currentYear, currentMonth, 1);
                                const endOfMonth = new Date(currentYear, currentMonth + 1, 0, 23, 59, 59, 999);

                                $(".transaction-row:visible").each(function () {
                                    // Parse amount correctly - handle VND format with commas
                                    let amountText = $(this).data("amount") || "";
                                    if (typeof amountText !== 'string') {
                                        amountText = String(amountText);
                                    }

                                    // Extract just the number part from formats like "18,000 VND"
                                    let cleanAmount = amountText.replace(/[^\d,.]/g, '');
                                    // Replace commas with empty string (for thousand separators)
                                    cleanAmount = cleanAmount.replace(/,/g, '');

                                    let amount = parseFloat(cleanAmount) || 0;

                                    // Get amount from the credit column as backup
                                    if (amount === 0) {
                                        const creditText = $(this).find("td:eq(5)").text().trim(); // 6th column (0-indexed)
                                        if (creditText) {
                                            let creditAmount = creditText.replace(/[^\d,.]/g, '');
                                            creditAmount = creditAmount.replace(/,/g, '');
                                            const parsedCredit = parseFloat(creditAmount) || 0;
                                            if (parsedCredit > 0) {
                                                amount = parsedCredit;
                                            }
                                        }
                                    }

                                    // Parse date
                                    const rowDateStr = $(this).data("date");
                                    let rowDate = parseTransactionDate(rowDateStr);

                                    if (!rowDate) {
                                        // Try to get date from first column as backup
                                        const dateCell = $(this).find("td:first").text().trim();
                                        const backupDate = parseTransactionDate(dateCell);

                                        if (!backupDate) {
                                            console.error("Could not parse date for row:", $(this));
                                            return;
                                        }

                                        rowDate = backupDate;
                                    }

                                    // Add to current total (all visible transactions)
                                    currentTotal += amount;

                                    // Check if transaction is in current month
                                    if (rowDate >= startOfMonth && rowDate <= endOfMonth) {
                                        monthlyTotal += amount;
                                    }

                                    // Check if transaction is in current week
                                    if (rowDate >= startOfWeek && rowDate <= today) {
                                        weeklyTotal += amount;
                                    }
                                });

                                // Format numbers with commas
                                function formatNumber(num) {
                                    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                }

                                // Update summary boxes
                                $("#current-total").text(formatNumber(currentTotal.toFixed(0)) + " VND");
                                $("#monthly-total").text(formatNumber(monthlyTotal.toFixed(0)) + " VND");
                                $("#weekly-total").text(formatNumber(weeklyTotal.toFixed(0)) + " VND");
                            }

                            // Function to apply colors to categories
                            function applyColorsToCategories() {
                                // First, apply colors to the category cells based on the group name
                                $(".category-cell").each(function () {
                                    const groupName = $(this).data("group");

                                    // Remove any existing color classes
                                    $(this).removeClass("cat-salary cat-other-income cat-transferred-in cat-interest cat-uncategorized-income");

                                    // Apply the appropriate class based on groupName
                                    switch (groupName) {
                                        case "Salary":
                                            $(this).addClass("cat-salary");
                                            break;
                                        case "Other Income":
                                            $(this).addClass("cat-other-income");
                                            break;
                                        case "Transferred In":
                                            $(this).addClass("cat-transferred-in");
                                            break;
                                        case "Interest":
                                            $(this).addClass("cat-interest");
                                            break;
                                        case "Uncategorized Income":
                                            $(this).addClass("cat-uncategorized-income");
                                            break;
                                    }
                                });
                            }
                        });
                    </script>
                </body>

                </html>