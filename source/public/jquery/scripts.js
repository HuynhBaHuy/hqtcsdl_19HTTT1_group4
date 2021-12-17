$('#accept-order-btn').on('click', function(e) {
    e.preventDefault();
    const formData = {
        orderId: $(this).attr('data-id'),
        orderStatus: 'Đang giao hàng'
    }
    if($('#spFixed').is(":checked"))
            formData.spFixed = true
        else
            formData.spFixed = false
    $.ajax({
        type: "POST",
        url: '/driver/accept-order',
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(res){
            // Hide loading spinner
            $('.spanner').removeClass('show');
            $('.overlay-spinner').removeClass('show');
            console.log(res);
            if(res == 'failed') {
                // Show error modal
                $('#accept-order-error-modal').modal('show');
                $('#accept-order-error-modal .title').text('Error');
                $('#accept-order-error-modal .message').text('Transaction (Process ID 54) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. ');
            }
            else {
                // Show success modal
                $('#accept-order-success-modal').modal('show');
                $('#accept-order-success-modal .title').text('Success');
                $('#accept-order-success-modal .message').text('Chấp nhận đơn hàng thành công');
            }
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
    // Hide loading spinner
    $('.spanner').addClass('show');
    $('.overlay-spinner').addClass('show');
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
    if($('#spFixed').is(":checked"))
            formData.spFixed = true
        else
            formData.spFixed = false
    $.ajax({
        type: "POST",
        url: '/driver/update-order-status',
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(res){
            // Hide loading spinner
            $('.spanner').removeClass('show');
            $('.overlay-spinner').removeClass('show');
             // Show success modal
             if(res==='success'){
                $('#update-successful-status-for-driver-modal').modal('show');
                $('#update-successful-status-for-driver-modal .title').text('Thành công');
                $('#update-successful-status-for-driver-modal .message').text('Cập nhật đơn hàng thành công!');
             }
             else if(res==='rollback'){
                $('#rollback-for-driver-modal').modal('show');
                $('#rollback-for-driver-modal .title').text('Rollback');
                $('#rollback-for-driver-modal .message').text('Cập nhật không thành công!');
             }
             else{
                console.log(res);
                 $(`#delivering-order-table .status-col[of=${orderId}]`).text(res);
                 $('#overwritten-status-for-driver-modal').modal('show');
                $('#overwritten-status-for-driver-modal .title').text('Thành công');
                $('#overwritten-status-for-driver-modal .message').text('Cập nhật đơn hàng thành công!');
             }
              
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

$('#expired-contract-table button[name="extend-contract-time"]').on('click', function(e){
    e.preventDefault();
    const id = $(this).attr('data-id');
    const expiredTime = $(`#expired-contract-table .expired-time-col[of=${id}]`).text();
    const fee = $(`#expired-contract-table .fee-col[of=${id}]`).text();
    $('#extend-contract-time-modal').modal('show');
    $('#extend-contract-time-modal').attr('data-id',id);
    $('#extend-contract-time-modal .fee').val(fee);
    $('#extend-contract-time-modal .expired-time').val(expiredTime)
})

$('#extend-contract-time-modal input[type=submit]').click(event=>{
    event.preventDefault();
    $('#extend-contract-time-modal').modal('hide');
    const contractId = $('#extend-contract-time-modal').attr('data-id');
    const fee = $('#extend-contract-time-modal .fee').val();
    const tax=$(`#expired-contract-table .tax-code-col[of=${contractId}]`).text();
    const expiredTime = $('#extend-contract-time-modal .expired-time').val();
    const formData = {
        fee: fee,
        expiredTime: expiredTime,
        tax:tax
    }
    if($('#spFixed').is(":checked"))
            formData.spFixed = true
        else
            formData.spFixed = false
    $.ajax({
        type: "POST",
        url: '/employee/extend-contract-time',
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(res){
             // Show success modal
              $('#successful-for-employee-modal').modal('show');
              // Hide loading spinner
              $('.spanner').removeClass('show');
              $('.overlay-spinner').removeClass('show');
              $('#successful-for-employee-modal .title').text('Thành công');
              $('#successful-for-employee-modal .message').text('Cập nhật hợp đồng thành công!');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
           if(errorThrown) {
               console.log(errorThrown);
               // Show error modal
                $('#error-for-employee-modal').modal('show');
                // Hide loading spinner
                $('.spanner').removeClass('show');
                $('.overlay-spinner').removeClass('show');
                $('#error-for-employee-modal .title').text('Error');
                $('#error-for-employee-modal .message').text('Error: ' + errorThrown);
           }
        }
    })
    // Hide loading spinner
    $('.spanner').addClass('show');
    $('.overlay-spinner').addClass('show');

})

$('#expired-contract-table button.del-contract-btn').click(function (event) {
    event.preventDefault();
    const partnerId = $(this).attr('data-id');
    $('#confirm-remove-contract-modal').modal('show');
    $('#confirm-remove-contract-modal').attr('data-id',partnerId);
})
$('#confirm-remove-contract-modal button.confirm-btn').on('click', function(event) {
    event.preventDefault();
    $('#confirm-remove-contract-modal').modal('hide');
    const formData ={
        partnerId: $('#confirm-remove-contract-modal').attr('data-id')
    }
    if($('#spFixed').is(":checked"))
            formData.spFixed = true
        else
            formData.spFixed = false
    $.ajax({
        type: "POST",
        url: '/employee/delete-contract',
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(res){

            // Hide loading spinner
            $('.spanner').removeClass('show');
            $('.overlay-spinner').removeClass('show');
            if(res==='success'){
                // Show success modal
              $('#successful-for-employee-modal').modal('show');       
              $('#successful-for-employee-modal .title').text('Thành công');
              $('#successful-for-employee-modal .message').text('Xóa hợp đồng thành công');
            }
            else if(res==='rollback'){
                $('#rollback-for-employee-modal').modal('show');       
                $('#rollback-for-employee-modal .title').text('Rollback');
                $('#rollback-for-employee-modal .message').text('ERROR: 0 row effected');
            }
            else{
                $('#error-for-employee-modal').modal('show');       
                $('#error-for-employee-modal .title').text('Thất bại');
                $('#error-for-employee-modal .message').text('Không tồn tại hợp đồng này');
            }
             
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
           if(errorThrown) {
               console.log(errorThrown);
               // Show error modal
                $('#error-for-employee-modal').modal('show');
                // Hide loading spinner
                $('.spanner').removeClass('show');
                $('.overlay-spinner').removeClass('show');
                $('#error-for-employee-modal .title').text('Error');
                $('#error-for-employee-modal .message').text('Error: ' + errorThrown);
           }
        }
    })
    // Hide loading spinner
    $('.spanner').addClass('show');
    $('.overlay-spinner').addClass('show');
})


// close on modal
$('#update-order-status-for-driver-modal .close').on('click', function(e){
    e.preventDefault();
    $('#update-order-status-for-driver-modal').modal('hide');
})
$('#extend-contract-time-modal .close').on('click', function(e){
    e.preventDefault();
    $('#extend-contract-time-modal').modal('hide');
})
$('#confirm-remove-contract-modal .close').on('click', function(e){
    e.preventDefault();
    $('#confirm-remove-contract-modal').modal('hide');
})


// close error modal for accept order
$('#accept-order-error-modal .btn').on('click', function(e){
    e.preventDefault();
    $('#accept-order-error-modal').hide();
    window.location.reload();
})

// close error modal for delete contract 
$('#error-for-employee-modal .btn').on('click', function(e){
    e.preventDefault();
    $('#error-for-employee-modal').hide();
    window.location.reload();
})

// close rollback modal for delete contract 
$('#rollback-for-employee-modal .btn').on('click', function(e){
    e.preventDefault();
    $('#rollback-for-employee-modal').hide();
    window.location.reload();
})

// close rollback modal for update order
$('#rollback-for-driver-modal .btn').on('click', function(e){
    e.preventDefault();
    $('#rollback-for-driver-modal').hide();
    window.location.reload();
})

// close overwritten modal for update order
$('#overwritten-status-for-driver-modal .btn').on('click', function(e){
    e.preventDefault();
    $(function () {
        $('#overwritten-status-for-driver-modal').modal('toggle');
     });
})