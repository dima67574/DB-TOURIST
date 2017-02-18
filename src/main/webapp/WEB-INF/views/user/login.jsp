<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="wrapper-page">
    <div class=" card-box">
        <div class="panel-heading">
            <h3 class="text-center"> ${title} в <strong class="text-custom"><spring:eval expression="@propertyConfigurer.getProperty('app.siteName')" /></strong> </h3>
        </div>
        <div class="panel-body">
            <form class="form-horizontal m-t-20" action="/login" method="POST">

                <c:if test="${!empty success}">
                    <div class="alert alert-success alert-styled-left alert-arrow-left">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
                            ${success}
                    </div>
                </c:if>

                <c:if test="${!empty info}">
                    <div class="alert alert-info alert-styled-left alert-arrow-left">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
                            ${info}
                    </div>
                </c:if>

                <c:if test="${!empty error}">
                    <div class="alert alert-danger alert-styled-left alert-bordered">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
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
                        <div class="checkbox checkbox-primary">
                            <input id="checkbox-signup" type="checkbox" name="remember-me">
                            <label for="checkbox-signup">
                                Запомнить меня
                            </label>
                        </div>

                    </div>
                </div>
                <div class="form-group text-center m-t-20">
                    <div class="col-xs-12">
                        <button class="btn btn-inverse btn-block text-uppercase waves-effect waves-light" type="submit">Вход</button>
                    </div>
                </div>

                <div class="form-group m-t-30 m-b-0">
                    <div class="col-sm-12">
                        <a href="/restore" class="text-dark"><i class="fa fa-lock m-r-5"></i> Забыли пароль?</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 text-center">
            <p>У Вас нет аккаунта? <a href="/registration" class="text-primary m-l-5"><b>Зарегистрироваться</b></a></p>
        </div>
    </div>
</div>