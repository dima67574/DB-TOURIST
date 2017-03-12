<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">
    <script type="text/JavaScript">
        $(document).ready(function () {
            $("#filter").keyup(function () {
                var filter = $(this).val(), count = 0;

                $(".object-title").each(function () {

                    // If the list item does not contain the text phrase fade it out
                    if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                        $(this).parent().parent().parent().hide();
                    } else {
                        $(this).parent().parent().parent().show();
                        count++;
                    }
                });

                var numberItems = count;
                if(filter.length > 0) {
                    $("#filter-count").text(count > 0 ? "Найдено достопримечательностей: " + count : 'Ничего не найдено');
                } else {
                    $("#filter-count").text('');
                }
            });
        });
    </script>
    <div style="margin-bottom: 20px;">
        <input type="text" class="form-control" id="filter" placeholder="Поиск"
               style="width: 50%;display: inline-block;"/>
        <span id="filter-count" style="margin-left: 10px;color: #717171;"></span>
    </div>
    <c:forEach var="e" items="${objects}">
        <div>
            <div class="row">
                <div class="col-md-5">
                    <a href="/object/${e.id}/gallery">
                        <img class="img-responsive"
                             src="<c:if test="${!empty e.cover.file}">/photo?name=${e.cover.file}</c:if><c:if test="${empty e.cover.file}">/resources/images/noimage.jpg</c:if>"
                             alt="">
                    </a>
                </div>
                <div class="col-md-6">
                    <h3 class="object-title"><a href="/object/${e.id}">${e.name}</a></h3>
                    <h4>
                        <c:forEach var="y" items="${e.yearList}" varStatus="i">
                            ${y.year}${(fn:length(e.yearList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </h4>
                    <h4>
                        <c:forEach var="t" items="${e.typeList}" varStatus="i">
                            <a href="/type/${t.id}/objects">${t.name}</a>${(fn:length(e.typeList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </h4>
                    <h4>
                        <c:forEach var="s" items="${e.styleList}" varStatus="i">
                            <a href="/style/${s.id}/objects">${s.name}</a>${(fn:length(e.styleList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </h4>

                    <h4>
                        Оценка:
                    </h4>

                    <h4>
                        ${e.address}
                    </h4>

                    <h4>
                        Координаты: x:${e.xCoordinate}, y:${e.yCoordinate}
                    </h4>


                </div>

            </div>
            <p style="margin-top: 20px">${e.description}</p>
            <hr>
        </div>
    </c:forEach>
</div>