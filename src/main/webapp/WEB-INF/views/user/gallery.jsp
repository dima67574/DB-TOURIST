<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/vendor/bootpag/jquery.bootpag.min.js"></script>
<script>
    $(function () {
        $(".fancybox").fancybox({
            openEffect: "none",
            closeEffect: "none"
        });
    });
</script>

<link rel="stylesheet" href="/resources/vendor/fancybox/jquery.fancybox.min.css" media="screen">
<script src="/resources/vendor/fancybox/jquery.fancybox.min.js"></script>
<c:if test="${fn:length(object.photos) == 0}">
    <div class="no-info">
        Нет фотографий
    </div>
</c:if>
<div class="col-md-12">
    <div class="row">
        <c:forEach var="p" items="${object.photos}" varStatus="i">
            <c:set var="photosCount" scope="page" value="16"/>
            <c:set var="totalPages" scope="page" value="${fn:length(object.photos) / photosCount}"/>
            <fmt:formatNumber var="page" value="${(i.index / photosCount) + 1}" maxFractionDigits="0"/>
            <c:set var="newPage" scope="page" value="${i.index % photosCount}"/>
            <c:if test="${newPage == 0}">
                <div id="page${page}" style="${i.index > 0 ? 'display:none' : ''}" class="photo-page">
            </c:if>

            <div class="col-md-4 portfolio-item">
                <a class="thumbnail photo-card fancybox" rel="ligthbox" href="/photo?name=${p.file}" style="margin-bottom: 0px;">
                    <img class="img-responsive" src="/photo?name=${p.file}">
                </a>
            </div>
            <c:if test="${newPage == photosCount - 1 || fn:length(object.photos) == (i.index + 1)}">
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