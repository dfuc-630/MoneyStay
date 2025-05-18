<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Quản Lý Tài Chính</title>
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
                            <!-- <div class="row">
                                <div class="col-xl-3 col-md-6">
                                    <div class="card bg-primary text-white mb-4">
                                        <div class="card-body">Primary Card</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="#">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="card bg-warning text-white mb-4">
                                        <div class="card-body">Warning Card</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="#">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="card bg-success text-white mb-4">
                                        <div class="card-body">Success Card</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="#">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="card bg-danger text-white mb-4">
                                        <div class="card-body">Danger Card</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="#">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                            <div class="row">
                                <div class="col-xl-6">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <i class="fas fa-chart-area me-1"></i>
                                            Chi tiêu hàng ngày
                                        </div>
                                        <div class="card-body"><canvas id="myAreaChart" width="100%"
                                                height="40"></canvas></div>
                                    </div>
                                </div>
                                <div class="col-xl-6">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <i class="fas fa-chart-bar me-1"></i>
                                            Thu nhập hàng tháng
                                        </div>
                                        <div class="card-body"><canvas id="myBarChart" width="100%"
                                                height="40"></canvas></div>
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
                                                <th>Số tiền nợ</th>
                                                <th>Số tiền có</th>
                                                <th>Số dư</th>
                                                <th>Thể loại</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>Ngày giao dịch</th>
                                                <th>Ngày hiệu lực</th>
                                                <th>Mô tả</th>
                                                <th>Mã giao dịch</th>
                                                <th>Số tiền nợ</th>
                                                <th>Số tiền có</th>
                                                <th>Số dư</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="transaction" items="${transactions}">
                                                <tr>
                                                    <td>${transaction.transactiondate}</td>
                                                    <td>${transaction.effectivedate}</td>
                                                    <td>${transaction.description}</td>
                                                    <td>${transaction.transactioncode}</td>
                                                    <td>${transaction.debit}</td>
                                                    <td>${transaction.credit}</td>
                                                    <td>${transaction.balance}</td>
                                                    <td>
                                                        <form method="post" action="/updateTransactionCategory">
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
                                                            <select name="category.id" onchange="this.form.submit()">
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

                // Lấy phần tử canvas để vẽ biểu đồ
                var ctx = document.getElementById("myAreaChart");

                // Dữ liệu ban đầu: 6 tháng gần nhất
                var nhanX = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
                var duLieu = [5000000, 4500000, 6200000, 5500000, 7000000, 4800000, 5000000, 5000000, 5000000, 5000000, 5000000, 5000000]; // Chi tiêu (VNĐ)

                // Khởi tạo biểu đồ đường
                var bieuDoDuong = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: nhanX,
                        datasets: [{
                            label: "Chi tiêu (VNĐ)",
                            lineTension: 0.3,
                            backgroundColor: "rgba(99, 130, 255, 0.2)", // Màu nền nhẹ
                            borderColor: "rgb(120, 99, 255)", // Màu viền đỏ
                            pointRadius: 5,
                            pointBackgroundColor: "rgb(120, 99, 255)",
                            pointBorderColor: "rgba(255,255,255,0.8)",
                            pointHoverRadius: 7,
                            pointHoverBackgroundColor: "rgb(120, 99, 255)",
                            pointHitRadius: 50,
                            pointBorderWidth: 2,
                            data: duLieu,
                        }],
                    },
                    options: {
                        scales: {
                            xAxes: [{
                                gridLines: { display: false },
                                ticks: { maxTicksLimit: 12 }
                            }],
                            yAxes: [{
                                ticks: {
                                    min: 0,
                                    max: 10000000, // Giới hạn 10 triệu VNĐ
                                    stepSize: 2000000 // Bước nhảy 2 triệu VNĐ
                                },
                                gridLines: { color: "rgba(0, 0, 0, .125)" }
                            }],
                        },
                        legend: { display: true }
                    }
                });


            </script>

        </body>

        </html>