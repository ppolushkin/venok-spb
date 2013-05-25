(function () {

    $(document).ready(function () {
        drawTable();
        activateAddButton();
        activateLoadButton();
    });

    function negativeValueRenderer(instance, td, row, col, prop, value, cellProperties) {
        Handsontable.TextCell.renderer.apply(this, arguments);
        if (parseInt(value, 10) < 0) {
            td.className = 'negative';
        }

    }

    Handsontable.cellLookup.renderer.negativeValueRenderer = negativeValueRenderer; //maps function to lookup string

    var data = [

        {index:'1', name:'рит/ венок "Аврора" 3.2.3', number:'1'},
        {index:'2', name:'рит/ венок "Акварель" 5.4.6', number:'1'},
        {index:'-3', name:'рит/ венок "Арамис" 4.3.5', number:'1'},
        {index:'4', name:'рит/ венок "Бонапарт" 3.4.7', number:'1'},
        {index:'5', name:'рит/ венок "Викинг" 5.4.6', number:'1'},
        {index:'6', name:'рит/ венок "Джоконда" 3.2.4', number:'1'},
        {index:'7', name:'рит/ венок "Джульетта" 5.4.6', number:'1'}


    ];

    function drawTable() {
        var container = $("#dataTable");
        container.handsontable({
        data:data,
        colHeaders:["№", "Наименование", "Поступившее количество"],

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
            if (col == 0) {
                cellProperties.renderer = negativeValueRenderer;
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
            for (var i = 0; i < count; i++) {
                data.push({index:'', name:"", number:''});
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
                        data[i].index = msg.data[i].index;
                    }


                    $("#dataTable").handsontable('render');
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