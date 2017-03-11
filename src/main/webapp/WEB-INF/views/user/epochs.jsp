<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-md-12">
<c:forEach var="e" items="${epochs}">
    <div class="row">
        <div class="col-md-5">
            <a href="/epoch/${e.id}/gallery">
                <img class="img-responsive" src="<c:if test="${!empty e.cover.file}">/photo?name=${e.cover.file}</c:if><c:if test="${empty e.cover.file}">/resources/images/noimage.jpg</c:if>" alt="">
            </a>
        </div>
        <div class="col-md-6">
            <h3>${e.name}</h3>
            <h4>${e.startYear} - ${e.finishYear}</h4>
            <p>${e.description}</p>
            <a class="btn btn-primary" href="/epoch/${e.id}/objects">Показать все объекты <span class="glyphicon glyphicon-chevron-right"></span></a>
        </div>
    </div>
    <hr>
</c:forEach>
</div>