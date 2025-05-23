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
                <title>Create Transaction</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../../admin/layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../../admin/layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Create Transaction</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/transaction">Transaction</a> / Create
                                    </li>
                                </ol>

                                <div class="row">
                                    <div class="col-md-6 col-12 mx-auto">
                                        <h3>Add New Transaction</h3>
                                        <hr />
                                        <form:form method="post" action="/transaction/create"
                                            modelAttribute="transaction">
                                            <div class="mb-3">
                                                <label class="form-label">Amount</label>
                                                <form:input type="number" step="0.01" class="form-control"
                                                    path="amount" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Note</label>
                                                <form:textarea class="form-control" path="note" rows="3" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Category</label>
                                                <form:select path="category.id" class="form-select">
                                                    <form:options items="${categories}" itemValue="id"
                                                        itemLabel="name" />
                                                </form:select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Date</label>
                                                <form:input type="date" class="form-control" path="date" />
                                            </div>

                                            <div class="row mx-auto">
                                                <a href="/transaction" class="btn btn-success col-2">Back</a>
                                                <button type="submit" class="btn btn-primary col-2 mx-2">Create</button>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>