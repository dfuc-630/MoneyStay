<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Register</title>

                <style>
                    body,
                    html {
                        height: 100%;
                        margin: 0;
                        font-family: Arial, sans-serif;
                    }

                    .vh-100 {
                        height: 100vh;
                    }

                    .bg-image {
                        background-image: url('https://mdbcdn.b-cdn.net/img/Photos/new-templates/search-box/img4.webp');
                        background-size: cover;
                        background-position: center;
                    }

                    .mask {
                        background: rgba(0, 0, 0, 0.4);
                        height: 100%;
                        display: flex;
                        align-items: center;
                    }

                    .container {
                        width: 100%;
                        padding: 20px;
                    }

                    .row {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                    }

                    .col-12,
                    .col-md-9,
                    .col-lg-7,
                    .col-xl-6 {
                        width: 100%;
                        max-width: 500px;
                    }

                    .card {
                        background-color: #fff;
                        border-radius: 15px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                    }

                    .card-body {
                        padding: 40px;
                    }

                    h2 {
                        text-align: center;
                        margin-bottom: 30px;
                        color: #333;
                    }

                    .form-outline {
                        margin-bottom: 20px;
                    }

                    .form-label {
                        display: block;
                        margin-top: 5px;
                        font-size: 0.9rem;
                        color: #333;
                    }

                    .form-control {
                        width: 100%;
                        padding: 12px;
                        font-size: 16px;
                        border: 1px solid #ccc;
                        border-radius: 6px;
                        box-sizing: border-box;
                    }

                    .btn {
                        padding: 12px 24px;
                        font-size: 16px;
                        background-color: #28a745;
                        color: white;
                        border: none;
                        border-radius: 6px;
                        cursor: pointer;
                    }

                    .btn:hover {
                        background-color: #218838;
                    }

                    .text-center {
                        text-align: center;
                    }

                    .text-muted {
                        color: #6c757d;
                    }

                    .fw-bold {
                        font-weight: 600;
                    }

                    .text-body {
                        color: #343a40;
                        text-decoration: none;
                    }

                    .text-body:hover {
                        text-decoration: underline;
                    }
                </style>
            </head>

            <body>
                <section class="vh-100 bg-image">
                    <div class="mask">
                        <div class="container">
                            <div class="row">
                                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <h2 class="text-uppercase text-center mb-5">Create an account</h2>

                                            <form:form method="post" action="/register" modelAttribute="registerUser">

                                                <div class="form-outline">
                                                    <form:input type="text" id="form3Example1cg" class="form-control"
                                                        path="fullName" placeholder="Enter your name" />
                                                    <label class="form-label" for="form3Example1cg">Your Name</label>
                                                </div>

                                                <div class="form-outline">
                                                    <form:input type="email" id="form3Example3cg" class="form-control"
                                                        path="email" placeholder="Enter your email" />
                                                    <label class="form-label" for="form3Example3cg">Your Email</label>
                                                </div>

                                                <div class="form-outline">
                                                    <form:input type="password" id="form3Example4cg"
                                                        class="form-control" path="password"
                                                        placeholder="Enter your password" />
                                                    <label class="form-label" for="form3Example4cg">Password</label>
                                                </div>

                                                <div class="form-outline">
                                                    <form:input type="password" id="form3Example4cdg"
                                                        class="form-control" path="confirmPassword"
                                                        placeholder="Confirm your password" />
                                                    <label class="form-label" for="form3Example4cdg">Repeat your
                                                        password</label>
                                                </div>

                                                <div class="text-center">
                                                    <button type="submit" class="btn">Register</button>
                                                </div>

                                                <p class="text-center text-muted mt-4 mb-0">Have already an account?
                                                    <a href="/login" class="fw-bold text-body"><u>Login here</u></a>
                                                </p>

                                            </form:form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <script>
                    document.querySelector("form").addEventListener("submit", function (e) {
                        const password = document.getElementById("form3Example4cg").value;
                        const confirmPassword = document.getElementById("form3Example4cdg").value;

                        if (password !== confirmPassword) {
                            e.preventDefault();
                            alert("Mật khẩu xác nhận không khớp với mật khẩu!");
                        }
                    });
                </script>
            </body>

            </html>