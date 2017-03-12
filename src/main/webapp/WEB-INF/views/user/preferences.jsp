<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">
    <b>Совпадения по типу, стилю и эпохе</b><br>
    <c:forEach var="ф" items="${byTypeAndStyleAndEpoch}">
        id: ${a.id}, name: ${a.name}<br>
    </c:forEach>
    <c:if test="${fn:length(byTypeAndStyleAndEpoch) == 0}">
        - ничего не найдено -<br>
    </c:if>
    <br>
    <b>Совпадения по типу и стилю</b><br>
    <c:forEach var="b" items="${byTypeAndStyle}">
        id: ${b.id}, name: ${b.name}<br>
    </c:forEach>
    <c:if test="${fn:length(byTypeAndStyle) == 0}">
        - ничего не найдено -<br>
    </c:if>
    <br>
    <b>Совпадения по типу</b><br>
    <c:forEach var="c" items="${byType}">
        id: ${c.id}, name: ${c.name}<br>
    </c:forEach>
    <c:if test="${fn:length(byType) == 0}">
        - ничего не найдено -<br>
    </c:if>
</div>