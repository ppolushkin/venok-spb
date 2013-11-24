(function () {

    $(document).ready(function () {
        loadData();
        drawTable();
        activateSaveButton();
    });

    function activateSaveButton() {
        $('#saveButton').on('click', function (e) {
            e.preventDefault();
            var self = this;

            SYS.showLoadingDialog();
            $.ajax({
                url:'/api/v1/depot',
                method:'POST',
                contentType:'application/json',
                dataType:'json',
                data:JSON.stringify({data:data}),
                success:function (msg) {
                    if (msg.result == 'true') {
                        SYS.showMessage('Изменения сохранены');
                        SYS.hideLoadingDialog();
                    } else {
                        SYS.showMessage('Ошибка сохранения');
                        SYS.hideLoadingDialog();
                    }
                },
                error:function (msg) {
                    SYS.hideLoadingDialog();
                    SYS.handleAjaxError();
                }
            });
        });
    }


    var data = [
        {index:'', article: '', name:'', count:'', hold_count:''},
    ];

    function loadData() {
        SYS.showLoadingDialog();
        $.ajax({
            url:'/api/v1/depot',
            method:'GET',
            contentType:'application/json',
            dataType:'json',
            success:function (msg) {
                data.length = 0;
                for (var i = 0; i < msg.data.length; i++) {
                    data.push(
                        {index:msg.data[i].index,
                            article: msg.data[i].article,
                            name:msg.data[i].name,
                            count:msg.data[i].count,
                            hold_count:msg.data[i].hold_count
                        });
                }
                $("#dataTable").handsontable('render');
                SYS.hideLoadingDialog();
            },
            error:function (msg) {
                SYS.hideLoadingDialog();
                SYS.handleAjaxError();
            }
        });

    }

    function drawTable() {
        var container = $("#dataTable");
        container.handsontable({
            data:data,
            colHeaders:["№", "Артикля", "Наименование", "На складе", "Зарезервировано"],

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
                if (col == 0 || col == 1 || col == 2) {
                    cellProperties.readOnly = true
                }
                return cellProperties;
            }
        });
    }

})();