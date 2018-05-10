$(document).ready(function () {
    $('#datepicker').datepicker();
    $('#customer-info-form').submit(function () {
        let acong = $('#email').val().indexOf('@');
        let dot = $('#email').val().lastIndexOf('.');
        let phone = $('#phone').val();
        let email = $('#email').val();
        if ($('#name').val() == "") {
            $('#error_name').show();
            $('#name').css({border: '2px solid red'});
            return false;
        } else if ($('#datepicker').val() == "") {
            $('#error_DOB').show();
            $('#datepicker').css({border: '2px solid red'});
            return false;
        } else if (email == "" || dot + 2 > email.length || acong < 1 || dot < acong + 2) {
            $('#error_emailUsed').hide();
            $('#error_email').show();
            $('#email').css({border: '2px solid red'});
            return false;
        } else if ($('#register_password').val() == "" && $('#register_password').val().length <= 5) {
            $('#error_password').show();
            $('#register_password').css({border: '2px solid red'});
            return false;
        } else if ($('#address').val() == "") {
            $('#error_address').show();
            $('#address').css({border: '2px solid red'});
            return false;
        } else if (phone == "" || isNaN(phone) == true || phone.length < 8 || phone.length > 12) {
            $('#error_phone').show();
            $('#phone').css({border: '2px solid red'});
            return false;
        }
    });
    loadChangeForm();
});

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
            $.post('./check-password.html', {olderPass: orderPass, newPass: newPass}).done(function (data) {
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

function loadChangeForm() {
    $('#name').change(function () {
        if ($(this).val() == "") {
            $('#error_name').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_name').hide();
            $(this).css({border: ''});
        }
    });
    $('#datepicker').change(function () {
        if ($(this).val() == "") {
            $('#error_DOB').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_DOB').hide()
            $(this).css({border: ''});
        }
    });
    $('#email').change(function () {
        let acong = $(this).val().indexOf('@');
        let dot = $(this).val().lastIndexOf('.');
        if ($('#email').val() == "" || dot + 2 > $('#email').val().length || acong < 1 || dot < acong + 2) {
            $('#error_emailUsed').hide();
            $('#error_email').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_emailUsed').hide();
            $('#error_email').hide();
            $(this).css({border: ''});
        }
    });
    $('#address').change(function () {
        if ($(this).val() == "") {
            $('#error_address').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_address').hide()
            $(this).css({border: ''});
        }
    });
    $('#address').change(function () {
        if ($(this).val() == "") {
            $('#error_address').show();
            this.css({border: '2px solid red'});
        } else {
            $('#error_address').hide()
            this.css({border: ''});
        }
    });
    $('#phone').change(function () {
        let phone = $(this).val();
        if (phone == "" || isNaN(phone) == true || phone.length < 8 || phone.length > 12) {
            $('#error_phone').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_phone').hide();
            $(this).css({border: ''});
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

