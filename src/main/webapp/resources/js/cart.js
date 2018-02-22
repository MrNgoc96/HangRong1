$(document).ready(function () {
    $('#form-order').submit(function () {
        let email = $('#orderEmail').val();
        let acong = email.indexOf('@');
        let dot = email.lastIndexOf('.');
        if($('#orderName').val()==""){
            $('#error_orderName').show();
            $('#orderName').css({border:'2px solid red'});
            return false;
        }else if(email == "" || dot + 2 > email.length || acong < 1 || dot < acong + 2){
            $('#error_orderEmail').show();
            $('#orderEmail').css({border:'2px solid red'});
            return false;
        }else if($('#orderAddress').val()==""){
            $('#error_orderAddress').show();
            $('#orderAddress').css({border:'2px solid red'});
            return false;
        }
    });
    $('#orderName').change(function () {
        if($('#orderName').val()=="") {
            $('#error_orderName').show();
            $(this).css({border: '2px solid red'});
        }else {
            $('#error_orderName').hide();
            $(this).css({border: ''});
        }
    });
    $('#orderEmail').change(function () {
        let email = $(this).val();
        let acong = email.indexOf('@');
        let dot = email.lastIndexOf('.');
        if(email == "" || dot + 2 > email.length || acong < 1 || dot < acong + 2) {
            $('#error_orderEmail').show();
            $(this).css({border: '2px solid red'});
        }else {
            $('#error_orderEmail').hide();
            $(this).css({border: ''});
        }
    });
    $('#orderAddress').change(function () {
        if($('#orderAddress').val()=="") {
            $('#error_orderAddress').show();
            $(this).css({border: '2px solid red'});
        }else {
            $('#error_orderAddress').hide();
            $(this).css({border: ''});
        }
    });
})