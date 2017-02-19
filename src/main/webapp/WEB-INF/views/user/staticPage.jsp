<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="col-lg-12">
    <c:if test="${!empty staticPage}">${staticPage.text}</c:if>
    <c:if test="${empty staticPage}">
        <div class="alert alert-danger alert-styled-left alert-bordered">
            Запрашиваемая страница не существует
        </div>
    </c:if>
</div>