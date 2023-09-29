$(document).on('change', '#payment-select', function () {
    var selectedPayment = $(this).val();
    $.ajax({
        url: '/mentors/filter_by_payment' + '?payment=' + selectedPayment,
        type: 'GET',
        dataType: 'script', // Sử dụng dataType là script để Rails hiểu rằng phản hồi sẽ là JavaScript
        success: function (response) {
        },
        error: function () {
        }
    });
});

$(document).on('change', '#status-select', function () {
    var selectedStatus= $(this).val();
    $.ajax({
        url: '/mentors/filter_by_status' + '?status=' + selectedStatus,
        type: 'GET',
        dataType: 'script', // Sử dụng dataType là script để Rails hiểu rằng phản hồi sẽ là JavaScript
        success: function (response) {
        },
        error: function () {
        }
    });
});

$(document).on('submit', '#search-form', function (e) {
    e.preventDefault(); // Ngăn chặn việc gửi form thông qua phương thức truyền thống
    var query = $('#search-form input[name="query"]').val();
    $.ajax({
        url: '/mentors/search',
        type: 'GET',
        data: {query: query},
        dataType: 'script',
        success: function (response) {
        },
        error: function () {
        }
    });
});

$(document).on('change', '#date-filter-form', function(e) {
    e.preventDefault(); // Ngăn chặn việc gửi form thông qua phương thức truyền thống
    var dateFrom = $('#date_from').val();
    var dateTo = $('#date_to').val();
    if(dateFrom && dateTo) {
        $.ajax({
            url: '/mentors/filter_by_date?date_from=' + dateFrom + '&date_to=' + dateTo, // Địa chỉ URL xử lý yêu cầu
            type: 'GET', // Phương thức yêu cầu
            // data: {date_from: dateFrom, date_to: dateTo}, // Dữ liệu gửi đi
            dataType: 'script', // Định dạng dữ liệu trả về
            success: function (response) {
                // Xử lý kết quả trả về nếu cần
            },
            error: function () {
                // Xử lý lỗi nếu cần
            }

        });
    }
});