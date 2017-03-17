$(document).ready(function () {
    $('.digits').click(function () {
        $.ajax({
            url: '/?r=site/ajax',
            dataType: 'json',
            success: function (data) {
                $.each(data, function (i, v) {
                    $('div#digit' + i).html(v);
                })
            }
        });
    })
});