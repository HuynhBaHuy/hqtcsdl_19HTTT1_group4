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