<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>MoneyStay</title>
                <!-- Favicon-->
                <link rel="icon" type="image/x-icon" href="/client/assets/favicon.ico" />
                <!-- Bootstrap icons-->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet" />
                <!-- Core theme CSS (includes Bootstrap)-->
                <link href="/client/css/styles.css" rel="stylesheet" />
            </head>

            <body>
                <!-- Responsive navbar-->
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                    <div class="container px-lg-5">
                        <a class="navbar-brand" href="/">MoneyStay</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation"><span
                                class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                                <!-- <li class="nav-item"><a class="nav-link" href="#!">About</a></li> -->
                                <li class="nav-item"><a class="nav-link" href="/contact">More About Us</a></li>
                                <li class="nav-item"><a class="nav-link" href="#!">Login</a></li>
                                <li class="nav-item"><a class="nav-link" href="#!">Sign Up</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Header-->
                <header class="py-5">
                    <div class="container px-lg-5">
                        <div class="p-4 p-lg-5 bg-light rounded-3 text-center">
                            <div class="m-4 m-lg-5">
                                <h1 class="display-5 fw-bold">MoneyStay !</h1>
                                <p class="fs-4">MoneyStay là một nền tảng quản lý tài chính cá nhân được thiết kế giúp
                                    bạn kiểm soát thu nhập, chi tiêu và tiết kiệm một cách hiệu quả.</p>
                                <a class="btn btn-primary btn-lg" href="/client">Bắt đầu ngay</a>
                            </div>
                        </div>
                    </div>
                </header>
                <!-- Page Content-->
                <section class="pt-4">
                    <div class="container px-lg-5">
                        <!-- Page Features-->
                        <div class="row gx-lg-5">
                            <div class="col-lg-6 col-xxl-4 mb-5">
                                <div class="card bg-light border-0 h-100">
                                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i
                                                class="bi bi-collection"></i></div>
                                        <h2 class="fs-4 fw-bold">Quản lý thu nhập & chi tiêu</h2>
                                        <p class="mb-0">Ghi nhận mọi khoản thu nhập và chi tiêu, phân loại theo danh mục
                                            cụ thể.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-xxl-4 mb-5">
                                <div class="card bg-light border-0 h-100">
                                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i
                                                class="bi bi-cloud-download"></i></div>
                                        <h2 class="fs-4 fw-bold">Xuất báo cáo</h2>
                                        <p class="mb-0">Hỗ trợ xuất dữ liệu dưới dạng CSV hoặc PDF để lưu trữ và phân
                                            tích.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-xxl-4 mb-5">
                                <div class="card bg-light border-0 h-100">
                                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i
                                                class="bi bi-card-heading"></i></div>
                                        <h2 class="fs-4 fw-bold">Thống kê & báo cáo</h2>
                                        <p class="mb-0">Cung cấp biểu đồ trực quan giúp bạn dễ dàng theo dõi dòng tiền.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-xxl-4 mb-5">
                                <div class="card bg-light border-0 h-100">
                                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i
                                                class="bi bi-bootstrap"></i></div>
                                        <h2 class="fs-4 fw-bold">Đáng tin cậy</h2>
                                        <p class="mb-0">Những thông tin chính xác và đảm bảo tính minh bạch rõ ràng</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-xxl-4 mb-5">
                                <div class="card bg-light border-0 h-100">
                                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i
                                                class="bi bi-code"></i></div>
                                        <h2 class="fs-4 fw-bold">Lập kế hoạch tài chính</h2>
                                        <p class="mb-0">Đặt ngân sách cho từng danh mục để kiểm soát chi tiêu hiệu quả
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-xxl-4 mb-5">
                                <div class="card bg-light border-0 h-100">
                                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i
                                                class="bi bi-patch-check"></i></div>
                                        <h2 class="fs-4 fw-bold">Bảo mật cao</h2>
                                        <p class="mb-0">Dữ liệu cá nhân được bảo vệ an toàn, đảm bảo quyền riêng tư.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Footer-->
                <footer class="py-5 bg-dark">
                    <div class="container">
                        <p class="m-0 text-center text-white">Copyright &copy; Đoàn Đại Phúc</p>
                    </div>
                </footer>
                <!-- Bootstrap core JS-->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
                <!-- Core theme JS-->
                <script src="/client/js/scripts.js"></script>
            </body>

            </html>