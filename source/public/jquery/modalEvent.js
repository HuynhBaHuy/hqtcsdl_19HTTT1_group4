$(window).on('load', () => {

    // Clear form input and close add new property modal when click cancel button
    $("#cancelFormBtn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $("#addForm")[0].reset();
        $('#addPropertyModal').modal('hide');
    });


    // ------- SUCCESS MODAL EVENT --------
    // Close success modal
    $("#success-modal-btn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#successModal').modal('hide');
        window.location.reload();
    });

    // ------- ERROR MODAL EVENT --------
    // Close error modal
    $("#error-modal-btn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#errorModal').modal('hide');
    });

    // ------- DELETE MODAL EVENT --------
    // Open delete modal
    $(document).on( 'click', '#deletePropertyBtn', function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#deleteModal').modal('show');
        $('#delete-modal-delete-btn').addClass($(this).parent().attr('id'));
    });

    // Close delete modal
    $(document).on( 'click', '#delete-modal-cancel-btn', function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#deleteModal').modal('hide');
    });

    // Close delete modal
    $(document).on( 'click', '#exitDeleteModalBtn', function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#deleteModal').modal('hide');
    });

    // ------- EDIT ORDER MODAL EVENT --------
    // Open edit order modal
    $(document).on( 'click', '#editOrderStatusBtn', function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#editOrderModal').modal('show');

        // Get current order ID
        $('#editForm').addClass($(this).parent().attr('id'));

        const origin   = window.location.href;
        // url formart: http://localhost:3000/partner/order/<current order ID>
        const url = origin + '/' + $('#editForm').attr('class');
        $.get(url, function (orderStatus) {
            // Get current order status
           $('#editForm #oldOrderStatus').val(orderStatus);
        });
    });

    // Clear form input and close edit order modal when click cancel button
    $("#editOrderModal #cancelEditFormBtn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#editForm').removeClass($('#editForm')[0].classList[0]);
        $('#editOrderModal').modal('hide');
        $("#editForm")[0].reset();
    });

    // Clear form input and close edit order modal when click cancel button
    $("#editOrderModal #editCancelFormBtn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#editForm').removeClass($('#editForm')[0].classList[0]);
        $('#editOrderModal').modal('hide');
        $("#editForm")[0].reset();
    });


    // ------- EDIT PRODUCT MODAL EVENT --------
    // Open edit product modal
    $(document).on( 'click', '#editProductBtn', function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#editProductModal').modal('show');

        // Get current order ID
        $('#editProductForm').addClass($(this).parent().attr('id'));

        const origin   = window.location.href;
        // url formart: http://localhost:3000/partner/product/<current product ID>
        const url = origin + '/' + $('#editProductForm').attr('class');
        $.get(url, function (product) {
            // Get current product info
            $("#productName").val(product.name);
            $("#productCategory").val(product.category);
            $("#productPrice").val(product.price);
        });
    });

    // Clear form input and close edit product modal when click cancel button
    $("#editProductModal #cancelEditFormBtn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#editProductForm').removeClass($('#editProductForm')[0].classList[0]);
        $('#editProductModal').modal('hide');
        $("#editProductForm")[0].reset();
    });

    // Clear form input and close edit product modal when click cancel button
    $("#editProductModal #editCancelFormBtn").click(function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");
        $('#editProductForm').removeClass($('#editProductForm')[0].classList[0]);
        $('#editProductModal').modal('hide');
        $("#editProductForm")[0].reset();
    });
})