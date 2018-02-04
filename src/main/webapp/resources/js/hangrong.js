$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() > 120) {
            $('#logoArea').css({
                'position': 'fixed',
                'height': '20px',
                'width': '100%'
            });
            $('#logoArea').addClass('header__fixed');
        } else {
            $('#logoArea').css({
                'position': 'relative',
                'height': '20px',
                'width': ''
            });
            $('#logoArea').removeClass('header__fixed');
        }

    });
    $('#categories').selectmenu();
    /* carousel of home page animation */
    $('#myCarousel').carousel({
        interval: 4000
    })
    $('#featured').carousel({
        interval: 4000
    })
    $(function () {
        $('#gallery a').lightBox();
    });
});

// Đăng nhập bằng Google
function onSignIn(googleUser) {
    $('#googleLoginMessage').hide();
    if (googleLogin == 'false') {
        var id_token = googleUser.getAuthResponse().id_token;
        $.post("./google-log-in.html", {
            'idToken': id_token
        }).done(function (data) {
            let allData = $('<div />').html(data);
            let error = allData.find('#login_error');
            if (error.val() == "") {
                window.location.href = "./login.html";
            } else {
                $.ajax({
                    type: "GET",
                    dataType: 'jsonp',
                    url: 'https://www.google.com/accounts/Logout'
                });
                let login = allData.find('#form-login');
                $('#form-login').replaceWith(login);
                $('#googleLoginMessage').show();
            }
        });
    }
}

// Đăng xuất
function signOut() {
    window.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://localhost:8080/hangrong/log-out.html";
};

// Thêm sản phẩm vào giỏ hàng
function addToCart(productId) {
    let url = './add-to-cart.html'
    let param = {'productId': productId};
    updateCart(url, param);
}

function removeProduct(productId) {
    let url = './remove-product.html'
    let param = {'productId': productId};
    updateCart(url, param);
}

function increasedQuantity(productId) {
    let url = './update-quantity.html'
    let param = {'productId': productId, 'increased': true};
    updateCart(url, param);
}

function decreasedQuantity(productId) {
    let url = './update-quantity.html'
    let param = {'productId': productId, 'increased': false};
    updateCart(url, param);
}

function updateCart(url, params) {
    $.get(url, params).done(function (data) {
        let allData = $('<div />').html(data);
        let header = allData.find('.navbar-inner');
        let cart = allData.find('#cart');
        let cartBean = allData.find('#cartBean');
        $('.navbar-inner').replaceWith(header);
        $('#cart').replaceWith(cart);
        $('#cartBean').replaceWith(cartBean);
    }, 'html');
}

function login() {
    $('#loginMessage').hide();
    let username = $('#username').val();
    let password = $('#password').val();
    if (username == "") {
        $('#username_error').show();
        $('#password_error').hide();
        return;
    } else if (password == "") {
        $('#username_error').hide();
        $('#password_error').show();
        return;
    } else {
        $('#username_error').hide();
        $('#password_error').hide();
        $('#loading').show();
        setTimeout(function () {
            $('#loading').hide();
            $.post('./login.html', {'username': username, 'password': password}).done(function (data) {
                let allData = $('<div />').html(data);
                let error = allData.find('#login_error');
                if (error.val() == "") {
                    $('#login-form').submit();
                } else {
                    let login = allData.find('#form-login');
                    $('#form-login').replaceWith(login);
                    $('#loginMessage').show();
                }
            }, 'html');
        },3000);
    }

}

function Confirm(title, msg, $true, $false, $link) {
    var $content = "<div class='dialog-ovelay'>"
        + "<div class='dialog'><div class='.head'>" + "<h3> " + title + " </h3> " + "</div>"
        + "<div class='dialog-msg'>" + " <p> " + msg + " </p> " + "</div>"
        + "<div class='footer'>" + "<div class='controls'>"
        + " <button class='btn btn-success button-danger doAction'><i class='fa fa-check'></i> " + $true
        + "</button> "
        + " <button class='btn btn-danger button button-default cancelAction'><i class='fa fa-ban'></i> " + $false
        + "</button> " + "</div>" + "</div>" + "</div>" + "</div>";
    $('body').prepend($content);
    $('.doAction').click(function () {
        window.location.href = $link;
        $(this).parents('.dialog-ovelay').fadeOut(500, function () {
            $(this).remove();
        });
    });
    $('.cancelAction, .fa-close').click(function () {
        $(this).parents('.dialog-ovelay').fadeOut(500, function () {
            $(this).remove();
        });
    });

}
