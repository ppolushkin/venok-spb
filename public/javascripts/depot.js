(function () {

    $(document).ready(function () {
        drawTable();
        activateAddButton();
        activateLoadButton();
    });

    function statusRenderer(instance, td, row, col, prop, value, cellProperties) {
        Handsontable.TextCell.renderer.apply(this, arguments);
//        new, loaded, failed
        if (value) {
            td.className = value;
        }
    }

    Handsontable.cellLookup.renderer.statusRenderer = statusRenderer; //maps function to lookup string

    var data = [
        {index:'', name:'', number:'', status: ''},
    ];

    function drawTable() {
        var container = $("#dataTable");
        container.handsontable({
        data:data,
        colHeaders:["№", "Наименование", "Поступившее количество", "Статус"],

        contextMenu:false,
        onSelection:function (row, col, row2, col2) {
            var meta = container.handsontable('getCellMeta', row2, col2);
            if (meta.isWritable == false) {
                container.handsontable('updateSettings', {fillHandle:false});
            }
            else {
                container.handsontable('updateSettings', {fillHandle:true});
            }
        },
        cells:function (row, col, prop) {
            var cellProperties = {};
            if (col == 3) {
                cellProperties.renderer = statusRenderer;
            }
            return cellProperties;
        }
    });
    }


    function activateAddButton() {
        $('#addButton').on('click', function (e) {
            var self = this;
            e.preventDefault();
            var count = $('#count').val();

            data.length = 0;
            for (var i = 1; i <= count; i++) {
                data.push({index: i, name:"", number:'', status:'new'});

            }
            $("#dataTable").handsontable('render');

        });
    }

    function activateLoadButton() {
        $('#loadButton').on('click', function (e) {
            e.preventDefault();
            var self = this;

            $.ajax({
                url:'/api/v1/depot',
                method:'PUT',
                contentType:'application/json',
                dataType:'json',
                data:JSON.stringify({data:data}),
                success:function (msg) {
                    for (var i = 0; i < data.length; i++) {
                        data[i].status = msg.data[i].status;
                    }
                    $("#dataTable").handsontable('render');
                },
                error: SYS.handleAjaxError
            });
        });
    }

})();