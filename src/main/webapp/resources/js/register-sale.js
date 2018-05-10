$(document).ready(function () {
    $('#register-form').submit(function () {
        let acong = $('#email').val().indexOf('@');
        let dot = $('#email').val().lastIndexOf('.');
        let email = $('#email').val();
        if ($('#name').val() == "") {
            $('#error_name').show();
            $('#name').css({border: '2px solid red'});
            return false;
        }  else if (email == "" || dot + 2 > email.length || acong < 1 || dot < acong + 2) {
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
        }
    });
    loadChangeRegisterForm();
});


function loadChangeRegisterForm() {
    $('#name').change(function () {
        if ($(this).val() == "") {
            $('#error_name').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_name').hide();
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
    $('#register_password').change(function () {
        if ($(this).val() == "" || $(this).val().length <= 5) {
            $('#error_password').show();
            $(this).css({border: '2px solid red'});
        } else {
            $('#error_password').hide();
            $(this).css({border: ''});
        }
    });


}

