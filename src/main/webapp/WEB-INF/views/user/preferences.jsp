<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">
    <div class="row">
        <c:forEach var="b" items="${objects}" varStatus="i">
            <div class="col-md-4 portfolio-item">
                <a href="/object/${b.id}">
                    <img class="img-responsive" src="<c:if test="${!empty b.cover.file}">/photo?name=${b.cover.file}</c:if><c:if test="${empty b.cover.file}">/resources/images/noimage.jpg</c:if>" style="width:700px;height: 250px;">
                </a>
                <h3>
                    <a href="/object/${b.id}">${b.name}</a>
                </h3>
                <p><a href="/locality/${b.locality.id}">${b.locality.name}</a></p>
            </div>
        </c:forEach>
    </div>
</div>