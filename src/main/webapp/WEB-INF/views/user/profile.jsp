<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <div class="tab-content">
            <div class="tab-pane active" id="home-2">
                <div class="col-md-6">
                    <div id="home-2-msg">
                        <c:if test="${!empty success}">
                            <div class="alert alert-success alert-styled-left alert-arrow-left alert-bordered">
                                <button type="button" class="close" data-dismiss="alert"><span>×</span><span
                                        class="sr-only">Close</span></button>
                                    ${success}
                            </div>
                        </c:if>
                    </div>


                    <table class="table" style="margin-top: -21px;">
                        <tbody>
                        <tr>
                            <td><b>Имя</b></td>
                            <td>${user.name}</td>
                        </tr>
                        <tr>
                            <td><b>Фамилия</b></td>
                            <td>${user.surname}</td>
                        </tr>
                        <tr>
                            <td><b>Отчество</b></td>
                            <td>${user.patronymic}</td>
                        </tr>
                        <tr>
                            <td><b>Email</b></td>
                            <td>${user.email}</td>
                        </tr>
                        <tr>
                            <td><b>Телефон</b></td>
                            <td>${user.phoneNumber}</td>
                        </tr>
                        <tr>
                            <td><b>Роль</b></td>
                            <td>${user.role.name == 'ROLE_ADMIN' ? 'Администратор' : 'Пользователь'}</td>
                        </tr>
                        <tr>
                            <td><b>Статус</b></td>
                            <td>${user.banned ? 'Заблокирован' : 'Не заблокирован'}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="tab-pane" id="profile-2">
                <div class="col-md-6" style="padding-bottom: 15px;">
                    <c:if test="${fn:length(user.epochList) > 0}">
                    <b>Эпохи:</b>
                    <ul>
                        <c:forEach var="e" items="${user.epochList}">
                        <li>
                            ${e.name} (${e.startYear} - ${e.finishYear})
                        </li>
                        </c:forEach>
                    </ul>
                    </c:if>
                    <c:if test="${fn:length(user.styleList) > 0}">
                    <b>Стили:</b>
                    <ul>
                        <c:forEach var="s" items="${user.styleList}">
                            <li>${s.name}</li>
                        </c:forEach>
                    </ul>
                    </c:if>
                    <c:if test="${fn:length(user.typeList) > 0}">
                    <b>Типы:</b>
                    <ul>
                        <c:forEach var="t" items="${user.typeList}">
                            <li>${t.name}</li>
                        </c:forEach>
                    </ul>
                    </c:if>
                </div>
            </div>
            <div class="tab-pane" id="profile-3">
                <div class="col-md-6" style="padding-bottom: 15px;">
                    <b>Объекты:</b>
                    <ul>
                        <c:forEach var="o" items="${user.objects}">
                            <li>${o.name}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    <div class="col-md-3">
        <ul class="nav nav-pills nav-stacked">
            <li class="active tab">
                <a href="#home-2" data-toggle="tab" aria-expanded="false">
                    Основная информация
                </a>
            </li>
            <c:if test="${fn:length(user.epochList) > 0 || fn:length(user.styleList) > 0 || fn:length(user.typeList) > 0}">
            <li class="tab">
                <a href="#profile-2" data-toggle="tab" aria-expanded="false">
                    Предпочтения
                </a>
            </li>
            </c:if>
            <c:if test="${fn:length(user.objects) > 0}">
            <li class="tab">
                <a href="#profile-3" data-toggle="tab" aria-expanded="false">
                    Публикации
                </a>
            </li>
            </c:if>
        </ul>
    </div>

