<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<script>
    function showRatingForm() {
        $('#rating_form').slideDown();
        $('#addButton').attr('onclick', 'sendComment();');
    }
    function sendComment() {
        var form = $('#commentForm');
        form.parsley().validate();
        if (!form.parsley().isValid()){
            return;
        }
        var rate = $('input[name="rating"]:checked').val();
        var text = $('#addComment').val();
        $.post('/sendComment', {objectId: ${object.id}, rate: rate, text: text}, function (d) {
            $('#addButton').remove();
            if(d) {
                message('rating_form', 'Отзыв успешно добавлен и будет опубликован после проверки администрацией.', 'info m-b-0', 1, 1);
            } else {
                message('rating_form', 'Произошла ошибка.', 'info m-b-0', 1, 1);
            }
        });
    }
</script>
<div class="col-md-12">

        <div class="row">
            <div class="col-lg-5">
                <a href="/object/${object.id}/gallery">
                    <img style="width:100%"
                         src="<c:if test="${!empty object.cover.file}">/photo?name=${object.cover.file}</c:if><c:if test="${empty object.cover.file}">/resources/images/noimage.jpg</c:if>"
                         alt="">
                </a>
            </div>
            <div style="margin-left:20px;margin-top:5px">
                <div style="font-size: 16px;margin-bottom:6px">
                    <b>Года:</b> ${fn:length(object.yearList) == 0 ? 'не указаны' : ''}
                    <c:forEach var="y" items="${object.yearList}" varStatus="i">
                        ${y.year}${(fn:length(object.yearList) - 1) > i.index ? ',' : ''}
                    </c:forEach>
                </div>
                <div style="font-size: 16px;margin-bottom:6px">
                    <b>Типы:</b> ${fn:length(object.typeList) == 0 ? 'не указаны' : ''}
                    <c:forEach var="t" items="${object.typeList}" varStatus="i">
                        <a href="/type/${t.id}/objects">${t.name}</a>${(fn:length(object.typeList) - 1) > i.index ? ',' : ''}
                    </c:forEach>
                </div>
                <div style="font-size: 16px;margin-bottom:6px">
                    <b>Стили:</b> ${fn:length(object.styleList) == 0 ? 'не указаны' : ''}
                    <c:forEach var="s" items="${object.styleList}" varStatus="i">
                        <a href="/style/${s.id}/objects">${s.name}</a>${(fn:length(object.styleList) - 1) > i.index ? ',' : ''}
                    </c:forEach>
                </div>
                <div style="font-size: 16px;margin-bottom:6px"><b>Оценка:</b>
                    <span class="star-rating">
                        <c:forEach begin="0" end="4" varStatus="i">
                            <c:set var="num" value="${i.index + 1}" />
                            <c:if test="${object.rating > num && object.rating < (num + 1)}">
                                <i class="fa fa-star-half-full" style="color:#f39c15;"></i>
                            </c:if>
                            <c:if test="${(object.rating > num && object.rating >= (num + 1)) || object.rating == num}">
                                <i class="fa fa-star" style="color:#f39c15;"></i>
                            </c:if>
                            <c:if test="${object.rating < num}">
                                <i class="fa fa-star-o" style="color:#f39c15;"></i>
                            </c:if>
                        </c:forEach>
                    </span>
                </div>
                <div style="font-size: 16px;margin-bottom:6px">
                    <b>Адрес:</b> ${empty object.address ? 'не указан' : object.address}
                </div>
                <div style="font-size: 16px;margin-bottom:6px">
                    <b>Координаты:</b>
                    <a href="/map?xCoordinate=${object.xCoordinate}&yCoordinate=${object.yCoordinate}">x:${object.xCoordinate},
                        y:${object.yCoordinate}</a>
                </div>
                <div style="font-size: 16px;margin-bottom:6px">
                    ${object.locality.district.region.name} область, <a
                        href="/localities/${object.locality.district.id}">${object.locality.district.name} район</a>, <a
                        href="/locality/${object.locality.id}">${object.locality.name}</a>
                </div>
            </div>
        </div>
        ${fn:length(object.childObjects) > 0 ? '<hr>' : ''}
        <div>
        <c:forEach var="e" items="${object.childObjects}">
            <div class="col-md-3" style="margin-left: -15px;">
                <div class="row" style="margin-bottom: 15px;">
                    <div class="col-lg-12">
                        <a href="/object/${e.id}">
                            <img style="width:100%;"
                                 src="<c:if test="${!empty e.cover.file}">/photo?name=${e.cover.file}</c:if><c:if test="${empty e.cover.file}">/resources/images/noimage.jpg</c:if>"
                                 alt="">
                        </a>
                        <div class="object-title" style="margin-bottom:3px;margin-top:4px"><a
                                href="/object/${e.id}"><b>${e.name}</b></a></div>
                    </div>
                </div>
            </div>

        </c:forEach>
        </div>



