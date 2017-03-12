<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<c:if test="${!empty success}">
    <div class="alert alert-success alert-styled-left alert-arrow-left alert-bordered">
        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span>
        </button>
            ${success}
    </div>
</c:if>
<div class="col-lg-12">
    <c:if test="${isAnonymous}">
    top 20 from top 50 random. slider
    </c:if>
    <c:if test="${!isAnonymous}">
        20 из предпочтений
    </c:if>
</div>