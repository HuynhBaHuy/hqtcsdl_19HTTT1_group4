$(window).on('load', function () {
    
    

    // Get product list of a specific partner
    $(document).on( 'click', '#showProductList', function (e) { 
        e.preventDefault();
        $(this).removeAttr("href");

        var formData = {}
        // check what store procedure to use (error or fixed)
        if($('#spFixed').is(":checked"))
            formData['spFixed'] = true
        else
            formData['spFixed'] = false

        const origin   = window.location.origin;
        const url = origin + '/customer/product/' + $(this).parent().attr('id') + '/?spFixed=' + formData.spFixed;
        // url formart: http://localhost:3000/customer/product/<current partner ID>/?spFixed=<true/false>
        window.location.replace(url);
    });

});
