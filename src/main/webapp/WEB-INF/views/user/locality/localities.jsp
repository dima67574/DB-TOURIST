<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">
    <script type="text/JavaScript">
        $(document).ready(function () {
            $("#filter").keyup(function () {
                var filter = $(this).val(), count = 0;

                $(".l-name").each(function () {

                    // If the list item does not contain the text phrase fade it out
                    if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                        $(this).parent().hide();
                    } else {
                        $(this).parent().show();
                        count++;
                    }
                });

                var numberItems = count;
                if(filter.length > 0) {
                    $("#filter-count").text(count > 0 ? "Найдено населенных пунктов: " + count : 'Ничего не найдено');
                } else {
                    $("#filter-count").text('');
                }
            });
        });
    </script>
    <input type="text" class="form-control" id="filter" placeholder="Поиск"
           style="width: 50%;display: inline-block;"/>
    <span id="filter-count" style="margin-left: 10px;color: #717171;"></span>

    <div class="list-group panel" style="margin-top:20px">
    <c:forEach var="l" items="${localities}">
        <a class="list-group-item col-xs-4" href="/locality/${l.id}" class="l-name" style="border: none;">${l.name}</a>
    </c:forEach>
    </div>
    <c:if test="${fn:length(localities) == 0}">
        <div class="no-info">
            Нет населенных пунктов
        </div>
    </c:if>
</div>