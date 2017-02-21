<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12">
    <c:if test="${!empty staticPage}">${staticPage.text}</c:if>
    <c:if test="${empty staticPage}">
        <div class="alert alert-danger alert-styled-left alert-bordered">
            Запрашиваемая страница не существует
        </div>
    </c:if>
</div>