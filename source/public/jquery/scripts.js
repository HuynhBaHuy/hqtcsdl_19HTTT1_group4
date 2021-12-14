$('#accept-order-btn').on('click', function(e) {
    e.preventDefault();
    const formData = {
        orderId: $(this).attr('data-id'),
        orderStatus: 'Đang giao hàng'
    }
    $.ajax({
        type: "POST",
        url: '/driver/accept-order',
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(res){
             // Show success modal
              $('#accept-order-success-modal').modal('show');
              $('#accept-order-success-modal .title').text('Success');
              $('#accept-order-success-modal .message').text('Chấp nhận đơn hàng thành công');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
           if(errorThrown) {
               console.log(errorThrown);
               // Show error modal
                $('#accept-order-error-modal').modal('show');
                $('#accept-order-error-modal .title').text('Error');
                $('##accept-order-error-modal .message').text('Error: ' + errorThrown);
           }
        }
    });
})
$('#delivering-order-table button[name="update-order-status"]').on('click', function(e){
    e.preventDefault();
    const id = $(this).attr('data-id');
    const oldStatus = $(`#delivering-order-table .status-col[of=${id}]`).text();

    $('#update-order-status-for-driver-modal').modal('show');
    $('#update-order-status-for-driver-modal .old-status-input').val(oldStatus)
    $('#update-order-status-for-driver-modal .order-id').val(id)
    
})
$('#update-order-status-for-driver-modal input[type="submit"]').on('click',function (e) {
    e.preventDefault();
    $('#update-order-status-for-driver-modal').modal('hide');
    const newOrderStatus = $('#update-order-status-for-driver-modal select[name="new-order-status"] option:selected').val();
    const orderId = $('#update-order-status-for-driver-modal .order-id').val();
    const formData = {
        orderId:orderId,
        newOrderStatus: newOrderStatus
    }
    
    $.ajax({
        type: "POST",
        url: '/driver/update-order-status',
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(res){
             // Show success modal
              $('#update-successful-status-for-driver-modal').modal('show');
              // Hide loading spinner
              $('.spanner').removeClass('show');
              $('.overlay-spinner').removeClass('show');
              $('#update-successful-status-for-driver-modal .title').text('Thành công');
              $('#update-successful-status-for-driver-modal .message').text('Cập nhật đơn hàng thành công!');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
           if(errorThrown) {
               console.log(errorThrown);
               // Show error modal
                $('#update-status-for-driver-error-modal').modal('show');
                // Hide loading spinner
                $('.spanner').removeClass('show');
                $('.overlay-spinner').removeClass('show');
                $('#update-status-for-driver-error-modal .title').text('Error');
                $('#update-status-for-driver-error-modal .message').text('Error: ' + errorThrown);
           }
        }
    })
    // Hide loading spinner
    $('.spanner').addClass('show');
    $('.overlay-spinner').addClass('show');
});
