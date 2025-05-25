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
                <title>Update Budget</title>
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
                                <h1 class="mt-4">Update Budet</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/client/budget">Budget</a> / Update</li>
                                </ol>

                                <div class="row">
                                    <div class="col-md-6 col-12 mx-auto">
                                        <h3> Update budget</h3>
                                        <hr />
                                        <form:form method="post" action="/client/budget/edit"
                                            modelAttribute="newBudget">
                                            <div class="mb-3" style="display: none;">
                                                <label for="exampleInputPassword1" class="form-label">ID</label>
                                                <form:input type="text" class="form-control" path="id" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputEmail1" class="form-label">Name</label>
                                                <form:input type="text" class="form-control" path="name" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputEmail1" class="form-label">Amount</label>
                                                <form:input type="text" class="form-control" path="amount" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="categorySelect" class="form-label">Outcome</label>
                                                <form:select path="category.id" cssClass="form-control"
                                                    id="categorySelect">
                                                    <form:option value="" label="-- Select Outcome Category --" />
                                                    <form:options items="${outcomeCategories}" itemValue="id"
                                                        itemLabel="name" />
                                                </form:select>
                                            </div>

                                            <div class="mb-3">
                                                <label for="incomeSelect" class="form-label">Income</label>
                                                <form:select path="income.id" cssClass="form-control" id="incomeSelect">
                                                    <form:option value="" label="-- Select Income Source --" />
                                                    <form:options items="${incomeList}" itemValue="id"
                                                        itemLabel="name" />
                                                </form:select>
                                            </div>

                                            <div class="row mx-auto">
                                                <a href="/client/budget" class="btn btn-success col-2">Back</a>
                                                <button type="submit" class="btn btn-warning col-2 mx-2">Submit</button>
                                            </div>

                                        </form:form>
                                    </div>
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