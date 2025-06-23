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
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <style>
                    .filter-btn {
                        padding: 0.375rem 1rem;
                        font-size: 0.875rem;
                        border-radius: 0.25rem;
                        margin-right: 0.25rem;
                    }

                    .filter-btn:last-child {
                        margin-right: 0;
                    }

                    .filter-section {
                        background-color: #f8f9fa;
                        border-radius: 0.375rem;
                        padding: 1rem;
                        margin-bottom: 1.5rem;
                    }

                    .filter-btn.active {
                        background-color: #007bff;
                        color: white;
                    }

                    .chart-container {
                        position: relative;
                        min-height: 200px;
                    }

                    .no-data-message {
                        display: none;
                        text-align: center;
                        color: #6c757d;
                        padding: 20px;
                    }
                </style>
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
                                <div class="filter-section">
                                    <button class="filter-btn active" data-days="30">30 Ngày</button>
                                    <button class="filter-btn" data-days="90">90 Ngày</button>
                                    <button class="filter-btn" data-days="365">1 Năm</button>
                                    <button class="filter-btn" data-days="all">Tất Cả</button>
                                </div>
                                <div class="row">
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-primary text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="totalIncome">0 VNĐ</h4>
                                                <small>Tổng Thu Nhập</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-warning text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="totalExpense">0 VNĐ</h4>
                                                <small>Tổng Chi Tiêu</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-success text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="netIncome">0 VNĐ</h4>
                                                <small>Thu Nhập Ròng</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-md-6">
                                        <div class="card bg-danger text-white mb-4">
                                            <div class="card-body">
                                                <h4 id="currentBalance">0 VNĐ</h4>
                                                <small>Số Dư Hiện Tại</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-7">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-area me-1"></i>
                                                Thu nhập và Chi tiêu theo thời gian
                                            </div>
                                            <div class="card-body chart-container">
                                                <canvas id="myAreaChart" width="100%" height="50"></canvas>
                                                <div id="areaChartNoData" class="no-data-message">Không có dữ liệu để
                                                    hiển thị</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-5">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-bar me-1"></i>
                                                So sánh Thu nhập và Chi tiêu
                                            </div>
                                            <div class="card-body chart-container">
                                                <canvas id="myBarChart" width="100%" height="73"></canvas>
                                                <div id="barChartNoData" class="no-data-message">Không có dữ liệu để
                                                    hiển thị</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-5">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-pie me-1"></i>
                                                Tỷ lệ Thu nhập vs Chi tiêu
                                            </div>
                                            <div class="card-body chart-container">
                                                <canvas id="myPieChart" width="100%" height="340"></canvas>
                                                <div id="pieChartNoData" class="no-data-message">Không có dữ liệu để
                                                    hiển thị</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-7">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-line me-1"></i>
                                                Xu hướng số dư tài khoản
                                            </div>
                                            <div class="card-body chart-container">
                                                <canvas id="balanceTrendChart" width="100%" height="50"></canvas>
                                                <div id="balanceChartNoData" class="no-data-message">Không có dữ liệu để
                                                    hiển thị</div>
                                            </div>
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
                                            <div class="card-body chart-container">
                                                <canvas id="cashFlowChart" width="100%" height="20"></canvas>
                                                <div id="cashFlowChartNoData" class="no-data-message">Không có dữ liệu
                                                    để hiển thị</div>
                                            </div>
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
                                                            <c:if test="${transaction.debit != '--'}">
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
                                                            </c:if>>${cat.name}</option>
                                                </c:forEach>
                                                </select>
                                                </form>
                                                </c:if>
                                                <c:if test="${transaction.debit == '--'}">
                                                    --
                                                </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${transaction.credit != '--'}">
                                                        <form method="post" action="/updateTransactionIncome">
                                                            <input type="hidden" name="${_csrf.parameterName}"
                                                                value="${_csrf.token}" />
                                                            <input type="hidden" name="id" value="${transaction.id}" />
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
                                                    </c:if>>${cat.name}</option>
                                                    </c:forEach>
                                                    </select>
                                                    </form>
                                                    </c:if>
                                                    <c:if test="${transaction.credit == '--'}">
                                                        --
                                                    </c:if>
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
                </div>
                <div id="transactionData" style="display: none;">
                    <c:forEach var="transaction" items="${transactions}">
                        <div class="transaction-item" data-date="${transaction.transactiondate}"
                            data-effective-date="${transaction.effectivedate}"
                            data-debit="${transaction.debit != null ? transaction.debit : 0}"
                            data-credit="${transaction.credit != null ? transaction.credit : 0}"
                            data-balance="${transaction.balance != null ? transaction.balance : 0}"></div>
                    </c:forEach>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/datatables-simple-demo.js"></script>
                <script>
                    Chart.defaults.global.defaultFontFamily = '-apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif';
                    Chart.defaults.global.defaultFontColor = '#292b2c';
                    let charts = {};

                    function formatVND(amount) {
                        return new Intl.NumberFormat('vi-VN').format(amount) + 'K VNĐ';
                    }

                    function parseVietnameseDate(dateString) {
                        try {
                            const parts = dateString.trim().split(' ');
                            const datePart = parts[0];
                            const timePart = parts[1] || "00:00:00";
                            const [day, month, year] = datePart.split('/');
                            const [hours, minutes, seconds] = timePart.split(':');
                            return new Date(
                                parseInt(year),
                                parseInt(month) - 1,
                                parseInt(day),
                                parseInt(hours) || 0,
                                parseInt(minutes) || 0,
                                parseInt(seconds) || 0
                            );
                        } catch (error) {
                            console.error('Error parsing date:', dateString, error);
                            return null;
                        }
                    }

                    function processTransactionData(days = 30) {
                        const transactionElements = document.querySelectorAll('.transaction-item');
                        if (!transactionElements.length) {
                            console.warn('No transaction data found');
                            return { dailyData: {}, balanceHistory: [], totalIncome: 0, totalExpense: 0, currentBalance: 0 };
                        }

                        const dailyData = {};
                        const balanceHistory = [];
                        let totalIncome = 0;
                        let totalExpense = 0;
                        let currentBalance = 0;
                        const cutoffDate = new Date();
                        cutoffDate.setDate(cutoffDate.getDate() - (days === 'all' ? 9999 : days));

                        const transactions = Array.from(transactionElements)
                            .map(element => ({
                                date: element.getAttribute('data-date'),
                                effectiveDate: element.getAttribute('data-effective-date'),
                                debit: parseFloat(element.getAttribute('data-debit')) || 0,
                                credit: parseFloat(element.getAttribute('data-credit')) || 0,
                                balance: parseFloat(element.getAttribute('data-balance')) || 0,
                                parsedDate: parseVietnameseDate(element.getAttribute('data-date'))
                            }))
                            .filter(t => t.parsedDate && (days === 'all' || t.parsedDate >= cutoffDate))
                            .sort((a, b) => a.parsedDate - b.parsedDate);

                        transactions.forEach(transaction => {
                            const dateKey = transaction.date.split(' ')[0];
                            const debit = transaction.debit;
                            const credit = transaction.credit;
                            const balance = transaction.balance;
                            const parsedDate = transaction.parsedDate;

                            totalExpense += debit;
                            totalIncome += credit;
                            currentBalance = balance;

                            balanceHistory.push({
                                date: parsedDate,
                                balance: balance,
                                dateStr: dateKey
                            });

                            if (!dailyData[dateKey]) {
                                dailyData[dateKey] = { income: 0, expense: 0, date: parsedDate };
                            }
                            dailyData[dateKey].income += credit;
                            dailyData[dateKey].expense += debit;
                        });

                        document.getElementById('totalIncome').textContent = formatVND(totalIncome);
                        document.getElementById('totalExpense').textContent = formatVND(totalExpense);
                        document.getElementById('netIncome').textContent = formatVND(totalIncome - totalExpense);
                        document.getElementById('currentBalance').textContent = formatVND(currentBalance);

                        return { dailyData, balanceHistory, totalIncome, totalExpense, currentBalance };
                    }

                    function getMaxTicksLimit(days) {
                        if (days === 'all') return 12;
                        if (days >= 365) return 12;
                        if (days >= 90) return 10;
                        return 7;
                    }

                    function toggleChartVisibility(chartId, noDataId, hasData) {
                        const chart = document.getElementById(chartId);
                        const noDataMessage = document.getElementById(noDataId);
                        if (chart && noDataMessage) {
                            chart.style.display = hasData ? 'block' : 'none';
                            noDataMessage.style.display = hasData ? 'none' : 'block';
                        }
                    }

                    function createCharts() {
                        const { dailyData, balanceHistory, totalIncome, totalExpense } = processTransactionData(30);
                        const chartInstances = {};

                        const hasDailyData = Object.keys(dailyData).length > 0;
                        const hasBalanceData = balanceHistory.length > 0;
                        const hasSummaryData = totalIncome > 0 || totalExpense > 0;

                        toggleChartVisibility('myAreaChart', 'areaChartNoData', hasDailyData);
                        toggleChartVisibility('myBarChart', 'barChartNoData', hasSummaryData);
                        toggleChartVisibility('myPieChart', 'pieChartNoData', hasSummaryData);
                        toggleChartVisibility('balanceTrendChart', 'balanceChartNoData', hasBalanceData);
                        toggleChartVisibility('cashFlowChart', 'cashFlowChartNoData', hasDailyData);

                        if (!hasDailyData && !hasBalanceData && !hasSummaryData) {
                            console.warn('No data available for any charts');
                            return chartInstances;
                        }

                        const sortedDates = Object.keys(dailyData).sort((a, b) => {
                            return parseVietnameseDate(a) - parseVietnameseDate(b);
                        });

                        const labels = sortedDates.map(date => {
                            const d = parseVietnameseDate(date);
                            return d.toLocaleDateString('vi-VN', { month: 'short', day: 'numeric' });
                        });

                        const incomeData = sortedDates.map(date => dailyData[date].income);
                        const expenseData = sortedDates.map(date => dailyData[date].expense);

                        const areaCtx = document.getElementById("myAreaChart");
                        if (areaCtx && hasDailyData) {
                            chartInstances.areaChart = new Chart(areaCtx.getContext('2d'), {
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
                                    ]
                                },
                                options: {
                                    scales: {
                                        xAxes: [{
                                            gridLines: { display: false },
                                            ticks: { maxTicksLimit: getMaxTicksLimit(30) }
                                        }],
                                        yAxes: [{
                                            ticks: {
                                                min: 0,
                                                callback: function (value) {
                                                    return new Intl.NumberFormat('vi-VN').format(value);
                                                }
                                            },
                                            gridLines: { color: "rgba(0, 0, 0, .125)" }
                                        }]
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
                        } else if (!areaCtx) {
                            console.error('Area Chart canvas not found');
                        }

                        const barCtx = document.getElementById("myBarChart");
                        if (barCtx && hasSummaryData) {
                            const recentIncome = incomeData.reduce((sum, val) => sum + val, 0);
                            const recentExpense = expenseData.reduce((sum, val) => sum + val, 0);
                            chartInstances.barChart = new Chart(barCtx.getContext('2d'), {
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
                                        data: [recentIncome, recentExpense, recentIncome - recentExpense]
                                    }]
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
                                        }]
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
                        } else if (!barCtx) {
                            console.error('Bar Chart canvas not found');
                        }

                        const pieCtx = document.getElementById("myPieChart");
                        if (pieCtx && hasSummaryData) {
                            chartInstances.pieChart = new Chart(pieCtx.getContext('2d'), {
                                type: 'doughnut',
                                data: {
                                    labels: ['Thu nhập', 'Chi tiêu'],
                                    datasets: [{
                                        data: [totalIncome, totalExpense],
                                        backgroundColor: ['#28a745', '#dc3545'],
                                        hoverBackgroundColor: ['#218838', '#c82333'],
                                        hoverBorderColor: "rgba(234, 236, 244, 1)"
                                    }]
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
                                    cutoutPercentage: 60
                                }
                            });
                        } else if (!pieCtx) {
                            console.error('Pie Chart canvas not found');
                        }

                        const balanceCtx = document.getElementById("balanceTrendChart");
                        if (balanceCtx && hasBalanceData) {
                            const balanceLabels = balanceHistory.map(item => {
                                return item.date.toLocaleDateString('vi-VN', { month: 'short', day: 'numeric' });
                            });
                            const balanceData = balanceHistory.map(item => item.balance);
                            chartInstances.balanceChart = new Chart(balanceCtx.getContext('2d'), {
                                type: 'line',
                                data: {
                                    labels: balanceLabels,
                                    datasets: [{
                                        label: "Số dư (VNĐ)",
                                        lineTension: 0.3,
                                        backgroundColor: "rgba(78, 115, 223, 0.1)",
                                        borderColor: "rgba(78, 115, 223, 1)",
                                        pointRadius: 5,
                                        pointBackgroundColor: "rgba(78, 115, 223, 1)",
                                        pointBorderColor: "rgba(255,255,255,0.8)",
                                        pointHoverRadius: 7,
                                        pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                                        pointHitRadius: 50,
                                        pointBorderWidth: 2,
                                        data: balanceData
                                    }]
                                },
                                options: {
                                    scales: {
                                        xAxes: [{
                                            gridLines: { display: false },
                                            ticks: { maxTicksLimit: getMaxTicksLimit(30) }
                                        }],
                                        yAxes: [{
                                            ticks: {
                                                callback: function (value) {
                                                    return new Intl.NumberFormat('vi-VN').format(value);
                                                }
                                            },
                                            gridLines: { color: "rgba(0, 0, 0, .125)" }
                                        }]
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
                                            label: function (tooltipItem) {
                                                return 'Số dư: ' + formatVND(tooltipItem.yLabel);
                                            }
                                        }
                                    }
                                }
                            });
                        } else if (!balanceCtx) {
                            console.error('Balance Trend Chart canvas not found');
                        }

                        const cashFlowCtx = document.getElementById("cashFlowChart");
                        if (cashFlowCtx && hasDailyData) {
                            const cashFlowData = sortedDates.map(date => {
                                const income = dailyData[date].income;
                                const expense = dailyData[date].expense;
                                return income - expense;
                            });
                            chartInstances.cashFlowChart = new Chart(cashFlowCtx.getContext('2d'), {
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
                                        data: cashFlowData
                                    }]
                                },
                                options: {
                                    scales: {
                                        xAxes: [{
                                            gridLines: { display: false },
                                            ticks: { maxTicksLimit: getMaxTicksLimit(30) }
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
                                        }]
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
                        } else if (!cashFlowCtx) {
                            console.error('Cash Flow Chart canvas not found');
                        }

                        return chartInstances;
                    }

                    function updateCharts(days) {
                        const { dailyData, balanceHistory, totalIncome, totalExpense } = processTransactionData(days === 'all' ? 'all' : parseInt(days));
                        const hasDailyData = Object.keys(dailyData).length > 0;
                        const hasBalanceData = balanceHistory.length > 0;
                        const hasSummaryData = totalIncome > 0 || totalExpense > 0;

                        toggleChartVisibility('myAreaChart', 'areaChartNoData', hasDailyData);
                        toggleChartVisibility('myBarChart', 'barChartNoData', hasSummaryData);
                        toggleChartVisibility('myPieChart', 'pieChartNoData', hasSummaryData);
                        toggleChartVisibility('balanceTrendChart', 'balanceChartNoData', hasBalanceData);
                        toggleChartVisibility('cashFlowChart', 'cashFlowChartNoData', hasDailyData);

                        if (!hasDailyData && !hasBalanceData && !hasSummaryData) {
                            console.warn('No data available for selected period');
                            return;
                        }

                        const sortedDates = Object.keys(dailyData).sort((a, b) => {
                            return parseVietnameseDate(a) - parseVietnameseDate(b);
                        });

                        const labels = sortedDates.map(date => {
                            const d = parseVietnameseDate(date);
                            return d.toLocaleDateString('vi-VN', { month: 'short', day: 'numeric' });
                        });

                        const incomeData = sortedDates.map(date => dailyData[date].income);
                        const expenseData = sortedDates.map(date => dailyData[date].expense);
                        const maxTicks = getMaxTicksLimit(days === 'all' ? 'all' : parseInt(days));

                        if (charts.areaChart && hasDailyData) {
                            charts.areaChart.data.labels = labels;
                            charts.areaChart.data.datasets[0].data = incomeData;
                            charts.areaChart.data.datasets[1].data = expenseData;
                            charts.areaChart.options.scales.xAxes[0].ticks.maxTicksLimit = maxTicks;
                            charts.areaChart.update();
                        }

                        if (charts.barChart && hasSummaryData) {
                            const recentIncome = incomeData.reduce((sum, val) => sum + val, 0);
                            const recentExpense = expenseData.reduce((sum, val) => sum + val, 0);
                            charts.barChart.data.datasets[0].data = [recentIncome, recentExpense, recentIncome - recentExpense];
                            charts.barChart.data.datasets[0].backgroundColor = [
                                "rgba(40, 167, 69, 0.8)",
                                "rgba(220, 53, 69, 0.8)",
                                recentIncome >= recentExpense ? "rgba(40, 167, 69, 0.8)" : "rgba(220, 53, 69, 0.8)"
                            ];
                            charts.barChart.data.datasets[0].borderColor = [
                                "rgb(40, 167, 69)",
                                "rgb(220, 53, 69)",
                                recentIncome >= recentExpense ? "rgb(40, 167, 69)" : "rgb(220, 53, 69)"
                            ];
                            charts.barChart.update();
                        }

                        if (charts.pieChart && hasSummaryData) {
                            charts.pieChart.data.datasets[0].data = [totalIncome, totalExpense];
                            charts.pieChart.update();
                        }

                        if (charts.balanceChart && hasBalanceData) {
                            const balanceLabels = balanceHistory.map(item => {
                                return item.date.toLocaleDateString('vi-VN', { month: 'short', day: 'numeric' });
                            });
                            const balanceData = balanceHistory.map(item => item.balance);
                            charts.balanceChart.data.labels = balanceLabels;
                            charts.balanceChart.data.datasets[0].data = balanceData;
                            charts.balanceChart.options.scales.xAxes[0].ticks.maxTicksLimit = maxTicks;
                            charts.balanceChart.update();
                        }

                        if (charts.cashFlowChart && hasDailyData) {
                            const cashFlowData = sortedDates.map(date => {
                                const income = dailyData[date].income;
                                const expense = dailyData[date].expense;
                                return income - expense;
                            });
                            charts.cashFlowChart.data.labels = labels;
                            charts.cashFlowChart.data.datasets[0].data = cashFlowData;
                            charts.cashFlowChart.data.datasets[0].backgroundColor = cashFlowData.map(value =>
                                value >= 0 ? "rgba(40, 167, 69, 0.8)" : "rgba(220, 53, 69, 0.8)"
                            );
                            charts.cashFlowChart.data.datasets[0].borderColor = cashFlowData.map(value =>
                                value >= 0 ? "rgb(40, 167, 69)" : "rgb(220, 53, 69)"
                            );
                            charts.cashFlowChart.options.scales.xAxes[0].ticks.maxTicksLimit = maxTicks;
                            charts.cashFlowChart.update();
                        }
                    }

                    function handleFilterClick(event) {
                        const days = event.target.getAttribute('data-days');
                        document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
                        event.target.classList.add('active');
                        updateCharts(days);
                    }

                    document.addEventListener('DOMContentLoaded', function () {
                        try {
                            charts = createCharts();
                            document.querySelectorAll('.filter-btn').forEach(button => {
                                button.addEventListener('click', handleFilterClick);
                            });
                        } catch (error) {
                            console.error('Error initializing charts:', error);
                        }
                    });
                </script>
            </body>

            </html>