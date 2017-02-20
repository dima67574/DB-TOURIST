<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
    $(function () {
        $("#epochs").val([
            <c:forEach items="${user.epochList}" var="epoch">
            "${epoch.id}",
            </c:forEach>
        ]);
        $("#types").val([
            <c:forEach items="${user.typeList}" var="type">
            "${type.id}",
            </c:forEach>
        ]);
        $("#styles").val([
            <c:forEach items="${user.styleList}" var="style">
            "${style.id}",
            </c:forEach>
        ]);
        $('select').select2();
    });
</script>
    <div class="">
        <div class="tab-content">
            <div class="tab-pane active" id="home-2">
                <div class="col-md-6">
                        <div id="home-2-msg">
                            <c:if test="${!empty success}">
                                <div class="alert alert-success alert-styled-left alert-arrow-left alert-bordered">
                                    <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
                                        ${success}
                                </div>
                            </c:if>
                        </div>
                        <form class="form-horizontal" role="form" id="preferencesForm">
                            <div class="form-group">
                                <div class="col-md-10">
                                    <label>Эпохи:</label>
                                    <select id="epochs" multiple="multiple" style="width:100%">
                                        <c:forEach items="${epochList}" var="epoch">
                                            <option value="${epoch.id}">${epoch.name} (${epoch.startYear} - ${epoch.finishYear})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-10">
                                    <label>Типы:</label>
                                    <select id="types" multiple="multiple" style="width:100%">
                                        <c:forEach items="${typeList}" var="type">
                                            <option value="${type.id}">${type.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-10">
                                    <label>Стили:</label>
                                    <select id="styles" multiple="multiple" style="width:100%">
                                        <c:forEach items="${styleList}" var="style">
                                            <option value="${style.id}">${style.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <button type="button" class="btn btn-primary waves-effect waves-light"
                                    onclick="settings.savePreferences();">Сохранить</button>
                        </form>
                </div>
            </div>
            <div class="tab-pane" id="profile-2">
                <div class="col-md-6">
                        <div id="password-msg"></div>
                        <form id="changePasswordForm" class="form-horizontal">
                            <fieldset>
                                <div class="form-group">
                                    <div class="col-md-10">
                                        <label for="oldPassword">Старый пароль:</label>
                                        <input name="oldPassword" id="oldPassword" type="password" class="form-control"
                                            placeholder="Введите старый пароль" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-10">
                                        <label for="password1">Новый пароль:</label>
                                        <input name="password1" id="password1" type="password" class="form-control"
                                            placeholder="Введите новый пароль" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-10">
                                     <label for="password2">Новый пароль еще раз:</label>
                                     <input name="password2" id="password2" type="password" class="form-control"
                                       placeholder="Введите новый пароль еще раз" required="required" data-parsley-equalto="#password1"/>
                                    </div>
                                </div>
                            </fieldset>
                            <button type="button" class="btn btn-primary waves-effect waves-light"
                                    onclick="settings.changePassword();">Изменить пароль</button>
                        </form>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li class="active tab">
                    <a href="#home-2" data-toggle="tab" aria-expanded="false">
                        <span class="visible-xs"><i class="fa fa-home"></i></span>
                        <span class="hidden-xs">Мои предпочтения</span>
                    </a>
                </li>
                <li class="tab">
                    <a href="#profile-2" data-toggle="tab" aria-expanded="false">
                        <span class="visible-xs"><i class="fa fa-user"></i></span>
                        <span class="hidden-xs">Смена пароля</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
