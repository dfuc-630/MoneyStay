// Cấu hình mặc định của Chart.js
Chart.defaults.global.defaultFontFamily = '-apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Lấy phần tử canvas để vẽ biểu đồ
var ctx = document.getElementById("myAreaChart");

// Dữ liệu ban đầu: 6 tháng gần nhất
var nhanX = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12",];
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

// // Hàm cập nhật chi tiêu mỗi tháng
// function capNhatBieuDo() {
//   var thangMoi = "Tháng " + (parseInt(nhanX[nhanX.length - 1].split(" ")[1]) + 1); // Tăng tháng
//   var chiTieuMoi = Math.floor(Math.random() * (10000000 - 3000000) + 3000000); // Ngẫu nhiên 3-10 triệu VNĐ

//   // Thêm dữ liệu mới
//   nhanX.push(thangMoi);
//   duLieu.push(chiTieuMoi);

// // Giữ tối đa 12 tháng
// if (nhanX.length > 12) {
//   nhanX.shift();
//   duLieu.shift();
// }

//   // Cập nhật biểu đồ
//   bieuDoDuong.data.labels = nhanX;
//   bieuDoDuong.data.datasets[0].data = duLieu;
//   bieuDoDuong.update();
// }

// // Tự động cập nhật mỗi 5 giây (tượng trưng cho cập nhật mỗi tháng)
// setInterval(capNhatBieuDo, 5000);
