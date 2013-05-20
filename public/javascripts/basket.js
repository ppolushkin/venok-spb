(function () {
    $(document).ready(function () {
        $('#buy').bind('click', function(e) {
            e.preventDefault();
            $('#productCount').removeClass("errorField");
            var id = $('#productId').val();
            var count = $('#productCount').val();

            $.ajax({
                url: '/api/v1/basket',
                method:'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify({id:id, count:count}),
                success:function (msg) {
                    SYS.showMessage("Товар добавлен", 3000);
                    SYS.showBasket();
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 400) {
                        $('#productCount').addClass("errorField");
                        SYS.showMessage("Неверный параметр", 3000);
                    } else {
                        SYS.showMessage("Unknown server error", 3000);
                    }
                }
            });

        });
    });
})();
