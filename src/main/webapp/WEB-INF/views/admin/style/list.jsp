<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    var table;
    $(function() {
        table = $('#usersTable').dataTable({
            dom: "Bfrtip",
            "order": [[ 0, "asc" ]],
            buttons: [
                {
                    text: 'Создать стиль',
                    className: 'btn btn-primary',
                    action: function(e, dt, node, config) {
                        window.location.href = "/admin/style/add"
                    }
                }
            ],
            columnDefs: [{
                orderable: false,
                width: '30px',
                targets: [ 2 ]
            }]
        });

        $('#remove_modal').on('show.bs.modal', function(e) {
            var id = $(e.relatedTarget).data('id');
            $(this).find(".remove-btn").attr("onclick", "dataTables.removeRow('usersTable', '/admin/style/delete', "+id+", ['message-area', 'Стиль успешно удален', 'success']);");
        });
    });

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
                    <th>Название</th>
                    <th>Описание</th>
                    <th class="text-center">Действия</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty styles}">
                    <c:forEach var="p" items="${styles}">
                        <tr id="row${p.id}">
                            <td>${p.name}</td>
                            <td>${p.description}</td>
                            <td class="text-center row-actions">
                                <div class="dropdown">
                                    <a href="#" class="dropdown dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-cog"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="/admin/style/photo/${p.id}">Перейти в фотоальбом</a></li>
                                        <li><a href="/admin/style/edit/${p.id}">Редактировать</a></li>
                                        <li><a href="javascript:void(0);" data-toggle="modal" data-target="#remove_modal" class="remove-lnk" data-id="${p.id}">Удалить</a></li>
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
                Вы действительно хотите удалить этот стиль?
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary remove-btn" data-dismiss="modal">Удалить</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
            </div>
        </div>
    </div>
</div>
</div>