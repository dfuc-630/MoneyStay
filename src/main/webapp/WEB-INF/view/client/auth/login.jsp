<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Login</title>

                <!-- Internal CSS -->
                <style>
                    body {
                        font-family: 'Arial', sans-serif;
                        background-color: #f8f9fa;
                        margin: 0;
                        padding: 0;
                    }

                    .vh-100 {
                        height: 100vh;
                    }

                    .container {
                        max-width: 1200px;
                        margin: auto;
                        padding: 20px;
                    }

                    .row {
                        display: flex;
                        flex-wrap: wrap;
                        align-items: center;
                        justify-content: center;
                    }

                    .col-md-6,
                    .col-lg-5 {
                        flex: 0 0 45%;
                        max-width: 45%;
                        margin: 10px;
                    }

                    .img-fluid {
                        max-width: 100%;
                        height: auto;
                        display: block;
                        margin: auto;
                    }

                    .form-container {
                        background-color: #fff;
                        padding: 30px;
                        border-radius: 12px;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }

                    .form-container h3 {
                        text-align: center;
                        color: #007bff;
                        margin-bottom: 20px;
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-group label {
                        display: block;
                        font-weight: 600;
                        margin-bottom: 8px;
                    }

                    .form-control {
                        width: 100%;
                        padding: 12px;
                        font-size: 16px;
                        border: 1px solid #ccc;
                        border-radius: 6px;
                    }

                    .btn {
                        width: 100%;
                        padding: 12px;
                        font-size: 16px;
                        background-color: #007bff;
                        color: white;
                        border: none;
                        border-radius: 6px;
                        cursor: pointer;
                    }

                    .btn:hover {
                        background-color: #0056b3;
                    }

                    .alert {
                        padding: 10px;
                        border-radius: 6px;
                        margin-bottom: 15px;
                    }

                    .alert-danger {
                        background-color: #f8d7da;
                        color: #721c24;
                    }

                    .alert-success {
                        background-color: #d4edda;
                        color: #155724;
                    }

                    .text-center {
                        text-align: center;
                    }

                    .text-danger {
                        color: #dc3545;
                        text-decoration: none;
                    }

                    .text-danger:hover {
                        text-decoration: underline;
                    }

                    .fw-bold {
                        font-weight: 600;
                    }

                    .small {
                        font-size: 0.9rem;
                    }
                </style>
            </head>

            <body>
                <section class="vh-100 d-flex align-items-center justify-content-center bg-light">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 col-lg-5 mb-4">
                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                                    class="img-fluid" alt="Login image">
                            </div>
                            <div class="col-md-6 col-lg-5">
                                <form method="post" action="/login" class="form-container">

                                    <h3>Login</h3>

                                    <c:if test="${param.error != null}">
                                        <div class="alert alert-danger">Invalid email or password.</div>
                                    </c:if>
                                    <c:if test="${param.logout != null}">
                                        <div class="alert alert-success">Logout success.</div>
                                    </c:if>

                                    <div class="form-group">
                                        <label for="form3Example3">Email address</label>
                                        <input type="email" id="form3Example3" name="username" class="form-control"
                                            placeholder="Enter your email" required />
                                    </div>

                                    <div class="form-group">
                                        <label for="form3Example4">Password</label>
                                        <input type="password" id="form3Example4" name="password" class="form-control"
                                            placeholder="Enter your password" required />
                                    </div>

                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="form-group">
                                        <button type="submit" class="btn">Login</button>
                                    </div>

                                    <div class="text-center">
                                        <p class="small fw-bold">Don't have an account?
                                            <a href="/register" class="text-danger">Register</a>
                                        </p>
                                        <p class="small fw-bold">Back to
                                            <a href="/" class="text-danger">guest mode</a>
                                        </p>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </body>

            </html>