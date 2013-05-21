(function () {
    $(document).ready(function () {
        activateItemCountInput();
        activateRemoveLink();
        setupFormAction();
    });

    function setupFormAction() {
        $.ajax({
            url:'/api/v1/basket/',
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('#newOrderForm')[0].action='/order/new/' + msg.id;
            },
            error:SYS.handleAjaxError
        });
    }

    function populateCommonPrice(product_id) {
        $.ajax({
            url:'/api/v1/basket/' + product_id,
            method:'GET',
            contentType:'application/json',
            success:function (msg) {
                $('.' + product_id + ' .common_price').text(msg.common_price);
            },
            error:SYS.handleAjaxError
        });
    }

    function activateItemCountInput() {
        $('input.itemCount').keypress(function (e) {
            var self = this;
            if (e.which == 13) {
                var $tr = $(self).parent().parent();
                var id = $tr[0].className;
                var count = $(self).val();

                $.ajax({
                    url:'/api/v1/basket',
                    method:'PUT',
                    contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({id:id, count:count}),
                    success:function (msg) {
                        populateCommonPrice(id);
                        SYS.showBasket();
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 400) {
                            $(self).addClass("errorField");
                        }
                        SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
                    }
                });

            }
        });
    }

    function activateRemoveLink() {
        $('a.removeItemLink').bind('click', function (e) {
            var self = this;
            e.preventDefault();
            var $tr = $(self).parent().parent();
            var product_id = $tr[0].className;

            $.ajax({
                url:'/api/v1/basket/' + product_id,
                method:'DELETE',
                contentType:'application/json',
                success:function (msg) {
                    $tr.hide();
                    if($('td:visible').size() == 0) {
                        $('tr').hide();
                    }

                    SYS.showMessage("Товар удален из корзины");
                    SYS.showBasket();
                },
                error:SYS.handleAjaxError
            });
        });
    }

})();
