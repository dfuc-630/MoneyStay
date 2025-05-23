<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Chi tiết mục tiêu ngân sách</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../../admin/layout/header2.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../../admin/layout/sidebar2.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Chi tiết mục tiêu ngân sách</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/client">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Chi tiết mục tiêu</li>
                                </ol>

                                <div class="card mb-4">
                                    <div class="card-header">Thông tin mục tiêu</div>
                                    <div class="card-body">
                                        <p><strong>Tên mục tiêu:</strong> ${target.name}</p>
                                        <p><strong>Số tiền mục tiêu:</strong>
                                            <fmt:formatNumber value="${target.amount}" type="number" /> VND
                                        </p>
                                        <p><strong>Loại chi tiêu:</strong> ${target.category.name}</p>
                                        <p><strong>Loại thu nhập:</strong> ${target.income.name}</p>

                                        <div class="alert alert-info mt-4 p-4 fs-5 shadow rounded">
                                            <c:choose>
                                                <c:when test="${not empty target.category}">
                                                    <strong>Tổng chi tiêu tháng này:</strong>
                                                    <fmt:formatNumber value="${totalDebitThisMonth}" type="number" />
                                                    VND /
                                                    Ngân sách:
                                                    <fmt:formatNumber value="${target.amount}" type="number" /> VND
                                                    <c:if test="${totalDebitThisMonth > target.amount}">
                                                        <div class="alert alert-warning mt-3">
                                                            <strong>Cảnh báo:</strong> Tổng chi tiêu đã vượt quá ngân
                                                            sách mục tiêu!
                                                        </div>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <strong>Tổng thu nhập tháng này:</strong>
                                                    <fmt:formatNumber value="${totalCreditThisMonth}" type="number" />
                                                    VND /
                                                    Ngân sách:
                                                    <fmt:formatNumber value="${target.amount}" type="number" /> VND
                                                    <c:if test="${totalCreditThisMonth > target.amount}">
                                                        <div class="alert alert-warning mt-3">
                                                            <strong>Cảnh báo:</strong> Tổng thu nhập đã vượt quá ngân
                                                            sách mục tiêu!
                                                        </div>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>


                                    </div>
                                </div>

                                <div class="card mb-4">
                                    <div class="card-header">Giao dịch tương ứng với mục tiêu</div>
                                    <div class="card-body">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Ngày giao dịch</th>
                                                    <th>Mô tả</th>
                                                    <th>Số tiền</th>
                                                    <th>Số dư</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${not empty target.category}">
                                                        <c:forEach var="t" items="${outComeTransactions}">
                                                            <tr>
                                                                <td>${t.transactiondate}</td>
                                                                <td>${t.description}</td>
                                                                <td>${t.debit}</td>
                                                                <td>${t.balance}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="t" items="${inComeTransactions}">
                                                            <tr>
                                                                <td>${t.transactiondate}</td>
                                                                <td>${t.description}</td>
                                                                <td>${t.credit}</td>
                                                                <td>${t.balance}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                                <a href="/client/budget" class="btn btn-success">Quay lại danh sách</a>
                            </div>
                        </main>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>