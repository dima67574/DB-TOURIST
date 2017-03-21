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
                if (filter.length > 0) {
                    $("#filter-count").text(count > 0 ? "Найдено достопримечательностей: " + count : 'Ничего не найдено');
                } else {
                    $("#filter-count").text('');
                }
            });

            var nameOrder = new simpleSort('.ss-box', 'div');
            nameOrder.order = 'desc';
            $('#ss-name').on('click', function() {
                $('.sort-icon').remove();
                if(nameOrder.order === 'desc') {
                    nameOrder.sort('data-name', 'asc');
                    $(this).html('по названию <i class="sort-icon glyphicon glyphicon-chevron-down"></i>');
                } else {
                    nameOrder.sort('data-name', 'desc');
                    $(this).html('по названию <i class="sort-icon glyphicon glyphicon-chevron-up"></i>');
                }
            });
            var rateOrder = new simpleSort('.ss-box', 'div');
            rateOrder.order = 'desc';
            $('#ss-rate').on('click', function() {
                $('.sort-icon').remove();
                if(rateOrder.order === 'desc') {
                    rateOrder.sort('data-rate', 'asc');
                    $(this).html('по рейтингу <i class="sort-icon glyphicon glyphicon-chevron-down"></i>');
                } else {
                    rateOrder.sort('data-rate', 'desc');
                    $(this).html('по рейтингу <i class="sort-icon glyphicon glyphicon-chevron-up"></i>');
                }
            });
        });
    </script>
    <c:if test="${fn:length(objects) == 0}">
        <div class="no-info">
            Нет достопримечательностей
        </div>
    </c:if>
    <c:if test="${fn:length(objects) > 0}">
    <div style="margin-bottom: 20px;">
        <input type="text" class="form-control" id="filter" placeholder="Поиск"
               style="width: 50%;display: inline-block;"/>
        <span id="filter-count" style="margin-left: 10px;color: #717171;"></span>
    </div>
    <div style="margin-bottom: 20px;">
        Упорядочить: <button class="btn btn-default" id="ss-name">по названию  <i class="sort-icon glyphicon glyphicon-chevron-up"></i></button> <button class="btn btn-default" id="ss-rate">по рейтингу</button>
    </div>
    </c:if>
    <div class="ss-box">
    <c:forEach var="e" items="${objects}">
        <div class="col-md-6" style="margin-left: -15px;" data-name="${e.name}" data-rate="123">
            <div class="row" style="margin-bottom: 15px;">
                <div class="col-lg-6">
                    <a href="/object/${e.id}">
                    <img style="width:100%;"
                         src="<c:if test="${!empty e.cover.file}">/photo?name=${e.cover.file}</c:if><c:if test="${empty e.cover.file}">/resources/images/noimage.jpg</c:if>"
                         alt="">
                    </a>
                </div>
                <div style="margin-left: 20px">
                    <div class="object-title" style="margin-bottom:3px;margin-top:4px"><a href="/object/${e.id}"><b>${e.name}</b></a></div>
                    <div style="font-size: 13px;margin-bottom:3px">
                        Года: ${fn:length(e.yearList) == 0 ? 'не указаны' : ''}
                        <c:forEach var="y" items="${e.yearList}" varStatus="i">
                            ${y.year}${(fn:length(e.yearList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </div>
                    <div style="font-size: 13px;margin-bottom:3px">
                        Типы: ${fn:length(e.typeList) == 0 ? 'не указаны' : ''}
                        <c:forEach var="t" items="${e.typeList}" varStatus="i">
                            <a href="/type/${t.id}/objects">${t.name}</a>${(fn:length(e.typeList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </div>
                    <div style="font-size: 13px;margin-bottom:3px">
                        Стили: ${fn:length(e.styleList) == 0 ? 'не указаны' : ''}
                        <c:forEach var="s" items="${e.styleList}" varStatus="i">
                            <a href="/style/${s.id}/objects">${s.name}</a>${(fn:length(e.styleList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </div>
                    <div style="font-size: 13px;margin-bottom:3px">Оценка: XXXXX</div>
                    <div style="font-size: 13px;margin-bottom:3px">
                        Адрес: ${empty e.address ? 'не указан' : e.address}
                    </div>
                    <div style="font-size: 13px;">
                        Координаты:
                        <a href="/map?xCoordinate=${e.xCoordinate}&yCoordinate=${e.yCoordinate}">x:${e.xCoordinate},
                        y:${e.yCoordinate}</a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    </div>
</div>

