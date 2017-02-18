<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/"><spring:eval expression="@propertyConfigurer.getProperty('app.siteName')" /></a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="#">About</a>
                </li>
                <li>
                    <a href="#">Services</a>
                </li>
                <li>
                    <a href="#">Contact</a>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <c:if test="${!isAnonymous}">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" title="Premium Bootstrap Themes &amp; Templates"><i class="icon-star"></i> Premium <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="/bootstrap-design-services"><i class="icon-pencil fa-fw"></i> Custom Bootstrap Design Services</a>
                        </li>
                        <li>
                            <a href="https://wrapbootstrap.com/?ref=StartBootstrap"><i class="icon-handbag fa-fw"></i> WrapBootstrap - Premium Bootstrap Themes</a>
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
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>