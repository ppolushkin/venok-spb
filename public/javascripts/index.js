$(document).ready(function () {
    highlightMenu();
    logout();
});

function highlightMenu() {
    var str = location.href.toLowerCase();
    var is_root = location.pathname == "/";
    $("li.on").removeClass("on");

    if (is_root) {
        $("li.root").addClass("on");
    } else {
        $("#menu li a").each(function () {
            if (str == this.href.toLowerCase()) {
                $(this).parent().addClass("on");
            }
        });
    }
}

function logout() {
    $('a[href="/logout"]').click(function (e) {
        e.preventDefault();
        $.ajax({url:'/logout', method:'DELETE', success:function (msg) {
            location.reload();
        }});
    });
}