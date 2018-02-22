$(document).ready(function () {
    $('#product-images').change(function () {
        let input = this;
        let url = $(this).val();
        let ext = url.substring(url.lastIndexOf('.') + 1)
            .toLowerCase();
        if (input.files
            && (ext == "gif" || ext == "png"
                || ext == "jpeg" || ext == "jpg")) {
            $('#pro-images').empty();
            if (input.files.length >= 2 && input.files.length <= 6)
                for (let i = 0; i < input.files.length; i++) {
                    let reader = new FileReader();
                    reader.onload = function (e) {
                        $('#pro-images').append('<div class="image col-md-4"><img src="' + e.target.result + '" class="img-rounded img-responsive "></div>');
                    }
                    reader.readAsDataURL(input.files[i]);
                }
        }
    });
    loadEventRemoveProduct();
    getProductDetails();
    loadChangeProductForm();
    $('#form-product form').submit(() => validateProductForm());
});

function signOut() {
    window.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://localhost:8080/hangrong/log-out.html";
};

function getProductDetails() {
    let details = '';
    $('.detail').each(function () {
        details += $(this).children('.title-detail').text() + $(this).children('.content-detail').children().val() + ';'
    })
    $('#product-details').val(details);
}

// Cập nhật tình trang đơn hàng
function updateOrderStatus(orderId, statusId) {
    let link = './shop-management.html?updateOrderStatus&orderId=' + orderId + '&statusId=' + statusId;
    let orderStatus;
    if (statusId == 1) {
        orderStatus = 'Đang giao hàng'
    } else {
        orderStatus = "Đã nhận hàng"
    }
    Confirm("Cập nhật đơn hàng", "Xác nhận thay đổi trạng thái của đơn hàng là <b>" + orderStatus + "</b> ?", "Đồng ý", "Hủy", link)

}

function deleteOrder(orderId) {
    let link = './shop-management.html?deleteOrder&orderId=' + orderId;
    Confirm("Xóa đơn hàng", "Xác nhận xóa bỏ đơn hàng <b>DH" + orderId + "</b> ?", "Đồng ý", "Hủy", link)
}


// Xem chi tiết đơn hàng
function viewOrder(orderId) {
    $.get('./view-order-details.html?orderId=' + orderId).done(function (data) {
        let allData = $('<div/>').html(data);
        let orderDetails = allData.find("#orderDetails");
        $('#orderDetails').replaceWith(orderDetails);
    }, 'html')
}

// Thêm các thông tin chi tiết cho sản phẩm
function addDetail() {
    let param = $('#param').val();
    let description = $('#description').val();
    $('#table-details').append('<tr class="detail"><td class="title-detail">' + param + ':</td>' +
        '<td class="content-detail"><input class="form-control" value="' + description + '"></td>' +
        '<td><button type="button" class="btn btn-danger remove-detail"><i class="fa fa-trash"></i></button></td></tr>');
    loadEventRemoveProduct();
    getProductDetails();
    $('.content-detail input').change(() => getProductDetails())
}

function loadEventRemoveProduct() {
    $('.remove-detail').click(function () {
        $(this).parent().parent().remove();
        getProductDetails();
    });
}

function loadChangeProductForm() {
    $('#product-name').change(function () {
        let name = $(this).val();
        if (name == "") {
            $(this).css({border: '2px solid red'});
            $(this).next().show();
        } else {
            $(this).css({border: ''});
            $(this).next().hide();
        }
    });
    $('#product-price').change(function () {
        let price = $(this).val();
        if (isNaN(price) == true || price < 0) {
            $(this).css({border: '2px solid red'});
            $(this).next().show();
        } else {
            $(this).css({border: ''});
            $(this).next().hide();
        }
    });
    $('#product-intro').change(function () {
        let intro = $(this).val();
        if (intro == "") {
            $(this).css({border: '2px solid red'});
            $(this).next().show();
        } else {
            $(this).css({border: ''});
            $(this).next().hide();
        }
    });
    $('#product-images').change(function () {
        let fileAmount = this.files.length;
        if (fileAmount < 2) {
            $('#error-more-image').hide();
            $('#error-less-image').show();
        } else if (fileAmount > 6) {
            $('#error-less-image').hide();
            $('#error-more-image').show();
        } else {
            $('#error-less-image').hide();
            $('#error-more-image').hide();
        }
    });
    $('#product-details').change(function () {
        let detail = $(this).val();
        if (detail == "") {
            $('#error-detail').show();
        } else {
            $('#error-detail').hide();
        }
    });
}

function validateProductForm() {
    let form = $('#form-product form')
    let name = $('#product-name')
    let price = $('#product-price')
    let intro = $('#product-intro')
    let detail = $('#product-details')
    if (name.val() == "") {
        name.css({border: 'solid 2px red'});
        $('#error-name').show()
        return false;
    } else if (isNaN(price.val()) == true || price.val() < 0 || price.val() == "") {
        price.css({border: 'solid 2px red'});
        $('#error-price').show()
        return false;
    } else if (intro.val() == "") {
        intro.css({border: 'solid 2px red'});
        $('#error-intro').show()
        return false;
    }
    if (form.has('#product-discount').length) {
        let discount = $('#product-discount')
        if (isNaN(discount.val()) == true || discount <= 0 || discount.val() == "") {
            return false;
        }
    }
    if (form.has('#product-images').length) {
        let image = $('#product-images').get(0).files.length;
        if (image < 2) {
            $('#error-less-image').show();
            return false;
        } else if (image > 6) {
            $('#error-more-image').show();
            return false;
        }
    }
    if (detail.val() == "") {
        $('#error-detail').show();
        return false;
    }

}

function deleteProduct(productId) {
    let title = $('#del-product-confirm-title').html();
    let msg = $('#del-product-confirm-message').html();
    let yes = $('#del-product-confirm-yes').html();
    let no = $('#del-product-confirm-no').html();
    let link = './shop-management.html?removeProduct&productId=' + productId;
    Confirm(title, msg, yes, no, link);
}
