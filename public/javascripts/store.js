(function () {
    $(document).ready(function () {
        $(".thumb img").lazyload();
        setupColorBox();
        setupAvailable();
    });


    function setupColorBox() {
        $('.product-item').each( function () {
            var $productItem = $(this);
            var name = $productItem.find('.description').text();
            var size = $productItem.find('.size').text();
            var $thumb = $productItem.find('a.thumb');
            var info =  '<strong>'  + name + '</strong>&nbsp;&nbsp;(' + size + ')';

            $thumb.colorbox({
                initialHeight: "410px",
                initialWidth: "300px",
                title: info
            });
        });
    }

    function setupAvailable() {
        var data = [];
        $('.product-item').each( function () {
            var $productItem = $(this);
            var $id = $productItem.find('.id');
            var product_id = $id[0].classList[1];
            data.push({"id" : product_id});
        });

        $.ajax({
            url:'/api/v1/depot/get_available_items',
            method:'POST',
            contentType:'application/json',
            dataType:'json',
            data:JSON.stringify({data:data}),

            success:function (data) {
                for(var i = 0; i < data.data.length; i++) {
                    if(data.data[i].available) {
                        var id = data.data[i].id;
                        var $a = $('.buyButton' + id);
                        $a.css( "display", "block");
                        $a.on('click', {id: id, url: $a.attr('href')}, processBuyClick);
                    } else {
                        $('.absentText' + data.data[i].id).css( "display", "block");
                    }

                }
            }
        });
    }

    function processBuyClick(e) {
        var id = e.data.id;
        var url = e.data.url;
        var count = 1;

        e.preventDefault();

        $.ajax({
            url:'/api/v1/basket/product',
            method:'PUT',
            contentType:'application/json',
            dataType:'json',
            data:JSON.stringify({id:id, count:count}),
            success:function (msg) {
                document.location.href = url;
            },
            error: SYS.handleAjaxError
        });

    }



})();


