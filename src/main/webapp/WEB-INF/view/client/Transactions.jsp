<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Transactions</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body>
                <div class="container mt-5">
                    <h1 class="text-center">Transaction History</h1>

                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Hiển thị bảng dữ liệu -->
                    <c:if test="${not empty transactions}">
                        <div class="table-responsive mt-4">
                            <table class="table table-striped table-bordered">
                                <thead class="table-dark">
                                    <tr>
                                        <th>#</th>
                                        <th>Transaction Date</th>
                                        <th>Effective Date</th>
                                        <th>Description</th>
                                        <th>Transaction Code</th>
                                        <th>Debit</th>
                                        <th>Credit</th>
                                        <th>Balance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="transaction" items="${transactions}" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${transaction.transaction_date}</td>
                                            <td>${transaction.effective_date}</td>
                                            <td>${transaction.description}</td>
                                            <td>${transaction.transaction_code}</td>
                                            <td>${transaction.debit}</td>
                                            <td>${transaction.credit}</td>
                                            <td>${transaction.balance}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>