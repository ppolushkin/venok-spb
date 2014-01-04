(function () {
    $(document).ready(function () {
        putProductToBasket();
        activateInputByEnterKey();
        activateBuyButton();
        populateProductCount();
    });

    function populateProductCount() {
        var product_id = $('#productId').val();
        $.ajax({
            url:'/api/v1/basket/' + product_id,
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('#buy').val("В корзине");
                $('#productCount').val(msg.count);
            },
            error:function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status == 400) {
                    $('#buy').val("Положить в корзину");
                    $('#productCount').val(1);
                }
            }
        });
    }

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
                $('#buy').val("В корзине");
                SYS.showMessage("Товар добавлен");
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

    function putProductToBasket() {
        if($('#buy:enabled').size() == 1) {
            processBuyButtonClick();
        }
    }


})();