</div>

<script>
    var logID = 'log',
        log = $('<div id="'+logID+'"></div>');
    $('body').append(log);
    $('[type*="radio"]').change(function () {
        var me = $(this);
        log.html(me.attr('value'));
    });
</script>

<style>
:root {
    font-size: 1.7em;
    font-family: Helvetica, arial, sans-serif;
}
</style>


<div class="col-md-12" style="margin-bottom:10px;margin-top:10px">
    <h3 class="page-header" style="margin-top: 10px;">Отзывы</h3>
    <c:choose>
        <c:when test="${commentedStatus == 3}">
            <div class="no-info">
                Чтобы оставить отзыв, <a href="/login">войдите</a> или <a href="/registration">зарегистрируйтесь</a>
            </div>
        </c:when>
        <c:when test="${commentedStatus == 1}">
            <div class="alert alert-info alert-styled-left alert-arrow-left alert-bordered">
                <span class="alrt-msg">Ваш отзыв будет опубликован после проверки администрацией.</span>
            </div>
        </c:when>
        <c:when test="${commentedStatus == 2}"></c:when>
        <c:otherwise>
            <div id="rating_form" style="display: none">
                <div class="form-group">
                    <div><b>Ваша оценка:</b></div>

                    <div class="star-cb-group" style="float:left">
                        <input type="radio" id="rating-5" name="rating" value="5" /><label for="rating-5">5</label>
                        <input type="radio" id="rating-4" name="rating" value="4" /><label for="rating-4">4</label>
                        <input type="radio" id="rating-3" name="rating" value="3" checked="checked" /><label for="rating-3">3</label>
                        <input type="radio" id="rating-2" name="rating" value="2" /><label for="rating-2">2</label>
                        <input type="radio" id="rating-1" name="rating" value="1" /><label for="rating-1">1</label>
                        <input type="radio" id="rating-0" name="rating" value="0" class="star-cb-clear" /><label for="rating-0">0</label>
                    </div>


                </div>

                <form id="commentForm">
                    <div class="form-group">
                        <textarea class="form-control" name="addComment" id="addComment" rows="5" style="resize:vertical;" required></textarea>
                    </div>
                </form>
            </div>

            <div class="form-group">
                <button class="btn btn-primary" onclick="showRatingForm();" id="addButton">Добавить отзыв</button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="col-md-12">
    <c:if test="${fn:length(comments) == 0}">
        <div class="no-info" style="padding-left:5px">
            Нет отзывов о достопримечательности
        </div>
    </c:if>
    <c:forEach var="c" items="${comments}">
    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>${c.user.fio}</strong>
            <c:forEach begin="0" end="4" varStatus="i">
                <c:set var="num" value="${i.index + 1}" />
                <c:if test="${c.mark > num || c.mark == num}">
                    <i class="fa fa-star" style="color:#f39c15;"></i>
                </c:if>
                <c:if test="${c.mark < num}">
                    <i class="fa fa-star-o" style="color:#f39c15;"></i>
                </c:if>
            </c:forEach>
        </div>
        <div class="panel-body">
            <div class="text-muted" style="font-size:13px;margin-bottom:10px">

                <fmt:formatDate value="${c.date}" pattern="dd.MM.yyyy в HH:mm:ss" var="createDate" />
                    ${createDate}
            </div>
                ${c.text}
        </div>
    </div>
    </c:forEach>
</div>