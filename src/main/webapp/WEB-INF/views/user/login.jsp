<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-4">
    <form class="form-horizontal m-t-20" action="/login" method="POST">
        <c:if test="${!empty error}">
            <div class="alert alert-danger alert-styled-left alert-bordered">
                <button type="button" class="close" data-dismiss="alert"><span>×</span><span
                        class="sr-only">Close</span></button>
                <c:choose>
                    <c:when test="${error == 'true'}">
                        ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
                    </c:when>
                    <c:otherwise>
                        ${error}
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <div class="form-group ">
            <div class="col-xs-12">
                <input class="form-control" type="text" required="" placeholder="Логин" name="login">
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-12">
                <input class="form-control" type="password" required="" name="password" placeholder="Пароль">
            </div>
        </div>

        <div class="form-group ">
            <div class="col-xs-12">

                <input id="checkbox-signup" type="checkbox" name="remember-me">
                <label for="checkbox-signup" style="font-weight: normal;cursor: pointer">
                    Запомнить меня
                </label>

            </div>
        </div>
        <div class="form-group m-t-20">
            <div class="col-xs-12">
                <button class="btn btn-primary waves-effect waves-light" type="submit">
                    Войти
                </button>
            </div>
        </div>

        <div class="form-group m-t-30 m-b-0">
            <div class="col-sm-12">
                <a href="/restore" class="text-dark">Восстановление доступа</a>
            </div>
        </div>
    </form>
</div>