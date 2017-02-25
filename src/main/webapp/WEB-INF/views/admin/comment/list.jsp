<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
    var table, table2;
    $(function() {
        $("a[data-toggle=\"tab\"]").on("shown.bs.tab", function (e) {
            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().responsive.recalc();
        });

        $.extend($.fn.dataTable.defaults, {
            autoWidth: false,
            responsive: true,
            dom: '<"datatable-header"fl><"datatable-scroll-wrapper"t><"datatable-footer"ip>',
            language: datable_russian
        });

        table = $('#usersTable').dataTable({
            dom: "frtip",
            "order": [[ 0, "desc" ]],
            columnDefs: [{
                orderable: false,
                width: '30px',
                targets: [ 4 ]
            }]
        });

        table2 = $('#usersTable2').dataTable({
            dom: "frtip",
            "order": [[ 0, "desc" ]],
            columnDefs: [{
                orderable: false,
                width: '30px',
                targets: [ 5 ]
            }]
        });

        $('#remove_modal').on('show.bs.modal', function(e) {
            var id = $(e.relatedTarget).data('id');
            var type = $(e.relatedTarget).data('type');
            $(this).find(".remove-btn").attr("onclick", "remove(" + id + ", " + type + ");");
     });

    });

    function remove(id, type) {
        $.post("/admin/comment/delete", {id: id}, function () {
            var aPos;
            if (type == 0) {
                aPos = table.fnGetPosition(document.getElementById("row" + id));
                table.fnDeleteRow(aPos);
            } else {
                aPos = table2.fnGetPosition(document.getElementById("row" + id));
                table2.fnDeleteRow(aPos);
            }
            message('message-area', 'Отзыв успешно удален', 'success');
        });
    }

    function showComment(id) {
        $.get('/admin/comment/show', {id: id}, function (d) {
            var el = $('#show_modal').find('.modal-body');
            el.html(d);
            $('#show_modal').modal('show');
        });
    }

    function check(id) {
        $('#checkId').val(id);
        $('#checkForm').submit();
    }
</script>
<form id="checkForm" method="POST" action="/admin/comment/check">
    <input type="hidden" name="id" id="checkId" value="">
</form>
<div class="col-md-12">
    <div id="message-area">
        <c:if test="${!empty success}">
            <div class="msg-wrapper alert alert-success alert-styled-left alert-arrow-left alert-bordered">
                <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Закрыть</span></button>
                    ${success}
            </div>
        </c:if>
    </div>

    <ul class="nav nav-tabs nav-tabs-highlight tabpanel">
        <li class="active">
            <a href="#t1" data-toggle="tab">
                Не проверенные <span class="label label-primary">${fn:length(notChecked)}</span>
            </a>
        </li>
        <li>
            <a href="#t2" data-toggle="tab">Проверенные <span
                    class="label label-success">${fn:length(checked)}</span>
            </a>
        </li>
    </ul>

    <div class="tab-content" style="margin-top:25px">
        <div class="tab-pane active" id="t1">
            <table id="usersTable" class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Дата</th>
                    <th>Объект</th>
                    <th>Автор</th>
                    <th>Оценка</th>
                    <th class="text-center">Действия</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty notChecked}">
                    <c:forEach var="p" items="${notChecked}">
                        <tr id="row${p.id}">
                            <fmt:formatDate value="${p.date}" pattern="dd.MM.yyyy в HH:mm:ss" var="createDate" />
                            <td>${createDate}</td>
                            <td>${p.object.name}</td>
                            <td>${p.user.fio}</td>
                            <td>
                                <c:forEach begin="1" end="${p.mark}">
                                    <i class="fa fa-star" style="color:#f39c15;"></i>
                                </c:forEach>
                            </td>
                            <td class="text-center row-actions">
                                <div class="dropdown">
                                    <a href="#" class="dropdown dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-cog"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="#" onclick="showComment(${p.id});">Показать текст отзыва</a></li>
                                        <li><a href="#" onclick="check(${p.id});">Одобрить</a></li>
                                        <li><a href="javascript:void(0);" data-toggle="modal" data-type="0" data-target="#remove_modal" class="remove-lnk" data-id="${p.id}">Удалить</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
        <div class="tab-pane" id="t2">
            <table id="usersTable2" class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Дата</th>
                    <th>Объект</th>
                    <th>Автор</th>
                    <th>Оценка</th>
                    <th>Одобрил</th>
                    <th class="text-center">Действия</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty checked}">
                    <c:forEach var="p" items="${checked}">
                        <tr id="row${p.id}">
                            <fmt:formatDate value="${p.date}" pattern="dd.MM.yyyy в HH:mm:ss" var="createDate" />
                            <td>${createDate}</td>
                            <td>${p.object.name}</td>
                            <td>${p.user.fio}</td>
                            <td>
                                <c:forEach begin="1" end="${p.mark}">
                                    <i class="fa fa-star" style="color:#f39c15;"></i>
                                </c:forEach>
                            </td>
                            <td>${p.moderator.fio}</td>
                            <td class="text-center row-actions">
                                <div class="dropdown">
                                    <a href="#" class="dropdown dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-cog"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="#" onclick="showComment(${p.id});">Показать текст отзыва</a></li>
                                        <li><a href="javascript:void(0);" data-toggle="modal" data-type="1"data-target="#remove_modal" class="remove-lnk" data-id="${p.id}">Удалить</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

<div id="remove_modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title">Подтверждение удаления</h5>
            </div>

            <div class="modal-body">
                Вы действительно хотите удалить этот отзыв?
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary remove-btn" data-dismiss="modal">Удалить</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
            </div>
        </div>
    </div>
</div>
<div id="show_modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title">Текст отзыва</h5>
            </div>

            <div class="modal-body">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>
</div>