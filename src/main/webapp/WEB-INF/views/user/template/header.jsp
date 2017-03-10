<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
<form id="logoutForm" method="POST" action="/logout"></form>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">${siteName}</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="#">Топ-50</a>
                </li>
                <li>
                    <a href="#">Типы</a>
                </li>
                <li>
                    <a href="#">Стили</a>
                </li>
                <li>
                    <a href="#">Населенные пункты</a>
                </li>
                <li>
                    <a href="#">Карта</a>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <c:if test="${!isAnonymous}">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-star"></i>
                            <security:authentication property="principal.user.name"/> <security:authentication
                                    property="principal.user.surname"/> <b class="caret"></b></a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <a href="/profile"><i class="fa fa-user fa-fw"></i> Просмотр профиля</a>
                            </li>
                            <li>
                                <a href="/settings"><i class="fa fa-gear fa-fw"></i> Настройки</a>
                            </li>
                            <c:if test="${isAdmin}">
                                <li><a href="/admin"><i class="fa fa-toggle-right fa-fw"></i> Админ-панель</a>
                                </li>
                            </c:if>
                            <li class="divider"></li>
                            <li><a href="#" onclick="$('#logoutForm').submit();"><i class="fa fa-sign-out fa-fw"></i>
                                Выход</a>
                            </li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${isAnonymous}">
                    <li><a href="/login">Вход</a></li>
                    <li><a href="/registration">Регистрация</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>