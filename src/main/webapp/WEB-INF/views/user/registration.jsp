<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="col-sm-4">
<form:form modelAttribute="user" class="form-horizontal m-t-20" action="/registration" method="POST">
    <c:if test="${!empty error}">
        <div class="alert alert-danger alert-styled-left alert-bordered">
            <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
            ${error}
        </div>
    </c:if>
    <spring:bind path="name">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="name" class="form-control" placeholder="Имя"
                            required="required"/>
                <form:errors class="validation-error-label" path="name"/>
            </div>
        </div>
    </spring:bind>
    <spring:bind path="surname">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="surname" class="form-control" placeholder="Фамилия"
                            required="required"/>
                <form:errors class="validation-error-label" path="surname"/>
            </div>
        </div>
    </spring:bind>
    <spring:bind path="patronymic">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="patronymic" class="form-control" placeholder="Отчество"
                            required="required"/>
                <form:errors class="validation-error-label" path="patronymic"/>
            </div>
        </div>
    </spring:bind>
    <spring:bind path="phoneNumber">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="phoneNumber" class="form-control" placeholder="Номер телефона"
                            required="required"/>
                <form:errors class="validation-error-label" path="phoneNumber"/>
            </div>
        </div>
    </spring:bind>
    <spring:bind path="email">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="email" type="email" class="form-control" placeholder="Email"
                            required="required"/>
                <form:errors class="validation-error-label" path="email"/>
            </div>
        </div>
    </spring:bind>
    <spring:bind path="login">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="login" class="form-control" placeholder="Логин" required="required"/>
                <form:errors class="validation-error-label" path="login"/>
            </div>
        </div>
    </spring:bind>
    <spring:bind path="password">
        <div class="form-group ">
            <div class="col-xs-12">
                <form:input path="password" type="password" class="form-control" placeholder="Пароль"
                            required="required"/>
                <form:errors class="validation-error-label" path="password"/>
            </div>
        </div>
    </spring:bind>

    <div class="form-group ">
        <div class="col-xs-12">
            <input name="password2" type="password" value="${user.password}" class="form-control" placeholder="Пароль еще раз"
                   required="required" data-parsley-equalto="#password"/>
        </div>
    </div>
    <div class="form-group ">
        <div class="col-xs-6">
            <input name="captcha" type="text" class="form-control" placeholder="Код с изображения"
                   required="required"/>
        </div>
        <div class="col-xs-6">
            <img id="captcha" onclick="captch_refresh(this)" class="captcha_img" src="/captcha" />
        </div>
    </div>
    <div class="form-group m-t-20">
        <div class="col-xs-12">
            <button class="btn btn-primary waves-effect waves-light" type="submit">
                Зарегистрироваться
            </button>
        </div>
    </div>
</form:form>
</div>