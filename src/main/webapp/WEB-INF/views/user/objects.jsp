<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">
    <c:forEach var="e" items="${objects}">
        <div class="col-md-6">
            <div class="row">
                <div class="col-lg-6">
                    <img style="width:100%;"
                         src="<c:if test="${!empty e.cover.file}">/photo?name=${e.cover.file}</c:if><c:if test="${empty e.cover.file}">/resources/images/noimage.jpg</c:if>"
                         alt="">
                </div>
                <div>
                    <h4 class="object-title"><a href="/object/${e.id}">${e.name}</a></h4>
                    <p>
                        <c:forEach var="y" items="${e.yearList}" varStatus="i">
                            ${y.year}${(fn:length(e.yearList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </p>
                    <p>
                        <c:forEach var="t" items="${e.typeList}" varStatus="i">
                            <a href="/type/${t.id}/objects">${t.name}</a>${(fn:length(e.typeList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </p>
                    <p>
                        <c:forEach var="s" items="${e.styleList}" varStatus="i">
                            <a href="/style/${s.id}/objects">${s.name}</a>${(fn:length(e.styleList) - 1) > i.index ? ',' : ''}
                        </c:forEach>
                    </p>
                    <p>Оценка:</p>
                    <p>${e.address}</p>
                    <p>
                        Координаты: <a href="/map?xCoordinate=${e.xCoordinate}&yCoordinate=${e.yCoordinate}">x:${e.xCoordinate},
                        y:${e.yCoordinate}</a>
                    </p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

