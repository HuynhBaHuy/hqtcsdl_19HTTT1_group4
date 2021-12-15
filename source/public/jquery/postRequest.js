$(window).on('load', () => {
    const origin   = window.location.href;

    // Update order status
    $( "#editForm" ).submit(function( event ) {
        event.preventDefault();
        const formData = $('#editForm').serializeArray().reduce(function(obj, item) {
            obj[item.name] = item.value;
            return obj;
        }, {});

        // check what store procedure to use (error or fixed)
        if($('#spFixed').is(":checked"))
            formData['spFixed'] = true
        else
            formData['spFixed'] = false
        // url formart: http://localhost:3000/partner/order/edit/<current order ID>
        const url = origin + '/edit/' + $('#editForm').attr('class');
        $.ajax({
            type: "POST",
            url: url,
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function(res){
                 // Show success modal
                  $('#successModal').modal('show');
                  // Hide loading spinner
                  $('.spanner').removeClass('show');
                  $('.overlay-spinner').removeClass('show');
                  $('#successTitle').text('Success');
                  $('#successMsg').text('Tình trạng đơn hàng đã cập nhật');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
               if(errorThrown) {
                   console.log(errorThrown);
                   // Show error modal
                    $('#errorModal').modal('show');
                    $('#editPropertyModal').modal('hide');
                    $('#errorTitle').text('Error');
                    $('#errorMsg').text('Error: ' + errorThrown);
               }
            }
        });

    });

    // Update product
    $( "#editProductForm" ).submit(function( event ) {
        event.preventDefault();
        const formData = $('#editProductForm').serializeArray().reduce(function(obj, item) {
            obj[item.name] = item.value;
            return obj;
        }, {});

        // check what store procedure to use (error or fixed)
        if($('#spFixed').is(":checked"))
            formData['spFixed'] = true
        else
            formData['spFixed'] = false
        // url formart: http://localhost:3000/partner/product/edit/<current product ID>
        const url = origin + '/edit/' + $('#editProductForm').attr('class');
        $.ajax({
            type: "POST",
            url: url,
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function(res){
                 // Show success modal
                  $('#successModal').modal('show');
                  // Hide loading spinner
                  $('.spanner').removeClass('show');
                  $('.overlay-spinner').removeClass('show');
                  $('#successTitle').text('Success');
                  $('#successMsg').text('Thông tin sản phẩm đã cập nhật');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
               if(errorThrown) {
                   console.log(errorThrown);
                   // Show error modal
                    $('#errorModal').modal('show');
                    $('#editPropertyModal').modal('hide');
                    $('#errorTitle').text('Error');
                    $('#errorMsg').text('Error: ' + errorThrown);
               }
            }
        });

    });
});