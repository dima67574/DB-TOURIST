<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<c:set var="resPath" scope="page" value="/resources"/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>${title} | <spring:eval expression="@propertyConfigurer.getProperty('app.siteName')" /></title>
    <meta charset="utf-8">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <link href="${resPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <!-- Bootstrap Core CSS -->
    <link href="${resPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${resPath}/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <%--<!-- Custom CSS -->--%>
    <%--<link href="${resPath}/dist/css/sb-admin-2.css" rel="stylesheet">--%>

    <!-- Custom Fonts -->
    <link href="${resPath}/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <link href="${resPath}/styles/main.css" rel="stylesheet">

    <script src="${resPath}/scripts/main.js"></script>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <!-- Page Content -->
    <div class="container">

        <!-- Page Header -->
        <div class="row">
            <div class="col-lg-12">
                <h3 class="page-header">${title}</h3>
            </div>
        </div>
        <!-- /.row -->

        <!-- Projects Row -->
        <div class="row">
            <jsp:include page="${content}"/>
        </div>
    </div>


<!-- jQuery -->
<script src="${resPath}/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="${resPath}/vendor/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>