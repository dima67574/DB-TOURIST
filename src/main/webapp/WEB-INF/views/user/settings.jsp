<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
       $('#learningWords').val(${user.learningWords});
       $('#trainingWords').val(${user.trainingWords});
    });
</script>
<div class="row">
    <div class="col-lg-12">
        <ul class="nav nav-tabs navtab-bg nav-justified">
            <li class="active tab">
                <a href="#home-2" data-toggle="tab" aria-expanded="false">
                    <span class="visible-xs"><i class="fa fa-home"></i></span>
                    <span class="hidden-xs">Натройки обучения</span>
                </a>
            </li>
            <li class="tab">
                <a href="#profile-2" data-toggle="tab" aria-expanded="false">
                    <span class="visible-xs"><i class="fa fa-user"></i></span>
                    <span class="hidden-xs">Настройки аккаунта</span>
                </a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="home-2">
                <div class="row">
                    <div class="col-md-6">
                        <div id="home-2-msg"></div>
                        <form class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="col-md-10">
                                    <label>Количество слов в режиме обучения:</label>
                                    <select class="selectpicker show-tick" data-style="btn-white" id="learningWords">
                                        <option value="5">5</option>
                                        <option value="7">7</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-10">
                                    <label>Количество слов в режиме тренировки:</label>
                                    <select class="selectpicker show-tick" data-style="btn-white" id="trainingWords">
                                        <option value="5">5</option>
                                        <option value="7">7</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-10">
                                    <button type="button" class="btn btn-inverse waves-effect waves-light"
                                            onclick="settings.saveEducation();">Сохранить</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="tab-pane" id="profile-2">
                <div class="row">
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
                            <button type="button" class="btn btn-inverse waves-effect waves-light"
                                    onclick="settings.changePassword();">Изменить пароль</button>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div id="email-msg"></div>
                            <form id="changeEmailForm">
                                <div class="form-group">
                                    <div class="col-md-10">
                                        <label>Текущий email:</label>
                                        <pre id="currentEmail">${user.email}</pre>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-10">
                                        <label for="email">Новый email:</label>
                                        <input name="email" id="email" type="email" class="form-control"
                                               placeholder="Введите новый email" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-10 m-t-15">
                                        <button type="button" class="btn btn-inverse waves-effect waves-light"
                                                onclick="settings.saveEmail();">Изменить email</button>
                                    </div>
                                </div>
                            </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>