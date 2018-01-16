(function () {

    window['SYS'] = {
        showMessage:function (text) {
            var $notice = $('<div id="ajax-notice">' + text + '</div>').prependTo($('#content'));
            $notice.fadeOut(3000);
        },

        showBasket:function () {
            $.ajax({url:'/api/v1/basket', method:'GET', success:function (msg) {
                if (msg.count > 0) {
                    $('.basketInfo').text('В корзине ' + msg.count + ' товар(а) на ' + msg.price);
                } else {
                    $('.basketInfo').text('Корзина пуста');
                }

                var $warning = $('#depotIsLack');
                if (msg.availiable == false) {
                    $warning.show();
                } else {
                    $warning.hide();
                }

            }});
        },

        handleAjaxError:function (jqXHR, textStatus, errorThrown) {
             console.log("REST error: " + textStatus);
             console.log("incoming Text: " + jqXHR.responseText);
             console.log("errorThrown: " + errorThrown);
        },

        blinkColor:function ($obj) {
            var color = $obj.css('color');
            $obj.css("color", "red");
            setInterval(function () {
                $obj.css("color", color);
            }, 3000);
        },

        blinkBorder:function ($obj) {
            var color = $obj.css('border-color');
            $obj.css("border-color", "red");
            setInterval(function () {
                $obj.css("border-color", color);
            }, 3000);
        },

        showLoadingDialog:function () {
            $('#dialog').dialog('open').html("<p>Идет обработка</p>");
        },

        hideLoadingDialog:function () {
            $('#dialog').dialog('close');
        }
    };

    $(document).ready(function () {
        setupMoveUpLink();
        fixContentHeight();
        highlightAdminMenu();
        highlightMenu();
        highlightNavigationMenu();
        hideHtmlNotice();
        logout();
        setupAjax();
        prepareLoadingDialog();
        SYS.showBasket();
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
            headers:{
                'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
            }
        });
    }

    function fixContentHeight() {
        var h = $(document).height() - 173;
        $('#body-container').css('min-height', h);
    }

    function prepareLoadingDialog() {
        $("#dialog").dialog({
            dialogClass: "no-close",
            hide: 'clip',
            show: 'clip',
            modal: 'true',
            autoOpen: false
        });
    }

    function setupMoveUpLink() {
        $(window).scroll(function () {
            if($(window).width() < 960) {
                $('a#move_up').fadeOut(600);
                return;
            }
            var showAfter = $('#header').height() + $('#navigation').height();
            console.log(showAfter);

            if ($(this).scrollTop() > showAfter) {
                $('a#move_up').fadeIn(600);
            } else {
                $('a#move_up').fadeOut(600);
            }
        });
        $('a#move_up').click(function () {
            $('body,html').animate({
                scrollTop: 0
            }, 0);
            return false;
        });
    }

})();
