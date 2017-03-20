<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">
    <c:if test="${fn:length(objects) == 0}">
        <div class="no-info">
            Нет достопримечательностей
        </div>
    </c:if>
    <c:forEach var="e" items="${objects}">
        <div class="col-md-6">
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

