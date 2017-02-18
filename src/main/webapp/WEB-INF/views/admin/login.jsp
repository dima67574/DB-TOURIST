<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-md-4 col-md-offset-4">
    <div class="login-panel panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">${title}</h3>
        </div>
        <div class="panel-body">
            <form role="form" method="POST" action="/admin/login">

                <c:if test="${!empty message}">
                    <div class="alert alert-success alert-styled-left alert-arrow-left alert-bordered">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
                            ${message}
                    </div>
                </c:if>

                <c:if test="${!empty error and !empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}">
                    <div class="alert alert-danger alert-styled-left alert-bordered">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
                            ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
                    </div>
                </c:if>

                <fieldset>
                    <div class="form-group has-feedback has-feedback-left">
                        <input type="text" class="form-control" placeholder="Логин" name="login" autofocus required maxlength="70">
                        <div class="form-control-feedback">
                            <i class="icon-user text-muted"></i>
                        </div>
                    </div>

                    <div class="form-group has-feedback has-feedback-left">
                        <input name="password" type="password" class="form-control" placeholder="Пароль" required maxlength="70">
                        <div class="form-control-feedback">
                            <i class="icon-lock2 text-muted"></i>
                        </div>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input name="remember" type="checkbox" value="Запомнить меня">Запомнить меня
                        </label>
                    </div>
                    <button type="submit" class="btn btn-lg btn-success btn-block">Войти</button>
                </fieldset>
            </form>
        </div>
    </div>
</div>
