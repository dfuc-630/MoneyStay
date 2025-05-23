<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Manage Budget</title>
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
                                <h1 class="mt-4">Các mục tiêu chi tiêu</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/client">Dashboard</a> / Budget</li>
                                </ol>

                                <!-- Form tạo mục tiêu ngân sách -->
                                <div class="card mb-4">
                                    <div class="card-header">Tạo mục tiêu ngân sách</div>
                                    <div class="card-body">
                                        <form:form action="/client/budget/save" modelAttribute="budgetTarget"
                                            method="post">
                                            <div class="mb-3">
                                                <label for="name">Tên mục tiêu:</label>
                                                <form:input path="name" cssClass="form-control" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="amount">Số tiền mục tiêu:</label>
                                                <form:input path="amount" cssClass="form-control" type="number" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="category">Loại chi tiêu:</label>
                                                <form:select path="category" cssClass="form-control">
                                                    <form:option value="" label="-- Chọn loại chi tiêu --" />
                                                    <form:options items="${categories}" itemValue="id"
                                                        itemLabel="name" />
                                                </form:select>
                                            </div>

                                            <div class="mb-3">
                                                <label for="income">Loại thu nhập:</label>
                                                <form:select path="income" cssClass="form-control">
                                                    <form:option value="" label="-- Chọn loại thu nhập --" />
                                                    <form:options items="${incomes}" itemValue="id" itemLabel="name" />
                                                </form:select>
                                            </div>

                                            <button type="submit" class="btn btn-success">Lưu mục tiêu</button>
                                        </form:form>
                                    </div>
                                </div>

                                <!-- Danh sách mục tiêu -->
                                <div class="card mb-4">
                                    <div class="card-header">Danh sách mục tiêu đã tạo</div>
                                    <div class="card-body">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Tên</th>
                                                    <th>Số tiền mục tiêu</th>
                                                    <th>Loại chi tiêu</th>
                                                    <th>Loại thu nhập</th>
                                                    <th>Trạng thái</th>
                                                    <th>Hành động</th> <!-- Thêm cột hành động -->
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="target" items="${budgetTargets}">
                                                    <tr>
                                                        <td>${target.name}</td>
                                                        <td class="fw-bold">${target.amount}</td>
                                                        <td class="text-danger">${target.category.name}</td>
                                                        <td class="text-success">${target.income.name}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${target.currentAmount >= target.amount}">
                                                                    <span class="text-success">Đã hoàn thành</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-info">Đang theo dõi</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="/client/budget/view/${target.id}"
                                                                class="btn btn-success btn-sm">Xem</a>
                                                            <a href="/client/budget/edit/${target.id}"
                                                                class="btn btn-warning btn-sm">Sửa</a>
                                                            <form action="/client/budget/delete/${target.id}"
                                                                method="post" style="display:inline;">
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                                <input type="submit" class="btn btn-danger btn-sm"
                                                                    value="Xóa"
                                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa mục tiêu này?');" />
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>

                                        </table>
                                    </div>
                                </div>

                                <!-- Thông báo nhắc nhở -->
                                <c:if test="${not empty notifications}">
                                    <div class="alert alert-info">
                                        <h5>Thông báo:</h5>
                                        <ul>
                                            <c:forEach var="notice" items="${notifications}">
                                                <li>${notice}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>

                            </div>
                        </main>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>