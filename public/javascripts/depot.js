(function() {

    $(document).ready(function() {
        drawTable();
        activateAddButton();
        activateLoadButton();
    });

    var data = [
        {index: '', name:"", number: ''}
    ];

    function drawTable() {
        $("#dataTable").handsontable({
            data:data,
            colHeaders: ["№", "Наименование", "Поступившее количество"],
            colWidths:[50, 400, 400],
            columns:[
                {data:"index", type:'numeric'},
                {data:"name", type:'text'},
                {data:"number", type:'numeric'}
            ]
        });
    }

    function activateAddButton() {
        $('#addButton').on('click', function (e) {
            var self = this;
            e.preventDefault();
            var count = $('#count').val();

            data.length = 0;
            for (var i=0; i<count; i++) {
                data.push({index: '', name:"", number: ''});
            }
            $("#dataTable").handsontable('render');

        });
    }


    function activateLoadButton() {
        $('#loadButton').on('click', function (e) {
            var self = this;
            e.preventDefault();

            $.ajax({
                url:'/api/v1/depot',
                method:'PUT',
                contentType:'application/json',
                dataType:'json',
                data:JSON.stringify({data: data}),
                success:function (msg) {

                    alert('ok');
                },
                error:function (jqXHR, textStatus, errorThrown) {
                    alert('fail');
                    if (jqXHR.status == 400) {
                        SYS.blinkColor($(self));
                        SYS.blinkBorder($(self));
                    }
                    SYS.handleAjaxError(jqXHR, textStatus, errorThrown);
                }
            });


        });
    }

})();