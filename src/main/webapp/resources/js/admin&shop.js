$(document).ready(function () {
    $('#shop-avatar').change(function () {
        let input = this;
        let url = $(this).val();
        let ext = url.substring(url.lastIndexOf('.') + 1)
            .toLowerCase();
        if (input.files
            && (ext == "gif" || ext == "png"
                || ext == "jpeg" || ext == "jpg")) {
            let reader = new FileReader();
            reader.onload = function (e) {
                $('#avatar-shop').attr('src',e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    });


    $('#remove-images').val("");
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
    removeImgEvent();
    addImgEvent();
    loadEventRemoveProduct();
    getProductDetails();
    loadChangeProductForm();
    $('#form-product form').submit(() => validateProductForm());
});

function signOut() {
    window.location.href = "../../../hangrong/log-out.html";
};

function removeImgEvent() {
    $('.img-remove').click(function () {
        let removeImage = $('#remove-images').val();
        let imageIndex = $(this).prev().prev().val();
        let replace = '<img style="z-index: 10;" src="http://mfmhyattsville1.org/Images/Dock/ImageUp.png" width="80%" class="img-thumbnail  img-rounded img-responsive ">\n' +
            '                                    <input class="product-image" style="position: absolute;top:0;left: 0;opacity: 0;width: 100%;height: 100%;cursor: pointer" type="file" name="image"\n' +
            '                                           accept=".jpg,.png,.jpeg" >';
        $(this).prev().remove();
        $(this).parent().append(replace);
        $(this).remove();
        addImgEvent();
        if (imageIndex != undefined) {
            imageIndex += ";"
            $('#remove-images').val(removeImage + imageIndex);
        }

    });
}

function addImgEvent() {
    $('.product-image').change(function () {
        let input = this;
        let url = $(this).val();
        let ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
        let result = '';
        if (input.files && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
            let reader = new FileReader();
            reader.onload = function () {
                result += reader.result;
            }
            reader.readAsDataURL(input.files[0]);
            alert("Upload ảnh thành công !");
            $(this).prev().remove();
            $(this).parent().append('<img src="' + result + '" width="90%" height="90%"\n' +
                '                                         class="img-thumbnail img-rounded img-responsive ">\n' +
                '                                    <button type="button" class="btn-danger img-remove"\n' +
                '                                            style="border-radius: 50%;top: 1%;right: 1%;position: absolute;">x\n' +
                '                                    </button>');

            removeImgEvent();
        }
    });
}


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
    $('#older-pass').change(function () {
        if ($(this).val() == "") {
            $(this).css({border: '2px solid red'});
            $('#error-older-pass').show();
        } else {
            $(this).css({border: ''});
            $('#error-older-pass').hide();
        }
    });
    $('#new-pass').change(function () {
        let newpass = $(this).val();
        if (newpass == "" || newpass.length <= 5) {
            $(this).css({border: '2px solid red'});
            $('#error-new-pass').show();
        } else {
            $(this).css({border: ''});
            $('#error-new-pass').hide();
        }
    });
    $('#re-pass').change(function () {
        let newpass = $('#new-pass').val();
        let repass = $(this).val();
        if (newpass != repass) {
            $(this).css({border: '2px solid red'});
            $('#error-re-pass').show();
        } else {
            $(this).css({border: ''});
            $('#error-re-pass').hide();
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

function changePassword() {
    $('#wrong-pass').hide();
    let orderPass = $('#older-pass').val();
    let newPass = $('#new-pass').val();
    let rePass = $('#re-pass').val();
    if (orderPass == "") {
        $('#older-pass').css({border: '2px solid red'});
        $('#error-older-pass').show();
    } else if (newPass == "" || newPass.length <= 5) {
        $('#new-pass').css({border: '2px solid red'});
        $('#error-new-pass').show();
    } else if (newPass != rePass) {
        $('#re-pass').css({border: '2px solid red'});
        $('#error-re-pass').show();
    } else {
        $('#loading-pass').show();
        setTimeout(function () {
            $('#loading-pass').hide();
            $.post('./shop-management.html?check-password', {olderPass: orderPass, newPass: newPass}).done(function (data) {
                let allData = $('<div/>').html(data);
                let error = allData.find('#is-pass-correct');
                if (error.val() == 'true') {
                    $('#form-change-pass').submit();
                } else {
                    $('#wrong-pass').show();
                }
            }, 'html');
        }, 3000);
    }
}
