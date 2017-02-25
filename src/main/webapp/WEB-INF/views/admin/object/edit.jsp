<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="resPath" scope="page" value="/resources"/>

<script>
    $(function () {
        <c:if test="${empty object.locality.id}">
        $('#districtId').prop('disabled', true);
        $('#localityId').prop('disabled', true);
        $('#parentId').prop('disabled', true);
        </c:if>

        $("#epochs").val([
            <c:forEach items="${object.epochList}" var="epoch">
            "${epoch.id}",
            </c:forEach>
        ]);
        $("#types").val([
            <c:forEach items="${object.typeList}" var="type">
            "${type.id}",
            </c:forEach>
        ]);
        $("#styles").val([
            <c:forEach items="${object.styleList}" var="style">
            "${style.id}",
            </c:forEach>
        ]);

        $("#years").val([
            <c:forEach items="${object.yearList}" var="year">
            "${year.year}",
            </c:forEach>
        ]);

        $('select').select2();

        $('#regionId').select2({
            placeholder: function(){
                $(this).data('placeholder');
            }
        }).on('change', function () {
            $.get("/admin/district/getDistricts", {regionId: $('#regionId').val()}, function (d) {
                $('#districtId').empty().prepend('<option></option>').select2({
                    placeholder: function(){
                        $(this).data('placeholder');
                    },
                    data: $.map(d, function (item) {
                        return {id: item.id, text: item.name};
                    })
                });
            });
            $('#districtId').prop('disabled', false);
            $('#localityId').prop('disabled', true).val('').trigger('change');
            $('#parentId').prop('disabled', true).val('').trigger('change');
        });

        $('#districtId').select2({
            placeholder: function(){
                $(this).data('placeholder');
            }
        }).on('change', function () {
            $.get("/admin/locality/getLocalities", {districtId: $('#districtId').val()}, function (d) {
                $('#localityId').empty().prepend('<option></option>').select2({
                    data: $.map(d, function (item) {
                        return {id: item.id, text: item.name};
                    })
                });
            });
            $('#localityId').prop('disabled', false);
            $('#parentId').prop('disabled', true).val('').trigger('change');
        });

        $('#localityId').select2({
            placeholder: function(){
                $(this).data('placeholder');
            }
        }).on('change', function () {
            $.get("/admin/object/getObjects", {localityId: $('#localityId').val()}, function (d) {
                $('#parentId').empty().prepend('<option></option>').select2({
                    data: $.map(d, function (item) {
                        return {id: item.id, text: item.name};
                    })
                });
            });
            $('#parentId').prop('disabled', false);
        });

        <c:if test="${empty object.parent.id}">
            $('#parentId').val('').trigger('change');
        </c:if>

        $("#years").select2({
            tags: "true",
            placeholder: "Введите года объекта",
            allowClear: true,
            formatNoMatches: function() {
                return '';
            },
            dropdownCssClass: 'select2-hidden'
        });
    });
</script>
<style>
    .select2-hidden {
        display:none !important;
    }
</style>
<div class="col-md-12">
    <div id="home-2-msg"></div>
    <div id="password-msg"></div>
    <form:form modelAttribute="object" class="form-horizontal" method="POST">
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

            <div class="form-group">
                <div class="col-md-12">
                    <label>Эпохи:</label>
                    <select name="epochs" id="epochs" multiple="multiple" class="form-control" >
                        <c:forEach items="${epochs}" var="epoch">
                            <option value="${epoch.id}">${epoch.name} (${epoch.startYear}
                                - ${epoch.finishYear})
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-12">
                    <label>Типы:</label>
                    <select name="types" id="types" multiple="multiple" style="width: 100% !important;">
                        <c:forEach items="${types}" var="type">
                            <option value="${type.id}">${type.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-12">
                    <label>Стили:</label>
                    <select name="styles" id="styles" multiple="multiple" style="width: 100% !important;">
                        <c:forEach items="${styles}" var="style">
                            <option value="${style.id}">${style.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group ">
                <div class="col-xs-12">
                    <label>Область:</label>
                    <select data-placeholder="Выберите область" name="regionId" id="regionId" class="form-control" required>
                        <option></option>
                        <c:forEach var="p" items="${regions}">
                            <option value="${p.id}"${p.id == object.locality.district.region.id ? ' selected' : ''}>${p.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group ">
                <div class="col-xs-12">
                    <label>Район:</label>
                    <select data-placeholder="Выберите район" name="districtId" id="districtId" class="form-control" required>
                        <c:forEach var="p" items="${districts}">
                            <option value="${p.id}"${p.id == object.locality.district.id ? ' selected' : ''}>${p.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <spring:bind path="locality.id">
                <div class="form-group">
                    <div class="col-xs-12">
                        <label for="locality.id">Населенный пункт:</label>
                        <form:select data-placeholder="Выберите населенный пункт"  path="locality.id" id="localityId" class="form-control" required="required">
                            <c:forEach var="p" items="${localities}">
                                <option value="${p.id}"${p.id == object.locality.id ? ' selected' : ''}>${p.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="parent.id">
                <div class="form-group">
                    <div class="col-xs-12">
                        <label for="parent.id">Родительский объект:</label>
                        <form:select data-placeholder="Выберите родительский объект"  path="parent.id" id="parentId" class="form-control">
                            <c:forEach var="p" items="${parents}">
                                <option value="${p.id}"${p.id == object.parent.id ? ' selected' : ''}>${p.name}</option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="xCoordinate">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="xCoordinate">X координата:</label>
                        <form:input path="xCoordinate" class="form-control"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="xCoordinate"/>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="yCoordinate">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="yCoordinate">Y координата:</label>
                        <form:input path="yCoordinate" class="form-control"
                                    required="required"/>
                        <form:errors class="validation-error-label" path="yCoordinate"/>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="address">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <label for="address">Адрес:</label>
                        <form:input path="address" class="form-control" />
                        <form:errors class="validation-error-label" path="address"/>
                    </div>
                </div>
            </spring:bind>


            <div class="form-group">
                <div class="col-md-12">
                    <label>Года:</label>
                    <select name="years" id="years" multiple="multiple" style="width: 100% !important;">
                        <c:forEach items="${object.yearList}" var="year">
                            <option value="${year.year}">${year.year}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group ">
                <div class="col-xs-12">
                <form:label path="description">Описание:</form:label>
                <form:textarea path="description" rows="5" cols="5" class="form-control" data-placeholder="Введите описание" name="description"
                               id="text" style="resize: vertical;"/>
                </div>
            </div>
        </fieldset>
        <button type="submit" class="btn btn-primary waves-effect waves-light">Сохранить</button>
        <a class="btn btn-default left-btn" href="/admin/object">Отмена</a>
    </form:form>
    <br/>
</div>