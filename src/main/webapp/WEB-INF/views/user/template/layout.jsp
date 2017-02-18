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

    <!-- Bootstrap Core CSS -->
    <link href="${resPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${resPath}/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <%--<!-- Custom CSS -->--%>
    <%--<link href="${resPath}/dist/css/sb-admin-2.css" rel="stylesheet">--%>

    <!-- Custom Fonts -->
    <link href="${resPath}/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <link href="${resPath}/styles/main.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="${resPath}/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${resPath}/vendor/bootstrap/js/bootstrap.min.js"></script>


    <script src="${resPath}/scripts/main.js"></script>

    <!-- Parsly js -->
    <script type="text/javascript" src="${resPath}/vendor/parsleyjs/parsley.min.js"></script>
    <script type="text/javascript" src="${resPath}/vendor/parsleyjs/i18n/ru.js"></script>

    <script type="text/javascript">
        jQuery(document).ready(function($) {
            <c:if test="${!empty firstAuth}">
                $('#firstAuthModal').modal('show');
            </c:if>
            $('form').parsley();
        });
    </script>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <!-- Page Content -->
    <div class="container" style="padding-top: 70px;">

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

    <jsp:include page="footer.jsp"/>

    <c:if test="${firstAuth}">
    <div class="modal fade" tabindex="-1" role="dialog" id="firstAuthModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Укажите Ваши предпочтения</h4>
                </div>
                <div class="modal-body">
                    <p>One fine body&hellip;</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary">Сохранить</button>
                </div>
            </div>
        </div>
    </div>
    </c:if>
</body>
</html>