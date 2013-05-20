(function () {
    $(document).ready(function () {
        activateInputByEnterKey();
        activateBuyButton();
    });

    function activateInputByEnterKey() {
        $('#productCount').keypress(function (e) {
            if (e.which == 13) {
                processBuyButtonClick();
            }
        });
    }

    function activateBuyButton() {
        $('#buy').bind('click', function (e) {
            e.preventDefault();
            processBuyButtonClick();
        });
    }

    function processBuyButtonClick() {
        $('#productCount').removeClass("errorField");
        var id = $('#productId').val();
        var count = $('#productCount').val();

        $.ajax({
            url:'/api/v1/basket',
            method:'PUT',
            contentType:'application/json',
            dataType:'json',
            data:JSON.stringify({id:id, count:count}),
            success:function (msg) {
                SYS.showMessage("Товар добавлен", 3000);
                SYS.showBasket();
            },
            error:function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status == 400) {
                    $('#productCount').addClass("errorField");
                }
                SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
            }
        });
    }
})();
