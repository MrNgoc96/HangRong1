$(document).ready(function () {
    $('#love').click(function () {
        $(this).toggleClass('loved');
    });
    $('#like').click(function () {
        $(this).toggleClass('like');
        if ($('#dislike').hasClass('dislike')) {
            $('#dislike').removeClass('dislike');
        }
    });
    $('#dislike').click(function () {
        $(this).toggleClass('dislike');
        if ($('#like').hasClass('like')) {
            $('#like').removeClass('like');
        }
    });
})