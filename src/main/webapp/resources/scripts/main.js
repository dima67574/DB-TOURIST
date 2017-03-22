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

var settings = {
    savePreferences: function () {
        var form = $('#preferencesForm');
        if (form.parsley().isValid()) {
            var epochs = $('#epochs').val();
            var types = $('#types').val();
            var styles = $('#styles').val();
            $.post('/settings/savePreferences', {epochs: epochs, types: types, styles: styles}, function (response) {
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

function message(el, msg, classes, noTop, noClosed) {
    var txt = '<div class="alert alert-' + classes + ' ' +
        'alert-styled-left alert-arrow-left alert-bordered">';
    if(noClosed == undefined) {
        txt += ' <button type="button" class="close" data-dismiss="alert">' +
            '<span>×</span><span class="sr-only">Закрыть</span></button>';
    }
        txt += ' <span class="alrt-msg">' + msg + '</span></div>';
    $('#' + el).html(txt);
    if(noTop === undefined) {
        $(window).scrollTop(0);
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

var totalFileLength, totalUploaded, fileCount, filesUploaded;
function onUploadComplete(url, objectId) {
    totalUploaded += document.getElementById('files').files[filesUploaded].size;
    filesUploaded++;
    if (filesUploaded < fileCount) {
        uploadNext(url, objectId);
    } else {
        var bar = document.getElementById('bar');
        bar.style.width = '100%';
        bar.innerHTML = '100%';
        setTimeout(function () {
            location.reload();
        }, 500);
    }
}

function onFileSelect(e) {
    var files = e.target.files;
    var output = [];
    fileCount = files.length;
    totalFileLength = 0;
    for (var i = 0; i < fileCount; i++) {
        var file = files[i];
        output.push(file.name, ' (', file.size, ' байт)');
        output.push('<br/>');
        totalFileLength += file.size;
    }
    document.getElementById('selectedFiles').innerHTML = output.join('');
    $('#uploadButton').prop("disabled",fileCount <= 0);
}

function onUploadProgress(e) {
    if (e.lengthComputable) {
        var percentComplete = parseInt((e.loaded + totalUploaded) * 100 / totalFileLength);
        var bar = document.getElementById('bar');
        bar.style.width = percentComplete + '%';
        bar.innerHTML = percentComplete + ' %';
    }
}

function onUploadFailed(e) {
    alert("Ошибка загрузки");
}

function uploadNext(url, objectId) {
    var xhr = new XMLHttpRequest();
    var fd = new FormData();
    var file = document.getElementById('files').files[filesUploaded];
    fd.append("multipartFile", file);
    fd.append("objectId", objectId);
    xhr.upload.addEventListener("progress", onUploadProgress, false);
    xhr.addEventListener("load", function () {
        onUploadComplete(url, objectId);
    }, false);
    xhr.addEventListener("error", onUploadFailed, false);
    xhr.open("POST", url);
    xhr.send(fd);
}

function startUpload(url, objectId) {
    totalUploaded = filesUploaded = 0;
    uploadNext(url, objectId);
}

function deletePicture(photo) {
    $.post("/admin/photo/delete", {photo: photo}, function (data) {
        if(data) {
            location.reload();
        }
    });
}


var simpleSort = function(parent, child, hiddenClass) {
    this.stashBox = $(parent);
    this.stashItems = this.stashBox.children(child);
    this.order = ''; // used for external toggle check
    this.hiddenClass = hiddenClass;

    this.sort = function(dataAttribute, order) {

        order = (order === 'asc' || order === 'desc' ? order : 'desc');

        this.order = order;

        this.stashItems.sort( function(a,b) {

            var an = a.getAttribute(dataAttribute);
            var bn = b.getAttribute(dataAttribute);

            if(order === 'desc') {

                if(an > bn) {
                    return 1;
                }
                if(an < bn) {
                    return -1;
                }
                return 0;

            } else if (order === 'asc') {

                if(an < bn) {
                    return 1;
                }
                if(an > bn) {
                    return -1;
                }
                return 0;

            }

        });

        this.stashItems.detach().appendTo(this.stashBox);
    };

    this.filter = function(dataAttribute, filterVal) {

        this.stashItems.each( function() {

            var dataVal = this.getAttribute(dataAttribute).toLowerCase();
            var findVal = filterVal.toLowerCase();

            if( (dataVal.indexOf(findVal)) === -1) {

                if(this.hiddenClass === undefined) {
                    $(this).css('display', 'none');
                } else {
                    $(this).addClass(this.hiddenClass);
                }

            } else {
                undoHide(this);
            }
        });

    };

    this.all = function() {
        this.stashItems.each( function() {
            undoHide(this);
        });
    };

    // private
    undoHide = function(el) {

        if(this.hiddenClass === undefined) {
            $(el).removeAttr('style');
        } else {
            $(el).removeClass(this.hiddenClass);
        }

    }

};