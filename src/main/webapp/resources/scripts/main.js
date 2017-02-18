function captch_refresh(el) {
    var src = $(el).attr('src');
    if (src) {
        var queryPos = src.indexOf('?');
        if (queryPos != -1) {
            src = src.substring(0, queryPos);
        }
    } else {
        src = "/captcha";
    }
    $(el).attr('src', src + '?' + Math.random());
    return false;
}

$(function () {
    $.extend($.fn.dataTable.defaults, {
        language: datable_russian
    });
});

var datable_russian = {
    "processing": "Подождите...",
    "search": "<span>Поиск:</span> _INPUT_",
    "lengthMenu": "<span>Показать:</span> _MENU_",
    "info": "Записи с _START_ до _END_ из _TOTAL_ записей",
    "infoEmpty": "Записи с 0 до 0 из 0 записей",
    "infoFiltered": "(отфильтровано из _MAX_ записей)",
    "infoPostFix": "",
    "loadingRecords": "Загрузка записей...",
    "zeroRecords": "Записи отсутствуют.",
    "emptyTable": "В таблице отсутствуют данные",
    "paginate": {
        "first": "Первая",
        "previous": "Предыдущая",
        "next": "Следующая",
        "last": "Последняя"
    },
    "aria": {
        "sortAscending": ": активировать для сортировки столбца по возрастанию",
        "sortDescending": ": активировать для сортировки столбца по убыванию"
    }
};

function message(el, msg, classes) {
    var txt = '<div class="alert alert-' + classes + ' ' +
        'alert-styled-left alert-arrow-left alert-bordered"> <button type="button" class="close" data-dismiss="alert">' +
        '<span>×</span><span class="sr-only">Закрыть</span></button> <span class="alrt-msg">' + msg + '</span></div>';
    $('#' + el).html(txt);
    $(window).scrollTop(0);
}

var settings = {
    savePreferences: function () {
        var form = $('#preferencesForm');
        if (form.parsley().isValid()) {
            var epoches = $('#epoches').val();
            var types = $('#types').val();
            var styles = $('#styles').val();
            $.post('/settings/savePreferences', {epoches: epoches, types: types, styles: styles}, function (response) {
                if(response) {
                    message('home-2-msg', 'Предпочтения успешно сохранены', 'success');
                } else {
                    message('home-2-msg', 'Произошла ошибка', 'danger');
                }
            });
        }
    },
    saveEmail: function () {
        var form = $('#changeEmailForm');
        form.parsley().validate();
        if (form.parsley().isValid()) {
            var email = $('#email').val();
            $.post('/settings/saveEmail', {email: email}, function (response) {
                if (response) {
                    $('#currentEmail').html(email);
                    $('#email').val('');
                    message('email-msg', 'Email успешно изменен', 'success');
                } else {
                    message('email-msg', 'Произошла ошибка', 'danger');
                }
            });
        }
    },
    changePassword: function () {
        var form = $('#changePasswordForm');
        form.parsley().validate();
        if (form.parsley().isValid()) {
            var oldPassword = $('#oldPassword');
            var password1 = $('#password1');
            var password2 = $('#password2');
            $.post('/settings/changePassword', {oldPassword: oldPassword.val(), password: password1.val()}, function (response) {
                if (response.status == 0) {
                    oldPassword.val('');
                    password1.val('');
                    password2.val('');
                    message('password-msg', 'Пароль успешно изменен', 'success');
                } else if(response.status == 1){
                    message('password-msg', 'Старый пароль введен не верно', 'danger');
                } else if(response.status == 2){
                    message('password-msg', 'Старый и новый пароли совпадают, придумайте новый пароль', 'danger');
                } else {
                    message('password-msg', 'Произошла ошибка', 'danger');
                }
            });
        }
    }
}

var dataTables = {
    removeRow: function (table, url, rowId, msg) {
        $.post(url, {id: rowId}, function () {
            var t = $('#'+table).dataTable();
            var r = document.getElementById("row"+rowId);
            var aPos = t.fnGetPosition(r);
            t.fnDeleteRow(aPos);
            message(msg[0], msg[1], msg[2]);
        });
    }
}

function getColHtml(t, rowId, colId) {
    var wrapper= document.createElement('div');
    wrapper.innerHTML= t.cell( rowId, colId ).data();
    return $(wrapper.firstChild);
}

function updateColHtml(t, rowId, colId, content) {
    t.cell( rowId, colId ).data(content.prop('outerHTML')).draw();
}

function updateColText(t, rowId, colId, content) {
    t.cell( rowId, colId ).data(content).draw();
}
