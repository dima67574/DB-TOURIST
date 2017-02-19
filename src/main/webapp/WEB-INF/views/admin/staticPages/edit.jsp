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
        $('#text').summernote({
            toolbar: [
                ['font', ['bold', 'italic', 'underline', 'clear']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['link']],
            ],
            height: 250
        });
    });
</script>

<div class="col-md-12">
    <div id="home-2-msg"></div>
    <div id="password-msg"></div>
    <form:form modelAttribute="page" class="form-horizontal" method="POST">
        <fieldset>
            <spring:bind path="title">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="title">Название:</label>
                        <form:input path="title" class="form-control" placeholder="Введите название"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="title"/>
                    </div>
                </div>
            </spring:bind>
            <spring:bind path="url">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="url">Адрес:</label>
                        <div class="input-group">
                            <span class="input-group-addon"><b>${url}page/</b></span>
                            <form:input path="url" data-parsley-errors-container="#page-url-err" class="form-control" placeholder="Введите адрес"
                                        required="required"/>
                        </div>
                        <div id="page-url-err"></div>
                    </div>
                </div>
            </spring:bind>

            <div class="form-group ">
                <div class="col-xs-12">
                <form:label path="text">Текст:</form:label>
                <form:textarea path="text" rows="5" cols="5" class="form-control" placeholder="Введите текст" name="text"
                               id="text" style="resize: vertical;" required="required"/>
                </div>
            </div>
        </fieldset>
        <button type="submit" class="btn btn-primary waves-effect waves-light">Сохранить</button>
        <a class="btn btn-default left-btn" href="/admin/pages">Отмена</a>
    </form:form>
    <br/>
</div>