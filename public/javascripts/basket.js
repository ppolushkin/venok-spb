(function () {
    $(document).ready(function () {
        activateProductCountInput();
        activateTapeCountInput();
        activateRemoveProductLink();
        activateRemoveTapeLink();
        setupButtonBehavior();
    });

    function setupButtonBehavior() {
        $.ajax({
            url:'/api/v1/basket/',
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('#newOrderForm').attr('action','/order/new/' + msg.id);
                if(msg.count > 0) {
                    $('#newOrderButton').attr("disabled", false);
                } else {
                    $('#newOrderButton').attr("disabled", "true");
                }
            },
            error:SYS.handleAjaxError
        });
    }

    function populateProductCommonPrice(product_id) {
        $.ajax({
            url:'/api/v1/basket/product/' + product_id,
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('.' + product_id + ' .common_price').text(msg.common_price);
            },
            error:SYS.handleAjaxError
        });
    }

    function populateTapeCommonPrice(product_id) {
        $.ajax({
            url:'/api/v1/basket/tape/' + product_id,
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('.' + product_id + ' .common_tape_price').text(msg.count * 300);
            },
            error:SYS.handleAjaxError
        });
    }

    function activateProductCountInput() {
        $('input.itemCount').keypress(function (e) {
            var self = this;
            if (e.which == 13) {
                var $tr = $(self).parent().parent();
                var id = $tr[0].className;
                var count = $(self).val();

                $.ajax({
                    url:'/api/v1/basket/product',
                    method:'PUT',
                    contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({id:id, count:count}),
                    success:function () {
                        setupButtonBehavior();
                        populateProductCommonPrice(id);
                        SYS.showBasket();
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 400) {
                            SYS.blinkColor($(self));
                            SYS.blinkBorder($(self));
                        }
                        SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
                    }
                });

            }
        });
    }

    function activateRemoveProductLink() {
        $('a.removeItemLink').on('click', function (e) {
            var self = this;
            e.preventDefault();
            var $tr = $(self).parent().parent();
            var product_id = $tr[0].className;

            $.ajax({
                url:'/api/v1/basket/product/' + product_id,
                method:'DELETE',
                contentType:'application/json',
                success:function () {
                    $tr.hide();
                    if($('.productTable td:visible').size() == 0) {
                        $('.productDiv').hide();
                    }
                    setupButtonBehavior();
                    SYS.showMessage("Товар удален из корзины");
                    SYS.showBasket();
                },
                error:SYS.handleAjaxError
            });
        });
    }

    function activateTapeCountInput() {
        $('input.tapeCount').keypress(function (e) {
            var self = this;
            if (e.which == 13) {
                var $tr = $(self).parent().parent();
                var id = $tr[0].className;
                var count = $(self).val();

                $.ajax({
                    url:'/api/v1/basket/tape',
                    method:'PUT',
                    contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({product_id:id, count:count}),
                    success:function () {
                        setupButtonBehavior();
                        populateTapeCommonPrice(id);
                        SYS.showBasket();
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 400) {
                            SYS.blinkColor($(self));
                            SYS.blinkBorder($(self));
                        }
                        SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
                    }
                });

            }
        });
    }

    function activateRemoveTapeLink() {
        $('a.removeTapeLink').on('click', function (e) {
            var self = this;
            e.preventDefault();
            var $tr = $(self).parent().parent();
            var product_id = $tr[0].className;

            $.ajax({
                url:'/api/v1/basket/tape/' + product_id,
                method:'DELETE',
                contentType:'application/json',
                success:function () {
                    $tr.hide();
                    if($('.tapeTable td:visible').size() == 0) {
                        $('.tapeDiv').hide();
                    }
                    setupButtonBehavior();
                    SYS.showMessage("Лента удалена из корзины");
                    SYS.showBasket();
                },
                error:SYS.handleAjaxError
            });
        });
    }

})();
