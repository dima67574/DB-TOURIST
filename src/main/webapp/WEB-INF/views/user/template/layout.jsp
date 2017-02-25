<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<c:set var="resPath" scope="page" value="/resources"/>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>${title} | <spring:eval expression="@propertyConfigurer.getProperty('app.siteName')"/></title>
    <meta charset="utf-8">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <link href="${resPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${resPath}/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="${resPath}/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="${resPath}/vendor/select2/select2.min.css" rel="stylesheet">
    <link href="${resPath}/styles/main.css" rel="stylesheet">

    <script type="text/javascript" src="${resPath}/vendor/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${resPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${resPath}/vendor/select2/select2.full.min.js"></script>
    <script type="text/javascript" src="${resPath}/vendor/select2/i18n/ru.js"></script>
    <script type="text/javascript" src="${resPath}/vendor/parsleyjs/parsley.min.js"></script>
    <script type="text/javascript" src="${resPath}/vendor/parsleyjs/i18n/ru.js"></script>
    <script type="text/javascript" src="${resPath}/scripts/main.js"></script>

    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $('form').parsley();
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container" style="padding-top: 70px;">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">${title}</h3>
        </div>
    </div>
    <div class="row">
        <jsp:include page="${content}"/>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>