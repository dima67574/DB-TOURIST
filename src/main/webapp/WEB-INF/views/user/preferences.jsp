<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/vendor/bootpag/jquery.bootpag.min.js"></script>

<c:if test="${fn:length(objects) == 0}">
    <div class="no-info">
        Вы не указали свои предпочтения, укажите их в <a href="/settings">настройках</a>
    </div>
</c:if>
<div class="col-md-12">
    <div class="row">
        <c:forEach var="b" items="${objects}" varStatus="i">
            <c:set var="objectsCount" scope="page" value="20"/>
            <c:set var="totalPages" scope="page" value="${fn:length(objects) / objectsCount}"/>
            <fmt:formatNumber var="page" value="${(i.index / objectsCount) + 1}" maxFractionDigits="0"/>
            <c:set var="newPage" scope="page" value="${i.index % objectsCount}"/>
            <c:if test="${newPage == 0}">
                <div id="page${page}" style="${i.index > 0 ? 'display:none' : ''}" class="photo-page">
            </c:if>

            <div class="col-md-6 portfolio-item">
                <a href="/object/${b.id}">
                    <img class="img-responsive" src="<c:if test="${!empty b.cover.file}">/photo?name=${b.cover.file}</c:if><c:if test="${empty b.cover.file}">/resources/images/noimage.jpg</c:if>">
                </a>
                <h5>
                    <a href="/object/${b.id}"><b>${b.name}</b></a>
                </h5>
                <p><a href="/locality/${b.locality.id}">${b.locality.name}</a></p>
            </div>

            <c:if test="${newPage == objectsCount - 1 || fn:length(objects) == (i.index + 1)}">
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<script>
    $(function () {
        $('#pagination-here').bootpag({
            total: ${(totalPages+(1-(totalPages%1))%1)},
            page: 1,
            leaps: true
        }).on("page", function (event, num) {
            $('.photo-page').hide();
            $('#page' + num).show();
            $(window).scrollTop($(document).height());
        });
    });

</script>
<div class="col-md-12">
    <p id="pagination-here"></p>
</div>