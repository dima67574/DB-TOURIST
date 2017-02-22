<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="resPath" scope="page" value="/resources"/>
<!-- Summernote css -->
<link href="${resPath}/vendor/summernote/summernote.css" rel="stylesheet" />
<!--Summernote js-->
<script src="${resPath}/vendor/summernote/summernote.min.js"></script>

<script>
    $(function () {
        $('select').select2();
    });
</script>

<div class="col-md-12">
    <div id="home-2-msg"></div>
    <div id="password-msg"></div>
    <form:form modelAttribute="district" class="form-horizontal" method="POST">
        <fieldset>
            <spring:bind path="name">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="name">Название района:</label>
                        <form:input path="name" class="form-control" placeholder="Введите название"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="name"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="region.id">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="region.id">Область:</label>
                        <form:select path="region.id" class="form-control">
                            <form:options items="${regionList}"/>
                        </form:select>
                    </div>
                </div>
            </spring:bind>
        </fieldset>
        <button type="submit" class="btn btn-primary waves-effect waves-light">Сохранить</button>
        <a class="btn btn-default left-btn" href="/admin/district">Отмена</a>
    </form:form>
    <br/>
</div>