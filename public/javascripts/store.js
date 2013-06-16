(function () {
    $(document).ready(function () {
        $('.product-item').each( function () {
            var $productItem = $(this);
            var name = $productItem.find('.description').text();
//            var price = $productItem.find('.price span').text();
            var size = $productItem.find('.size').text();
            var $thumb = $productItem.find('a.thumb');
            var info =  '<strong>'  + name + '</strong>&nbsp;&nbsp;(' + size + ')';

            console.log("html = "  + "html");

            $thumb.colorbox({
                initialHeight: "410px",
                initialWidth: "300px",
                title: info
            });
        });
    });
})();
