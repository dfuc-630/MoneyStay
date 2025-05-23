<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Quản Lý Tài Chính</title>

                <!-- THÊM DÒNG NÀY -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>


            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header2.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar2.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Tài Chính Cá Nhân</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active">Dashboard</li>
                                </ol>
                                <div class="row">
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-primary text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="totalIncome">0 VNĐ</h4>
                                                <small>Tổng Thu Nhập</small>
                                            </div>
                                            <div class="card-footer d-flex align-items-center justify-content-between">
                                                <a class="small text-white stretched-link" href="#">View Details</a>
                                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-warning text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="totalExpense">0 VNĐ</h4>
                                                <small>Tổng Chi Tiêu</small>
                                            </div>
                                            <div class="card-footer d-flex align-items-center justify-content-between">
                                                <a class="small text-white stretched-link" href="#">View Details</a>
                                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-success text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="netIncome">0 VNĐ</h4>
                                                <small>Thu Nhập Ròng</small>
                                            </div>
                                            <div class="card-footer d-flex align-items-center justify-content-between">
                                                <a class="small text-white stretched-link" href="#">View Details</a>
                                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-danger text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="currentBalance">0 VNĐ</h4>
                                                <small>Số Dư Hiện Tại</small>
                                            </div>
                                            <div class="card-footer d-flex align-items-center justify-content-between">
                                                <a class="small text-white stretched-link" href="#">View Details</a>
                                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-area me-1"></i>
                                                Thu nhập và Chi tiêu theo thời gian
                                            </div>
                                            <div class="card-body"><canvas id="myAreaChart" width="100%"
                                                    height="40"></canvas></div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-bar me-1"></i>
                                                So sánh Thu nhập và Chi tiêu
                                            </div>
                                            <div class="card-body"><canvas id="myBarChart" width="100%"
                                                    height="40"></canvas></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-pie me-1"></i>
                                                Tỷ lệ Thu nhập vs Chi tiêu
                                            </div>
                                            <div class="card-body"><canvas id="myPieChart" width="100%"
                                                    height="300"></canvas></div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-line me-1"></i>
                                                Xu hướng số dư tài khoản
                                            </div>
                                            <div class="card-body"><canvas id="balanceTrendChart" width="100%"
                                                    height="300"></canvas></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-bar me-1"></i>
                                                Thu nhập theo tuần
                                            </div>
                                            <div class="card-body"><canvas id="weeklyIncomeChart" width="100%"
                                                    height="40"></canvas></div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-bar me-1"></i>
                                                Chi tiêu theo tuần
                                            </div>
                                            <div class="card-body"><canvas id="weeklyExpenseChart" width="100%"
                                                    height="40"></canvas></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-12">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-line me-1"></i>
                                                Biểu đồ cash flow (Dòng tiền)
                                            </div>
                                            <div class="card-body"><canvas id="cashFlowChart" width="100%"
                                                    height="20"></canvas></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-table me-1"></i>
                                        Lịch sử giao dịch
                                    </div>
                                    <div class="card-body">
                                        <table id="datatablesSimple" class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Ngày giao dịch</th>
                                                    <th>Ngày hiệu lực</th>
                                                    <th>Mô tả</th>
                                                    <th>Mã giao dịch</th>
                                                    <th>Số tiền ra</th>
                                                    <th>Số tiền vào</th>
                                                    <th>Số dư</th>
                                                    <th>Loại ra</th>
                                                    <th>Loại vào</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="transaction" items="${transactions}">
                                                    <tr>
                                                        <td>${transaction.transactiondate}</td>
                                                        <td>${transaction.effectivedate}</td>
                                                        <td>${transaction.description}</td>
                                                        <td>${transaction.transactioncode}</td>
                                                        <td class="text-danger">${transaction.debit}</td>
                                                        <td class="text-success">${transaction.credit}</td>
                                                        <td>${transaction.balance}</td>
                                                        <td>
                                                            <form method="post" action="/updateTransactionCategory">
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                                <input type="hidden" name="id"
                                                                    value="${transaction.id}" />
                                                                <input type="hidden" name="transactiondate"
                                                                    value="${transaction.transactiondate}" />
                                                                <input type="hidden" name="effectivedate"
                                                                    value="${transaction.effectivedate}" />
                                                                <input type="hidden" name="description"
                                                                    value="${transaction.description}" />
                                                                <input type="hidden" name="transactioncode"
                                                                    value="${transaction.transactioncode}" />
                                                                <input type="hidden" name="debit"
                                                                    value="${transaction.debit}" />
                                                                <input type="hidden" name="credit"
                                                                    value="${transaction.credit}" />
                                                                <input type="hidden" name="balance"
                                                                    value="${transaction.balance}" />
                                                                <select name="category.id"
                                                                    onchange="this.form.submit()">
                                                                    <option value="">-- Lựa chọn --</option>
                                                                    <c:forEach var="cat" items="${categories}">
                                                                        <option value="${cat.id}" <c:if
                                                                            test="${transaction.category != null && transaction.category.id.longValue() == cat.id}">
                                                                            selected
                                                                            </c:if>>
                                                                            ${cat.name}
                                                                        </option>
                                                                    </c:forEach>
                                                                </select>
                                                            </form>
                                                        </td>
                                                        <td>
                                                            <form method="post" action="/updateTransactionIncome">
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                                <input type="hidden" name="id"
                                                                    value="${transaction.id}" />
                                                                <input type="hidden" name="transactiondate"
                                                                    value="${transaction.transactiondate}" />
                                                                <input type="hidden" name="effectivedate"
                                                                    value="${transaction.effectivedate}" />
                                                                <input type="hidden" name="description"
                                                                    value="${transaction.description}" />
                                                                <input type="hidden" name="transactioncode"
                                                                    value="${transaction.transactioncode}" />
                                                                <input type="hidden" name="debit"
                                                                    value="${transaction.debit}" />
                                                                <input type="hidden" name="credit"
                                                                    value="${transaction.credit}" />
                                                                <input type="hidden" name="balance"
                                                                    value="${transaction.balance}" />
                                                                <select name="income.id" onchange="this.form.submit()">
                                                                    <option value="">-- Lựa chọn --</option>
                                                                    <c:forEach var="cat" items="${incomes}">
                                                                        <option value="${cat.id}" <c:if
                                                                            test="${transaction.income != null && transaction.income.id.longValue() == cat.id}">
                                                                            selected
                                                                            </c:if>>
                                                                            ${cat.name}
                                                                        </option>
                                                                    </c:forEach>
                                                                </select>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>

                    <!-- <jsp:include page="../layout/footer2.jsp" /> -->
                </div>

                <!-- Hidden data for JavaScript -->
                <div id="transactionData" style="display: none;">
                    <c:forEach var="transaction" items="${transactions}">
                        <div class="transaction-item" data-date="${transaction.transactiondate}"
                            data-effective-date="${transaction.effectivedate}"
                            data-debit="${transaction.debit != null ? transaction.debit : 0}"
                            data-credit="${transaction.credit != null ? transaction.credit : 0}"
                            data-balance="${transaction.balance != null ? transaction.balance : 0}">
                        </div>
                    </c:forEach>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/chart-area-demo.js"></script>
                <script src="js/chart-bar-demo.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/datatables-simple-demo.js"></script>

                <script>
                    // Cấu hình mặc định của Chart.js
                    Chart.defaults.global.defaultFontFamily = '-apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif';
                    Chart.defaults.global.defaultFontColor = '#292b2c';

                    // Function to format number as Vietnamese currency
                    function formatVND(amount) {
                        return new Intl.NumberFormat('vi-VN').format(amount) + 'K VNĐ';
                    }

                    // Function to parse Vietnamese date string to Date object
                    function parseVietnameseDate(dateString) {
                        // Handle format: "16/05/2025 16:26:00" or "16/05/2025"
                        try {
                            const parts = dateString.trim().split(' ');
                            const datePart = parts[0]; // "16/05/2025"
                            const timePart = parts[1] || "00:00:00"; // "16:26:00" or default

                            const [day, month, year] = datePart.split('/');
                            const [hours, minutes, seconds] = timePart.split(':');

                            // JavaScript Date constructor expects (year, month-1, day, hours, minutes, seconds)
                            return new Date(
                                parseInt(year),
                                parseInt(month) - 1, // Month is 0-indexed
                                parseInt(day),
                                parseInt(hours) || 0,
                                parseInt(minutes) || 0,
                                parseInt(seconds) || 0
                            );
                        } catch (error) {
                            console.error('Error parsing date:', dateString, error);
                            return new Date(); // Return current date as fallback
                        }
                    }


                    // Process transaction data
                    function processTransactionData() {
                        const transactionElements = document.querySelectorAll('.transaction-item');
                        const dailyData = {};
                        const weeklyData = {};
                        const balanceHistory = [];
                        let totalIncome = 0;
                        let totalExpense = 0;
                        let currentBalance = 0;

                        // Convert NodeList to Array and sort by date
                        const transactions = Array.from(transactionElements).map(element => ({
                            date: element.getAttribute('data-date'),
                            effectiveDate: element.getAttribute('data-effective-date'),
                            debit: parseFloat(element.getAttribute('data-debit')) || 0,
                            credit: parseFloat(element.getAttribute('data-credit')) || 0,
                            balance: parseFloat(element.getAttribute('data-balance')) || 0,
                            parsedDate: parseVietnameseDate(element.getAttribute('data-date'))
                        })).sort((a, b) => a.parsedDate - b.parsedDate);

                        // Process each transaction
                        transactions.forEach((transaction, index) => {
                            const dateKey = transaction.date.split(' ')[0]; // Get date part only
                            const debit = transaction.debit;
                            const credit = transaction.credit;
                            const balance = transaction.balance;
                            const parsedDate = transaction.parsedDate;

                            // Update totals
                            totalExpense += debit;
                            totalIncome += credit;
                            currentBalance = balance;

                            // Balance history for trend chart
                            balanceHistory.push({
                                date: parsedDate,
                                balance: balance,
                                dateStr: dateKey
                            });

                            // Group by date
                            if (!dailyData[dateKey]) {
                                dailyData[dateKey] = { income: 0, expense: 0, date: parsedDate };
                            }
                            dailyData[dateKey].income += credit;
                            dailyData[dateKey].expense += debit;

                            // Group by week
                        });

                        // Update summary cards
                        document.getElementById('totalIncome').textContent = formatVND(totalIncome);
                        document.getElementById('totalExpense').textContent = formatVND(totalExpense);
                        document.getElementById('netIncome').textContent = formatVND(totalIncome - totalExpense);
                        document.getElementById('currentBalance').textContent = formatVND(currentBalance);

                        return { dailyData, weeklyData, balanceHistory, totalIncome, totalExpense };
                    }

                    // Create charts with transaction data
                    function createCharts() {
                        const { dailyData, weeklyData, balanceHistory, totalIncome, totalExpense } = processTransactionData();

                        // Sort dates and get data for charts
                        const sortedDates = Object.keys(dailyData).sort((a, b) => {
                            return parseVietnameseDate(a) - parseVietnameseDate(b);
                        }).slice(-14); // Last 14 days

                        const labels = sortedDates.map(date => {
                            const d = parseVietnameseDate(date);
                            return d.toLocaleDateString('vi-VN', { month: 'short', day: 'numeric' });
                        });

                        const incomeData = sortedDates.map(date => dailyData[date].income);
                        const expenseData = sortedDates.map(date => dailyData[date].expense);

                        // 1. Area Chart (Income vs Expense over time)
                        const areaCtx = document.getElementById("myAreaChart");
                        new Chart(areaCtx, {
                            type: 'line',
                            data: {
                                labels: labels,
                                datasets: [
                                    {
                                        label: "Thu nhập (VNĐ)",
                                        lineTension: 0.3,
                                        backgroundColor: "rgba(40, 167, 69, 0.2)",
                                        borderColor: "rgb(40, 167, 69)",
                                        pointRadius: 5,
                                        pointBackgroundColor: "rgb(40, 167, 69)",
                                        pointBorderColor: "rgba(255,255,255,0.8)",
                                        pointHoverRadius: 7,
                                        pointHoverBackgroundColor: "rgb(40, 167, 69)",
                                        pointHitRadius: 50,
                                        pointBorderWidth: 2,
                                        data: incomeData,
                                        fill: true
                                    },
                                    {
                                        label: "Chi tiêu (VNĐ)",
                                        lineTension: 0.3,
                                        backgroundColor: "rgba(220, 53, 69, 0.2)",
                                        borderColor: "rgb(220, 53, 69)",
                                        pointRadius: 5,
                                        pointBackgroundColor: "rgb(220, 53, 69)",
                                        pointBorderColor: "rgba(255,255,255,0.8)",
                                        pointHoverRadius: 7,
                                        pointHoverBackgroundColor: "rgb(220, 53, 69)",
                                        pointHitRadius: 50,
                                        pointBorderWidth: 2,
                                        data: expenseData,
                                        fill: true
                                    }
                                ],
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        gridLines: { display: false },
                                        ticks: { maxTicksLimit: 7 }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            min: 0,
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN').format(value);
                                            }
                                        },
                                        gridLines: { color: "rgba(0, 0, 0, .125)" }
                                    }],
                                },
                                legend: { display: true },
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    titleMarginBottom: 10,
                                    titleFontColor: '#6e707e',
                                    titleFontSize: 14,
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    xPadding: 15,
                                    yPadding: 15,
                                    displayColors: false,
                                    intersect: false,
                                    mode: 'index',
                                    caretPadding: 10,
                                    callbacks: {
                                        label: function (tooltipItem, data) {
                                            const label = data.datasets[tooltipItem.datasetIndex].label || '';
                                            return label + ': ' + formatVND(tooltipItem.yLabel);
                                        }
                                    }
                                }
                            }
                        });

                        // 2. Bar Chart (Total comparison)
                        const barCtx = document.getElementById("myBarChart");
                        const recentIncome = incomeData.reduce((sum, val) => sum + val, 0);
                        const recentExpense = expenseData.reduce((sum, val) => sum + val, 0);

                        new Chart(barCtx, {
                            type: 'bar',
                            data: {
                                labels: ["Thu nhập", "Chi tiêu", "Lãi/Lỗ"],
                                datasets: [{
                                    label: "Số tiền (VNĐ)",
                                    backgroundColor: [
                                        "rgba(40, 167, 69, 0.8)",
                                        "rgba(220, 53, 69, 0.8)",
                                        recentIncome >= recentExpense ? "rgba(40, 167, 69, 0.8)" : "rgba(220, 53, 69, 0.8)"
                                    ],
                                    borderColor: [
                                        "rgb(40, 167, 69)",
                                        "rgb(220, 53, 69)",
                                        recentIncome >= recentExpense ? "rgb(40, 167, 69)" : "rgb(220, 53, 69)"
                                    ],
                                    data: [recentIncome, recentExpense, recentIncome - recentExpense],
                                }],
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        gridLines: { display: false }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN').format(value);
                                            }
                                        },
                                        gridLines: { color: "rgba(0, 0, 0, .125)" }
                                    }],
                                },
                                legend: { display: false },
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    callbacks: {
                                        label: function (tooltipItem) {
                                            return formatVND(tooltipItem.yLabel);
                                        }
                                    }
                                }
                            }
                        });

                        // 3. Pie Chart (Income vs Expense ratio)
                        const pieCtx = document.getElementById("myPieChart");
                        new Chart(pieCtx, {
                            type: 'doughnut',
                            data: {
                                labels: ['Thu nhập', 'Chi tiêu'],
                                datasets: [{
                                    data: [totalIncome, totalExpense],
                                    backgroundColor: ['#28a745', '#dc3545'],
                                    hoverBackgroundColor: ['#218838', '#c82333'],
                                    hoverBorderColor: "rgba(234, 236, 244, 1)",
                                }],
                            },
                            options: {
                                maintainAspectRatio: false,
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    callbacks: {
                                        label: function (tooltipItem, data) {
                                            const dataset = data.datasets[tooltipItem.datasetIndex];
                                            const total = dataset.data.reduce((sum, val) => sum + val, 0);
                                            const currentValue = dataset.data[tooltipItem.index];
                                            const percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                            return data.labels[tooltipItem.index] + ': ' + formatVND(currentValue) + ' (' + percentage + '%)';
                                        }
                                    }
                                },
                                legend: {
                                    display: true,
                                    position: 'bottom'
                                },
                                cutoutPercentage: 60,
                            },
                        });

                        // 4. Balance Trend Chart
                        const balanceCtx = document.getElementById("balanceTrendChart");
                        const sortedBalanceHistory = balanceHistory.slice(-14); // Last 14 records
                        const balanceLabels = sortedBalanceHistory.map(item => {
                            return item.date.toLocaleDateString('vi-VN', { month: 'short', day: 'numeric' });
                        });
                        const balanceData = sortedBalanceHistory.map(item => item.balance);

                        new Chart(balanceCtx, {
                            type: 'line',
                            data: {
                                labels: balanceLabels,
                                datasets: [{
                                    label: "Số dư (VNĐ)",
                                    lineTension: 0.3,
                                    backgroundColor: "rgba(78, 115, 223, 0.1)",
                                    borderColor: "rgba(78, 115, 223, 1)",
                                    pointRadius: 3,
                                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
                                    pointBorderColor: "rgba(78, 115, 223, 1)",
                                    pointHoverRadius: 5,
                                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                                    pointHitRadius: 50,
                                    pointBorderWidth: 2,
                                    data: balanceData,
                                }],
                            },
                            options: {
                                maintainAspectRatio: false,
                                scales: {
                                    xAxes: [{
                                        gridLines: {
                                            display: false
                                        },
                                        ticks: {
                                            maxTicksLimit: 7
                                        }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN').format(value);
                                            }
                                        },
                                        gridLines: {
                                            color: "rgba(0, 0, 0, .125)"
                                        }
                                    }],
                                },
                                legend: {
                                    display: true
                                },
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    titleMarginBottom: 10,
                                    titleFontColor: '#6e707e',
                                    titleFontSize: 14,
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    xPadding: 15,
                                    yPadding: 15,
                                    displayColors: false,
                                    intersect: false,
                                    mode: 'index',
                                    caretPadding: 10,
                                    callbacks: {
                                        label: function (tooltipItem) {
                                            return 'Số dư: ' + formatVND(tooltipItem.yLabel);
                                        }
                                    }
                                }
                            }
                        });

                        // 5. Weekly Income Chart
                        const weeklyIncomeCtx = document.getElementById("weeklyIncomeChart");
                        const weeklyLabels = Object.keys(weeklyData).sort().slice(-8);
                        const weeklyIncomeData = weeklyLabels.map(week => weeklyData[week].income);

                        new Chart(weeklyIncomeCtx, {
                            type: 'bar',
                            data: {
                                labels: weeklyLabels.map(week => week.replace('-W', ' Tuần ')),
                                datasets: [{
                                    label: "Thu nhập theo tuần (VNĐ)",
                                    backgroundColor: "rgba(40, 167, 69, 0.8)",
                                    borderColor: "rgb(40, 167, 69)",
                                    data: weeklyIncomeData,
                                }],
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        gridLines: { display: false }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            min: 0,
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN').format(value);
                                            }
                                        },
                                        gridLines: { color: "rgba(0, 0, 0, .125)" }
                                    }],
                                },
                                legend: { display: false },
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    callbacks: {
                                        label: function (tooltipItem) {
                                            return 'Thu nhập: ' + formatVND(tooltipItem.yLabel);
                                        }
                                    }
                                }
                            }
                        });

                        // 6. Weekly Expense Chart
                        const weeklyExpenseCtx = document.getElementById("weeklyExpenseChart");
                        const weeklyExpenseData = weeklyLabels.map(week => weeklyData[week].expense);

                        new Chart(weeklyExpenseCtx, {
                            type: 'bar',
                            data: {
                                labels: weeklyLabels.map(week => week.replace('-W', ' Tuần ')),
                                datasets: [{
                                    label: "Chi tiêu theo tuần (VNĐ)",
                                    backgroundColor: "rgba(220, 53, 69, 0.8)",
                                    borderColor: "rgb(220, 53, 69)",
                                    data: weeklyExpenseData,
                                }],
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        gridLines: { display: false }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            min: 0,
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN').format(value);
                                            }
                                        },
                                        gridLines: { color: "rgba(0, 0, 0, .125)" }
                                    }],
                                },
                                legend: { display: false },
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    callbacks: {
                                        label: function (tooltipItem) {
                                            return 'Chi tiêu: ' + formatVND(tooltipItem.yLabel);
                                        }
                                    }
                                }
                            }
                        });

                        // 7. Cash Flow Chart (Net Income/Loss over time)
                        const cashFlowCtx = document.getElementById("cashFlowChart");
                        const cashFlowData = sortedDates.map(date => {
                            const income = dailyData[date].income;
                            const expense = dailyData[date].expense;
                            return income - expense;
                        });

                        new Chart(cashFlowCtx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: "Dòng tiền ròng (VNĐ)",
                                    backgroundColor: cashFlowData.map(value =>
                                        value >= 0 ? "rgba(40, 167, 69, 0.8)" : "rgba(220, 53, 69, 0.8)"
                                    ),
                                    borderColor: cashFlowData.map(value =>
                                        value >= 0 ? "rgb(40, 167, 69)" : "rgb(220, 53, 69)"
                                    ),
                                    data: cashFlowData,
                                }],
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        gridLines: { display: false }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            callback: function (value) {
                                                return new Intl.NumberFormat('vi-VN').format(value);
                                            }
                                        },
                                        gridLines: {
                                            color: "rgba(0, 0, 0, .125)",
                                            zeroLineColor: "rgba(0, 0, 0, .25)"
                                        }
                                    }],
                                },
                                legend: { display: false },
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    callbacks: {
                                        label: function (tooltipItem) {
                                            const value = tooltipItem.yLabel;
                                            const status = value >= 0 ? 'Lãi' : 'Lỗ';
                                            return status + ': ' + formatVND(Math.abs(value));
                                        }
                                    }
                                }
                            }
                        });
                    }

                    // Initialize charts when page loads
                    document.addEventListener('DOMContentLoaded', function () {
                        createCharts();
                    });
                </script>

            </body>

            </html>