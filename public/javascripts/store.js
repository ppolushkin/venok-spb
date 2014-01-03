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
        $('.product-item').each( function () {
            var $productItem = $(this);
            var $id = $productItem.find('.id');

            var product_id = $id[0].classList[1];

            $.ajax({
                url:'/api/v1/depot/get_available_items/' + product_id,
                method:'GET',
                contentType:'application/json',
                success:function (msg) {
                    if (msg.available) {
                        $id.addClass('present')
                    } else {
                        $id.addClass('absent')
                    }
                }
            });
        });
    }

})();
