<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
    var table;
    $(function() {
        $.extend($.fn.dataTable.defaults, {
            autoWidth: false,
            responsive: true,
            dom: '<"datatable-header"fl><"datatable-scroll-wrapper"t><"datatable-footer"ip>',
            language: datable_russian
        });


        table = $('#usersTable').dataTable({
            dom: "Bfrtip",
            "order": [[ 0, "asc" ]],
            buttons: [
                <c:if test="${empty childs}">
                    {
                        text: 'Создать объект',
                        className: 'btn btn-primary',
                        action: function(e, dt, node, config) {
                            window.location.href = "/admin/object/add"
                        }
                    },
                </c:if>
                <c:if test="${!empty childs}">
                    {
                        text: 'К списку объектов',
                        className: 'btn btn-default',
                        action: function(e, dt, node, config) {
                            window.location.href = "/admin/object"
                        }
                    }
                </c:if>
            ],
            columnDefs: [{
                orderable: false,
                width: '30px',
                targets: [ 6 ]
            }]
        });

        $('#remove_modal').on('show.bs.modal', function(e) {
            var id = $(e.relatedTarget).data('id');
            $(this).find(".remove-btn").attr("onclick", "dataTables.removeRow('usersTable', '/admin/object/delete', "+id+", ['message-area', 'Объект успешно удален', 'success']);");
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
                    <th>Эпохи</th>
                    <th>Типы</th>
                    <th>Стили</th>
                    <th>Населенный пункт</th>
                    <th>Добавил</th>
                    <th class="text-center">Действия</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty objects}">
                    <c:forEach var="o" items="${objects}">
                        <tr id="row${o.id}">
                            <td>${o.name}</td>
                            <td>
                                <c:forEach items="${o.epochList}" var="epoch" varStatus="i">
                                    ${epoch.name} (${epoch.startYear} - ${epoch.finishYear})${(fn:length(o.epochList) - 1) > i.index ? ',' : ''}
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach items="${o.typeList}" var="type" varStatus="i">
                                    ${type.name}${(fn:length(o.typeList) - 1) > i.index ? ',' : ''}
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach items="${o.styleList}" var="style" varStatus="i">
                                    ${style.name}${(fn:length(o.styleList) - 1) > i.index ? ',' : ''}
                                </c:forEach>
                            </td>
                            <td>${o.locality.name}</td>
                            <td>${o.author.fio}</td>
                            <td class="text-center row-actions">
                                <div class="dropdown">
                                    <a href="#" class="dropdown dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-cog"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="/admin/object/photo/${o.id}">Перейти в фотоальбом</a></li>
                                        <li><a href="/admin/object/childs/${o.id}">Перейти к дочерним объектам</a></li>
                                        <li><a href="/admin/object/edit/${o.id}">Редактировать</a></li>
                                        <li><a href="javascript:void(0);" data-toggle="modal" data-target="#remove_modal" class="remove-lnk" data-id="${o.id}">Удалить</a></li>
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
                Вы действительно хотите удалить этот объект?
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary remove-btn" data-dismiss="modal">Удалить</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
            </div>
        </div>
    </div>
</div>
</div>