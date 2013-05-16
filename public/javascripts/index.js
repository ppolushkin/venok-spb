(function () {

    $(document).ready(function () {
        fixContentHeight();
        highlightAdminMenu();
        highlightMenu();
        highlightNavigationMenu();
        hideHtmlNotice();
        logout();
        setupAjax();
    });

    function highlightAdminMenu() {
        var str = location.href.toLowerCase();
        $("#admin ul li.on").removeClass("on");
        $("#admin ul li a").each(function () {
            if (str == this.href.toLowerCase()) {
                $(this).parent().addClass("on");
            }
        });
    }

    function highlightMenu() {
        var str = location.href.toLowerCase();
        $("#menu li.on").removeClass("on");

        $("#menu li a").each(function () {
            if (this.pathname == '/') {
                if (location.pathname == '/') {
                    $(this).parent().addClass("on");
                }
            } else if (str.indexOf(this.href.toLowerCase()) > -1) {
                $(this).parent().addClass("on");
            }
        });
    }

    function highlightNavigationMenu() {
        var str = location.href.toLowerCase();
        $("#navigation ul li.on").removeClass("on");
        $("#navigation ul li a").each(function () {
            if (str == this.href.toLowerCase()) {
                $(this).parent().addClass("on");
            }
        });
    }

    function hideHtmlNotice() {
        var $notice = $('#notice');
        $notice.fadeOut(3000);
    }

    function logout() {
        $('a[href="/logout"]').click(function (e) {
            e.preventDefault();
            $.ajax({url:'/logout', method:'DELETE', success:function (msg) {
                location.pathname = '/';
            }});
        });
    }

    function setupAjax() {
        $.ajaxSetup({
            headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            }
        });
    }

    function fixContentHeight() {
        var h =$(document).height() - 173;
        $('#body-container').css('min-height', h);
    }

})();

function showMessage(text, interval) {
    var $notice = $('<div id="ajax-notice">' + text + '</div>').prependTo($('#content'));
    $notice.fadeOut(interval);
}
