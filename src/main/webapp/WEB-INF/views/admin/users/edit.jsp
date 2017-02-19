<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<script>
    $(function () {
       $('select').select2();
    });
</script>

<div class="col-md-6" style="margin-bottom: 20px">
    <div id="home-2-msg"></div>
    <div id="password-msg"></div>
    <form:form modelAttribute="user" class="form-horizontal" method="POST">
        <fieldset>
            <spring:bind path="name">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label>Имя:</label>
                        <form:input path="name" class="form-control" placeholder="Имя"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="name"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="surname">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label>Фамилия:</label>
                        <form:input path="surname" class="form-control" placeholder="Фамилия"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="surname"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="patronymic">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label>Отчество:</label>
                        <form:input path="patronymic" class="form-control" placeholder="Отчество"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="patronymic"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="phoneNumber">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="phoneNumber">Номер телефона:</label>
                        <form:input path="phoneNumber" class="form-control" placeholder="Номер телефона"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="phoneNumber"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="login">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="login">Логин:</label>
                        <form:input path="login" class="form-control" placeholder="Введите логин"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="login"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="email">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="login">Email:</label>
                        <form:input path="email" type="email" class="form-control" placeholder="Введите email"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="email"/>
                    </div>
                </div>
            </spring:bind>

            <c:set var="userId">
            <security:authentication property="principal.user.id" />
            </c:set>
            <c:if test="${userId != user.id}">
            <spring:bind path="role.id">
                <div class="form-group">
                    <div class="col-xs-12">
                        <label for="role.id">Роль:</label>
                        <form:select path="role.id" class="form-control" required="required">
                            <form:option value="1" label="Администратор"/>
                            <form:option value="2" label="Пользователь"/>
                        </form:select>
                        <form:errors class="validation-error-label" path="role.id"/>
                    </div>
                </div>
            </spring:bind>
            </c:if>
        </fieldset>
        <button type="submit" class="btn btn-primary waves-effect waves-light">Сохранить</button>
    </form:form>
</div>