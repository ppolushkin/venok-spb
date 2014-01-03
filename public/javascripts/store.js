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

            var classList = $id.className.split(/\s+/);
            var product_id = classList[1];
            alert(product_id);
        });
    }

})();
