<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Create User</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../../admin/layout/header2.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../../admin/layout/sidebar2.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid">
                                <h2 class="text-center text-primary">Danh sách giao dịch chi tiêu</h2>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Ngày giao dịch</th>
                                                <th>Ngày hiệu lực</th>
                                                <th>Mô tả</th>
                                                <th>Mã giao dịch</th>
                                                <th class="text-end">Số tiền chi (Outcome)</th>
                                                <th class="text-end">Số dư</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="transaction" items="${outcomeTransactions}">
                                                <tr>
                                                    <td>${transaction.transaction_date}</td>
                                                    <td>${transaction.effective_date}</td>
                                                    <td>${transaction.description}</td>
                                                    <td>${transaction.transaction_code}</td>
                                                    <td class="text-end text-danger">
                                                        <strong>${transaction.debit}</strong>
                                                    </td>
                                                    <td class="text-end">${transaction.balance}</td>
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
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
            </body>


            </html>