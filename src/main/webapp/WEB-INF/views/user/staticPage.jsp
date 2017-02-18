<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<div class="row" style="${isAnonymous ? 'margin-top:30px' : ''}">
    <div class="col-lg-12">
        <div class="card-box">
            <h4 class="m-t-0 header-title"><b>${!empty page ? page.title : "Страница не найдена"}</b></h4>
            <br/>
            <div class="panel-body">
                <c:if test="${!empty page}">${page.text}</c:if>
                <c:if test="${empty page}">
                    <div class="alert alert-danger alert-styled-left alert-bordered" style="margin-bottom:0px;">
                        Запрашиваемая страница не существует
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<c:if test="${isAnonymous}">
    <div class="row">
        <div class="col-sm-12 text-center">
            <p>
                <a href="/" class="text-primary m-l-5"><i class="glyphicon glyphicon-circle-arrow-left"></i> <b>На главную</b></a>
            </p>
        </div>
    </div>
</c:if>