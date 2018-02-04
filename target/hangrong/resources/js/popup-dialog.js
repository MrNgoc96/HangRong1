
function Confirm(title, msg, yes, no, link) {
    let content = "<div class='dialog-ovelay'>"
        + "<div class='dialog'><div class='.head'>" + "<h3> " + title + " </h3> " + "</div>"
        + "<div class='dialog-msg'>" + " <p> " + msg + " </p> " + "</div>"
        + "<div class='footer'>" + "<div class='controls'>"
        + " <button class='btn btn-success button-danger doAction'><i class='fa fa-check'></i> " + yes
        + "</button> "
        + " <button class='btn btn-danger button button-default cancelAction'><i class='fa fa-ban'></i> " + no
        + "</button> " + "</div>" + "</div>" + "</div>" + "</div>";
    $('body').prepend(content);
    $('.doAction').click(function () {
        window.location.href = link;
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
function showPopup(title,msg) {
    $('#popup-title h3').html(title);
    $('#popup-message p').html(msg);
    $('#close-popup').click(function () {
        $(this).parents('#popup').hide();
    });
    $('#popup').show();
}