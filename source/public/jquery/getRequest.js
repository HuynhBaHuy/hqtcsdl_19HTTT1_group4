$(window).on('load', function () {
    
    const origin   = window.location.origin;
    const url = origin + '/';
    function loadOrderPerPage(currentPage) {
        const fulUrl = url + currentPage.toString();
        $.get(fulUrl, function (data) {
            // Table body temporary container
            const tableBody = $("<tbody></tbody>");
            tableBody.addClass("table-body");

            // Load data to temporary table body
            data.orders.forEach((order, index) => {
                const template = `<tr>
                    <td>
                        <div class="name-col">${order.id}</div>
                    </td>
                    <td>
                        <div class="customer-name-col">${order.customerName}</div>
                    </td>
                    <td>
                        <div class="address-col">${order.address}</div>
                    </td>
                    <td>
                        <div class="price-col">${order.totalPrice.toLocaleString()}</div>
                    </td>
                    <td>
                        <div class="status-col">${order.status}</div>
                    </td>
                    <td>
                        <div id="${order.id}" class="action-col">
                            <button type="button" id="editOrderStatus" class="mr-4"
                                title="Edit">Cập nhật tình trạng đơn hàng</button>
                        </div>
                    </td>
                </tr>`;

                tableBody.append(template);

                // Finish load all data of a page => render to layout
                if(index == arr.length - 1) {
                    $(".table-body").replaceWith(tableBody);
                }
            });

            // Update total properties in every get request
            $('.paging-wrapper').pagination('updateItems', data.count);
        });
    }
});
