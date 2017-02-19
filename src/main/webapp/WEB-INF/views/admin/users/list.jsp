<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    var table;
    $(function() {
        table = $('#usersTable').dataTable({
            dom: "frtip",
            "order": [[ 0, "desc" ]],
            columnDefs: [{
                orderable: false,
                width: '30px',
                targets: [ 6 ]
            }]
        });

        $('#remove_modal').on('show.bs.modal', function(e) {
            var id = $(e.relatedTarget).data('id');
            $(this).find(".remove-btn").attr("onclick", "dataTables.removeRow('usersTable', '/admin/users/delete', "+id+", ['message-area', 'Пользователь успешно удален', 'success']);");
        });
    });

    function activate(id) {
        $.post("/admin/users/activate", {id: id}, function (d) {
            if(d) {
                var t = $('#usersTable').DataTable();
                var rowId = table.fnGetPosition(document.getElementById("row"+id));

                var colId = 5;
                var content = getColHtml(t, rowId, colId);
                content.find('.user-status a').html('Заблокировать').attr('onclick', 'lockAccount('+id+')');
                updateColHtml(t, rowId, colId, content);

                colId = 4;
                content = getColHtml(t, rowId, colId);
                content.removeClass('label-inverse').addClass('label-success').html('Активен');
                updateColHtml(t, rowId, colId, content);

            } else {
                message('message-area', 'Неизвестная ошибка', 'danger');
            }
        });
    }

    function lockAccount(id) {
        $.post("/admin/users/lock", {id: id}, function (d) {
            if(d) {
                var t = $('#usersTable').DataTable();
                var rowId = table.fnGetPosition(document.getElementById("row"+id));

                var colId = 6;
                var content = getColHtml(t, rowId, colId);
                content.find('.user-status a').html('Разблокировать').attr('onclick', 'unlockAccount('+id+')');
                updateColHtml(t, rowId, colId, content);

                colId = 5;
                content = getColHtml(t, rowId, colId);
                content.removeClass('label-success').addClass('label-danger').html('Заблокирован');
                updateColHtml(t, rowId, colId, content);

            } else {
                message('message-area', 'Неизвестная ошибка', 'danger');
            }
        });
    }

    function unlockAccount(id) {
        $.post("/admin/users/unlock", {id: id}, function (d) {
            if(d) {
                var t = $('#usersTable').DataTable();
                var rowId = table.fnGetPosition(document.getElementById("row"+id));

                var colId = 6;
                var content = getColHtml(t, rowId, colId);
                content.find('.user-status a').html('Заблокировать').attr('onclick', 'lockAccount('+id+')');
                updateColHtml(t, rowId, colId, content);

                colId = 5;
                content = getColHtml(t, rowId, colId);
                content.removeClass('label-danger').addClass('label-success').html('Активен');
                updateColHtml(t, rowId, colId, content);
            } else {
                message('message-area', 'Неизвестная ошибка', 'danger');
            }
        });
    }
</script>
<div class="col-md-12">
            <div id="message-area">
                <c:if test="${!empty success}">
                    <div class="msg-wrapper alert alert-success alert-styled-left alert-arrow-left alert-bordered">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Закрыть</span></button>
                            ${success}
                    </div>
                </c:if>
            </div>
            <table id="usersTable" class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>№</th>
                    <th>ФИО</th>
                    <th>Логин</th>
                    <th>Email</th>
                    <th>Роль</th>
                    <th>Статус</th>
                    <th class="text-center">Действия</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty users}">
                    <c:forEach var="u" items="${users}">
                        <tr id="row${u.id}">
                            <td>${u.id}</td>
                            <td>${u.fio}</td>
                            <td>${u.login}</td>
                            <td>${u.email}</td>
                            <td>${u.role.name == 'ROLE_ADMIN' ? 'Администратор' : 'Пользователь'}</td>
                            <td>
                                <c:if test="${u.banned}">
                                    <span class="label label-danger">Заблокирован</span>
                                </c:if>
                                <c:if test="${!u.banned}">
                                    <span class="label label-success">Активен</span>
                                </c:if>
                            </td>
                            <td class="text-center row-actions">
                                <div class="dropdown">
                                    <a href="#" class="dropdown dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-cog"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="/admin/users/edit/${u.id}">Редактировать</a></li>
                                        <c:if test="${u.id != user.id}">
                                            <c:if test="${!u.banned}">
                                                <li class="user-status"><a href="javascript:void(0);" onclick="lockAccount(${u.id})">Заблокировать</a></li>
                                            </c:if>
                                            <c:if test="${u.banned}">
                                                <li class="user-status"><a href="javascript:void(0);" onclick="unlockAccount(${u.id})">Разблокировать</a></li>
                                            </c:if>
                                            <li><a href="javascript:void(0);" data-toggle="modal" data-target="#remove_modal" class="remove-lnk" data-id="${u.id}">Удалить</a></li>
                                        </c:if>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>

<div id="remove_modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title">Подтверждение удаления</h5>
            </div>

            <div class="modal-body">
                Вы действительно хотите удалить этого пользователя?
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary remove-btn" data-dismiss="modal">Удалить</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
            </div>
        </div>
    </div>
</div>
</div>