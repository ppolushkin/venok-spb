(function() {

    $(document).ready(function() {
        activateDeleteButtons();
        effectFailedFields();
    });

    function activateDeleteButtons() {
        $('a[data-method=delete]').each(function () {
            var self = this;
            $(self).bind('click', function(e) {
                e.preventDefault();
                $.ajax({url: self.href, method:'DELETE', success:function (msg) {
                    SYS.showMessage("Удалено");
                    $(self).parent().parent().hide();
                }});
            });
        })
    }

    function effectFailedFields() {
        var $label = $('.field_with_errors').prev();
        var $input = $('.field_with_errors').children();
        SYS.blinkColor($label);
        SYS.blinkBorder($input);
    }
})();