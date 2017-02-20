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

    });
</script>

<div class="col-md-12">
    <div id="home-2-msg"></div>
    <div id="password-msg"></div>
    <form:form modelAttribute="epoch" class="form-horizontal" method="POST">
        <fieldset>
            <spring:bind path="name">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="name">Название:</label>
                        <form:input path="name" class="form-control" placeholder="Введите название"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="name"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="startYear">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="startYear">Год начала:</label>
                        <form:input path="startYear" class="form-control" placeholder="Введите год начала"
                                    required="required" data-parsley-type="integer"/>
                        <form:errors class="validation-error-label" path="startYear"/>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="finishYear">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="finishYear">Год окончания:</label>
                        <form:input path="finishYear" class="form-control" placeholder="Введите год окончания"
                                    required="required" data-parsley-type="integer"/>
                        <form:errors class="validation-error-label" path="finishYear"/>
                    </div>
                </div>
            </spring:bind>

            <div class="form-group ">
                <div class="col-xs-12">
                <form:label path="description">Описание:</form:label>
                <form:textarea path="description" rows="5" cols="5" class="form-control" placeholder="Введите описание" name="description"
                               id="text" style="resize: vertical;"/>
                </div>
            </div>
        </fieldset>
        <button type="submit" class="btn btn-primary waves-effect waves-light">Сохранить</button>
        <a class="btn btn-default left-btn" href="/admin/epoches">Отмена</a>
    </form:form>
    <br/>
</div>