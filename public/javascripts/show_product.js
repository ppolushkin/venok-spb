(function () {
    $(document).ready(function () {
        activateInputByEnterKey();
        activateBuyButton();
        populateProductCount();
        populateTapeInfo();
        activateBuyTapeButton();
        activateTapeTextInput();
        activateTapeColorSelector();
    });

    function populateProductCount() {
        var product_id = $('#productId').val();
        $.ajax({
            url:'/api/v1/basket/product/' + product_id+'?ts=' + $.now(),
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('#buy').val("В корзине");
                $('#productCount').val(msg.count);
            },
            error:function (jqXHR) {
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
        var $productCount = $('#productCount');
        $productCount.removeClass("errorField");
        var id = $('#productId').val();
        var count = $productCount.val();

        $.ajax({
            url:'/api/v1/basket/product',
            method:'PUT',
            contentType:'application/json',
            dataType:'json',
            data:JSON.stringify({id:id, count:count}),
            success:function () {
                $('#buy').val("В корзине");
                SYS.showMessage("Товар добавлен");
                putTape();
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

    function populateTapeInfo() {
        var product_id = $('#productId').val();
        $.ajax({
            url: '/api/v1/basket/tape/' + product_id+'?ts=' + $.now(),
            method: 'GET',
            contentType: 'application/json',
            dataType: 'json',
            success: function (msg) {
                if(msg.count > 0) {
                    $('#buyTape').prop('checked', true);
                    $('.tapeTextField').show();
                    $('.tapeTextInput').text(msg.text);
                    $('.tapeColor').show();
                    $('.tapeColorSelector').val(msg.color);

                } else {
                    $('#buyTape').prop('checked', false);
                    $('.tapeTextField').hide();
                    $('.tapeColor').hide();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
            }
        });
    }

    function putTape(hint) {
        var product_id = $('#productId').val();
        var text = $('.tapeTextInput').val();
        var count = $('#productCount').val();
        var color = $('.tapeColorSelector').val();

        if ($('#buyTape').is(':checked')) {
            $.ajax({
                url: '/api/v1/basket/tape',
                method: 'PUT',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify({product_id: product_id, color: color, text: text, count: count}),
                success: function () {
                    if(hint) {
                        SYS.showMessage(hint);
                    }
                    SYS.showBasket();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
                }
            });
        }
    }

    function activateBuyTapeButton() {
        $('#buyTape').change(function () {
            if (this.checked) {
                $('.tapeTextField').slideDown();
                $('.tapeColor').slideDown();
                putTape('Лента добавлена');
            } else {
                var product_id = $('#productId').val();
                $.ajax({
                    url: '/api/v1/basket/tape/'+product_id,
                    method: 'DELETE',
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function () {
                        SYS.showMessage("Лента удалена");
                        $('.tapeTextField').slideUp();
                        $('.tapeColor').slideUp();
                        SYS.showBasket();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
                    }
                });

            }
        });
    }

    function activateTapeTextInput() {
        $('.tapeTextInput').focusout(function() {
                putTape();
            }
        );
    }

    function activateTapeColorSelector() {
        $('.tapeColorSelector').change(function() {
                putTape();
            }
        );
    }

})();
