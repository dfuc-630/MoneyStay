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
                    <!-- Add Chart.js CDN -->
                    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>

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

                        /* Chart container styling */
                        .chart-container {
                            max-width: 600px;
                            margin: 20px auto;
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

                                    <!-- Charts section -->
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <div class="chart-container">
                                                <canvas id="categoryPieChart"></canvas>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="chart-container">
                                                <canvas id="incomeTrendChart"></canvas>
                                            </div>
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
                                                            ${transaction.income.name}</td>
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

                    <!-- Script for filtering, sorting, and chart rendering -->
                    <script>
                        $(document).ready(function () {
                            // Chart.js objects
                            let categoryPieChart = null;
                            let incomeTrendChart = null;

                            // Category colors for consistency
                            const categoryColors = {
                                "Salary": "#4CAF50",
                                "Other Income": "#2196F3",
                                "Transferred In": "#9C27B0",
                                "Interest": "#FF9800",
                                "Uncategorized Income": "#E91E63"
                            };

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
                            updateCharts();

                            // Category filter functionality
                            $(".category-btn").click(function () {
                                $(".category-btn").removeClass("active");
                                $(this).addClass("active");
                                applyFilters();
                                calculateTotals();
                                updateCharts();
                            });

                            // Time filter functionality
                            $(".time-filter-btn").click(function () {
                                $(".time-filter-btn").removeClass("active");
                                $(this).addClass("active");
                                applyFilters();
                                calculateTotals();
                                updateCharts();
                            });

                            // Date range filter
                            $("#apply-date-filter").click(function () {
                                $(".time-filter-btn").removeClass("active");
                                applyFilters();
                                calculateTotals();
                                updateCharts();
                            });

                            // Sorting functionality
                            $(".sorting-btn").click(function () {
                                $(".sorting-btn").removeClass("active");
                                $(this).addClass("active");
                                sortTransactions($(this).data("sort"));
                            });

                            // Function to ensure each row has correct data attributes
                            function prepareRowData() {
                                $(".transaction-row").each(function () {
                                    if (!$(this).data("date")) {
                                        const dateText = $(this).find("td:first").text().trim();
                                        $(this).attr("data-date", dateText);
                                    }
                                    if (!$(this).data("amount")) {
                                        const amountText = $(this).find("td:eq(5)").text().trim();
                                        let cleanAmount = amountText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                        $(this).attr("data-amount", cleanAmount);
                                    }
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
                                const formatDate = (date) => {
                                    const year = date.getFullYear();
                                    const month = String(date.getMonth() + 1).padStart(2, '0');
                                    const day = String(date.getDate()).padStart(2, '0');
                                    return `${year}-${month}-${day}`;
                                };
                                $("#start-date").val(formatDate(startOfMonth));
                                $("#end-date").val(formatDate(today));
                            }

                            // Function to parse dates
                            function parseTransactionDate(dateStr) {
                                if (!dateStr) return null;
                                if (dateStr.includes('/') && dateStr.includes(':')) {
                                    const datePart = dateStr.split(' ')[0];
                                    const parts = datePart.split('/');
                                    if (parts.length === 3) {
                                        const day = parseInt(parts[0]);
                                        const month = parseInt(parts[1]) - 1;
                                        const year = parseInt(parts[2]);
                                        return new Date(year, month, day);
                                    }
                                } else if (dateStr.includes('/')) {
                                    const parts = dateStr.split('/');
                                    if (parts.length === 3) {
                                        const day = parseInt(parts[0]);
                                        const month = parseInt(parts[1]) - 1;
                                        const year = parseInt(parts[2]);
                                        return new Date(year, month, day);
                                    }
                                } else if (dateStr.includes('-')) {
                                    return new Date(dateStr);
                                }
                                const date = new Date(dateStr);
                                if (!isNaN(date.getTime())) {
                                    return date;
                                }
                                console.error("Failed to parse date:", dateStr);
                                return null;
                            }

                            // Function to apply all filters
                            function applyFilters() {
                                const selectedCategory = $(".category-btn.active").data("category") || "all";
                                const selectedTimeFilter = $(".time-filter-btn.active").data("timefilter") || "all";
                                const startDate = $("#start-date").val() ? new Date($("#start-date").val()) : null;
                                const endDate = $("#end-date").val() ? new Date($("#end-date").val()) : null;
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

                                    if (selectedTimeFilter && selectedTimeFilter !== "all") {
                                        const today = new Date();
                                        const currentDay = today.getDay();
                                        const startOfWeek = new Date(today);
                                        startOfWeek.setDate(today.getDate() - currentDay);
                                        startOfWeek.setHours(0, 0, 0, 0);
                                        const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
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
                                        showByTime = rowDate >= startDate && rowDate <= endDate;
                                    }

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

                                        return sortType === "date-asc" ? dateA.getTime() - dateB.getTime() : dateB.getTime() - dateA.getTime();
                                    } else {
                                        let amountAText = $(a).data("amount") || "0";
                                        let amountBText = $(b).data("amount") || "0";
                                        if (typeof amountAText !== 'string') amountAText = String(amountAText);
                                        if (typeof amountBText !== 'string') amountBText = String(amountBText);
                                        let cleanAmountA = amountAText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                        let cleanAmountB = amountBText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                        const amountA = parseFloat(cleanAmountA) || 0;
                                        const amountB = parseFloat(cleanAmountB) || 0;
                                        return sortType === "amount-asc" ? amountA - amountB : amountB - amountA;
                                    }
                                });

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
                                const currentDay = today.getDay();
                                const startOfWeek = new Date(today);
                                startOfWeek.setDate(today.getDate() - currentDay);
                                startOfWeek.setHours(0, 0, 0, 0);
                                const startOfMonth = new Date(currentYear, currentMonth, 1);
                                const endOfMonth = new Date(currentYear, currentMonth + 1, 0, 23, 59, 59, 999);

                                $(".transaction-row:visible").each(function () {
                                    let amountText = $(this).data("amount") || "";
                                    if (typeof amountText !== 'string') {
                                        amountText = String(amountText);
                                    }
                                    let cleanAmount = amountText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                    let amount = parseFloat(cleanAmount) || 0;

                                    if (amount === 0) {
                                        const creditText = $(this).find("td:eq(5)").text().trim();
                                        if (creditText) {
                                            let creditAmount = creditText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                            const parsedCredit = parseFloat(creditAmount) || 0;
                                            if (parsedCredit > 0) {
                                                amount = parsedCredit;
                                            }
                                        }
                                    }

                                    const rowDateStr = $(this).data("date");
                                    let rowDate = parseTransactionDate(rowDateStr);
                                    if (!rowDate) {
                                        const dateCell = $(this).find("td:first").text().trim();
                                        const backupDate = parseTransactionDate(dateCell);
                                        if (!backupDate) {
                                            console.error("Could not parse date for row:", $(this));
                                            return;
                                        }
                                        rowDate = backupDate;
                                    }

                                    currentTotal += amount;
                                    if (rowDate >= startOfMonth && rowDate <= endOfMonth) {
                                        monthlyTotal += amount;
                                    }
                                    if (rowDate >= startOfWeek && rowDate <= today) {
                                        weeklyTotal += amount;
                                    }
                                });

                                function formatNumber(num) {
                                    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                }

                                $("#current-total").text(formatNumber(currentTotal.toFixed(0)) + " VND");
                                $("#monthly-total").text(formatNumber(monthlyTotal.toFixed(0)) + " VND");
                                $("#weekly-total").text(formatNumber(weeklyTotal.toFixed(0)) + " VND");
                            }

                            // Function to apply colors to categories
                            function applyColorsToCategories() {
                                $(".category-cell").each(function () {
                                    const groupName = $(this).data("group");
                                    $(this).removeClass("cat-salary cat-other-income cat-transferred-in cat-interest cat-uncategorized-income");
                                    switch (groupName) {
                                        case "Salary": $(this).addClass("cat-salary"); break;
                                        case "Other Income": $(this).addClass("cat-other-income"); break;
                                        case "Transferred In": $(this).addClass("cat-transferred-in"); break;
                                        case "Interest": $(this).addClass("cat-interest"); break;
                                        case "Uncategorized Income": $(this).addClass("cat-uncategorized-income"); break;
                                    }
                                });
                            }

                            // Function to update charts
                            function updateCharts() {
                                // Data for pie chart
                                const categoryTotals = {
                                    "Salary": 0,
                                    "Other Income": 0,
                                    "Transferred In": 0,
                                    "Interest": 0,
                                    "Uncategorized Income": 0
                                };

                                // Data for line chart (daily totals)
                                const dailyTotals = {};
                                const selectedTimeFilter = $(".time-filter-btn.active").data("timefilter") || "all";
                                const startDate = $("#start-date").val() ? new Date($("#start-date").val()) : null;
                                const endDate = $("#end-date").val() ? new Date($("#end-date").val()) : null;

                                $(".transaction-row:visible").each(function () {
                                    const category = $(this).data("category");
                                    let amountText = $(this).data("amount") || "";
                                    if (typeof amountText !== 'string') amountText = String(amountText);
                                    let cleanAmount = amountText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                    let amount = parseFloat(cleanAmount) || 0;

                                    if (amount === 0) {
                                        const creditText = $(this).find("td:eq(5)").text().trim();
                                        if (creditText) {
                                            let creditAmount = creditText.replace(/[^\d,.]/g, '').replace(/,/g, '');
                                            amount = parseFloat(creditAmount) || 0;
                                        }
                                    }

                                    if (category in categoryTotals) {
                                        categoryTotals[category] += amount;
                                    }

                                    const rowDateStr = $(this).data("date");
                                    const rowDate = parseTransactionDate(rowDateStr);
                                    if (rowDate) {
                                        const dateKey = rowDate.toISOString().split('T')[0]; // YYYY-MM-DD
                                        dailyTotals[dateKey] = (dailyTotals[dateKey] || 0) + amount;
                                    }
                                });

                                // Prepare pie chart data
                                const pieData = {
                                    labels: Object.keys(categoryTotals).filter(cat => categoryTotals[cat] > 0),
                                    datasets: [{
                                        data: Object.values(categoryTotals).filter(val => val > 0),
                                        backgroundColor: Object.keys(categoryTotals).filter(cat => categoryTotals[cat] > 0).map(cat => categoryColors[cat])
                                    }]
                                };

                                // Prepare line chart data
                                const dates = Object.keys(dailyTotals).sort();
                                const lineData = {
                                    labels: dates,
                                    datasets: [{
                                        label: 'Income Over Time',
                                        data: dates.map(date => dailyTotals[date]),
                                        borderColor: '#4CAF50',
                                        fill: false
                                    }]
                                };

                                // Destroy existing charts if they exist
                                if (categoryPieChart) {
                                    categoryPieChart.destroy();
                                }
                                if (incomeTrendChart) {
                                    incomeTrendChart.destroy();
                                }

                                // Create pie chart
                                categoryPieChart = new Chart(document.getElementById('categoryPieChart'), {
                                    type: 'pie',
                                    data: pieData,
                                    options: {
                                        plugins: {
                                            title: {
                                                display: true,
                                                text: 'Tỉ lệ thu nhập theo thể loại'
                                            },
                                            legend: {
                                                position: 'bottom'
                                            }
                                        }
                                    }
                                });

                                // Create line chart
                                incomeTrendChart = new Chart(document.getElementById('incomeTrendChart'), {
                                    type: 'line',
                                    data: lineData,
                                    options: {
                                        plugins: {
                                            title: {
                                                display: true,
                                                text: 'Xu hướng thu nhập theo thời gian'
                                            }
                                        },
                                        scales: {
                                            x: {
                                                title: {
                                                    display: true,
                                                    text: 'Date'
                                                }
                                            },
                                            y: {
                                                title: {
                                                    display: true,
                                                    text: 'Amount (VND)'
                                                },
                                                beginAtZero: true
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    </script>
                </body>

                </html>