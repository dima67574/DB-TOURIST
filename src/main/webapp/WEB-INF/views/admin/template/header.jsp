<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<form id="logoutForm" method="POST" action="/admin/logout"></form>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/admin"><spring:eval expression="@propertyConfigurer.getProperty('app.siteName')" /> / Админ-панель</a>
    </div>
    <!-- /.navbar-header -->

    <ul class="nav navbar-top-links navbar-right">
        <!-- /.dropdown -->
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-star"></i> <security:authentication property="principal.user.name" /> <security:authentication property="principal.user.surname" /> <b class="caret"></b></a>

            <ul class="dropdown-menu dropdown-user">
                <li><a href="/"><i class="fa fa-toggle-left fa-fw"></i> Перейти к сайту</a>
                </li>
                <li class="divider"></li>
                <li><a href="#" onclick="$('#logoutForm').submit();"><i class="fa fa-sign-out fa-fw"></i> Выход</a>
                </li>
            </ul>
            <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
    </ul>
    <!-- /.navbar-top-links -->
    <jsp:include page="sidebar.jsp"/>
</nav>