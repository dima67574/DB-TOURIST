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
        <c:if test="${empty locality.district.region.id}">
            $('#districtId').prop('disabled', true);
        </c:if>

        $('#districtId').select2({
            placeholder: "Выберите район"
        });
        $('#regionId').select2({
            placeholder: "Выберите область"
        }).on('change', function () {
            $.get("/admin/district/getDistricts", {regionId: $('#regionId').val()}, function (d) {
                $('#districtId').empty().select2({
                    data: $.map(d, function (item) {
                        return {id: item.id, text: item.name};
                    })
                });
            });
            $('#districtId').prop('disabled', false);
        });
    });
</script>

<div class="col-md-12">
    <div id="home-2-msg"></div>
    <div id="password-msg"></div>
    <form:form modelAttribute="locality" class="form-horizontal" method="POST">
        <fieldset>
            <spring:bind path="name">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="name">Название населенного пункта:</label>
                        <form:input path="name" class="form-control" placeholder="Введите название"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="name"/>
                    </div>
                </div>
            </spring:bind>

            <div class="form-group ">
                <div class="col-xs-12">
                    <label>Область:</label>
                    <select name="regionId" id="regionId" class="form-control" required>
                        <option></option>
                        <c:forEach var="p" items="${regionList}">
                            <option value="${p.id}"${p.id == locality.district.region.id ? ' selected' : ''}>${p.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <spring:bind path="district.id">
                <div class="form-group">
                    <div class="col-xs-12">
                        <label for="district.id">Район:</label>
                        <form:select path="district.id" id="districtId" class="form-control" required="required">
                            <option></option>
                            <c:forEach var="p" items="${districtList}">
                                <form:option value="${p.id}" label="${p.name}"/>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
            </spring:bind>

        </fieldset>
        <button type="submit" class="btn btn-primary waves-effect waves-light">Сохранить</button>
        <a class="btn btn-default left-btn" href="/admin/locality">Отмена</a>
    </form:form>
    <br/>
</div>