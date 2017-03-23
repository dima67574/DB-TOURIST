<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/vendor/bootpag/jquery.bootpag.min.js"></script>
<script type="text/JavaScript">
    $(document).ready(function () {
        $("#filter").keyup(function () {
            var filter = $(this).val(), count = 0;

            $(".object-title").each(function () {

                // If the list item does not contain the text phrase fade it out
                if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                    $(this).parent().parent().hide();
                } else {
                    $(this).parent().parent().show();
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
        var rateOrder = new simpleSort('.ss-box', 'div');
        rateOrder.order = 'asc';
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

        var regionOrder = new simpleSort('.ss-box', 'div');
        regionOrder.order = 'desc';
        $('#ss-region').on('click', function() {
            $('.sort-icon').remove();
            if(regionOrder.order === 'desc') {
                regionOrder.sort('data-region', 'asc');
                $(this).html('по населенному пункту <i class="sort-icon glyphicon glyphicon-chevron-down"></i>');
            } else {
                regionOrder.sort('data-region', 'desc');
                $(this).html('по населенному пункту <i class="sort-icon glyphicon glyphicon-chevron-up"></i>');
            }
        });
    });
</script>
<c:if test="${fn:length(objects) == 0}">
    <div class="no-info">
        В Топ-50 пока пусто
    </div>
</c:if>
<div class="col-md-12">
    <div class="row">
        <c:if test="${fn:length(objects) == 0}">
            <div class="no-info">
                Нет достопримечательностей
            </div>
        </c:if>
        <c:if test="${fn:length(objects) > 0}">
        <div class="col-md-12">
            <div style="margin-bottom: 20px;">
                <input type="text" class="form-control" id="filter" placeholder="Поиск"
                       style="width: 50%;display: inline-block;"/>
                <span id="filter-count" style="margin-left: 10px;color: #717171;"></span>
            </div>
            <div style="margin-bottom: 20px;">
                Упорядочить: <button class="btn btn-default" id="ss-name">по названию</button>
                <button class="btn btn-default" id="ss-rate">по рейтингу  <i class="sort-icon glyphicon glyphicon-chevron-down"></i></button>
                <button class="btn btn-default" id="ss-region">по населенному пункту</button>
            </div>
        </div>
        </c:if>
        <div class="ss-box">
        <c:forEach var="b" items="${objects}" varStatus="i">
            <div class="col-md-6 portfolio-item" data-name="${b.name}" data-rate="${b.rating}" data-region="${b.locality.name}">
                <a href="/object/${b.id}">
                    <img class="img-responsive"
                         src="<c:if test="${!empty b.cover.file}">/photo?name=${b.cover.file}</c:if><c:if test="${empty b.cover.file}">/resources/images/noimage.jpg</c:if>">
                </a>
                <h5>
                    <a href="/object/${b.id}" class="object-title"><b>${b.name}</b></a>
                </h5>
                <p><a href="/locality/${b.locality.id}">${b.locality.name}</a></p>
                <p>
                    <span class="star-rating">
                        <c:forEach begin="0" end="4" varStatus="i">
                            <c:set var="num" value="${i.index + 1}"/>
                            <c:if test="${b.rating > num && b.rating < (num + 1)}">
                                <i class="fa fa-star-half-full" style="color:#f39c15;"></i>
                            </c:if>
                            <c:if test="${(b.rating > num && b.rating >= (num + 1)) || b.rating == num}">
                                <i class="fa fa-star" style="color:#f39c15;"></i>
                            </c:if>
                            <c:if test="${b.rating < num}">
                                <i class="fa fa-star-o" style="color:#f39c15;"></i>
                            </c:if>
                        </c:forEach>
                    </span>
                </p>
            </div>

        </c:forEach>
        </div>
    </div>
</div>