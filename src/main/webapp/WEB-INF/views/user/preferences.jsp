<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${fn:length(objects) == 0}">
    <div class="no-info">
        Вы не указали свои предпочтения, укажите их в <a href="/settings">настройках</a>
    </div>
</c:if>
<div class="col-md-12">
    <div class="row">
        <c:forEach var="b" items="${objects}" varStatus="i">
            <div class="col-md-4 portfolio-item">
                <a href="/object/${b.id}">
                    <img class="img-responsive" src="<c:if test="${!empty b.cover.file}">/photo?name=${b.cover.file}</c:if><c:if test="${empty b.cover.file}">/resources/images/noimage.jpg</c:if>">
                </a>
                <h5>
                    <a href="/object/${b.id}"><b>${b.name}</b></a>
                </h5>
                <p><a href="/locality/${b.locality.id}">${b.locality.name}</a></p>
            </div>
        </c:forEach>
    </div>
</div>