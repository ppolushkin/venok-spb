(function () {
    $(document).ready(function () {
        activateDeliveryCheckBox();
    });

    function activateDeliveryCheckBox() {
        showAddress(false);
        $('.deliveryCheckBox').on('click', function (e) {
            showAddress(true);
        });
    }

    function showAddress(effect) {
        var $checkBox = $('.deliveryCheckBox');
        var $field = $('.deliveryAddress');
        var $price = $('.price');
        var $priceWithDelivery = $('.priceWithDelivery');

        if ($checkBox.is(':checked')) {
            if(effect == true) {
                $field.slideDown();
                $price.slideUp();
                $priceWithDelivery.slideDown();
            } else {
                $field.show();
                $price.hide();
                $priceWithDelivery.show();
            }
        } else {
            if(effect == true) {
                $field.slideUp();
                $price.slideDown();
                $priceWithDelivery.slideUp();
            } else {
                $field.hide();
                $price.show();
                $priceWithDelivery.hide();

            }
        }
    }


})();