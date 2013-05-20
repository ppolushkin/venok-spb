(function () {
    $(document).ready(function () {
        $('#buy').bind('click', function(e) {
            e.preventDefault();
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
                }
            });

        });
    });
})();
