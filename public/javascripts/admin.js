(function() {

    $(document).ready(function() {
        activateDeleteButtons();
    });

    function activateDeleteButtons() {
        $('a[data-method=delete]').each(function () {
            var self = this;
            $(self).bind('click', function(e) {
                e.preventDefault();
                $.ajax({url: self.href, method:'DELETE', success:function (msg) {
                    SYS.showMessage("Removed successfully", 3000);
                    $(self).parent().parent().hide();
                }});
            });
        })
    }

})();