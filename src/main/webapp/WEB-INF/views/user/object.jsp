<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <div style="font-size: 16px;margin-bottom:6px"><b>Оценка:</b> XXXXX</div>
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
        <hr>
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

<div class="col-md-12" style="margin-bottom:20px;margin-top:10px">
    <h3 class="page-header">Отзывы</h3>

    <div class="form-group">
        <div><b>Ваша оценка:</b></div>

    <div class="star-cb-group" style="float:left">
      <input type="radio" id="rating-5" name="rating" value="5" /><label for="rating-5">5</label>
      <input type="radio" id="rating-4" name="rating" value="4" checked="checked" /><label for="rating-4">4</label>
      <input type="radio" id="rating-3" name="rating" value="3" /><label for="rating-3">3</label>
      <input type="radio" id="rating-2" name="rating" value="2" /><label for="rating-2">2</label>
      <input type="radio" id="rating-1" name="rating" value="1" /><label for="rating-1">1</label>
      <input type="radio" id="rating-0" name="rating" value="0" class="star-cb-clear" /><label for="rating-0">0</label>
    </div>


    </div>

    <div class="form-group">

            <textarea class="form-control" name="addComment" id="addComment" rows="5" style="resize:vertical;"></textarea>

    </div>
    <div class="form-group">
        <button class="btn btn-primary">Добавить отзыв</button>
    </div>
</div>

<div class="col-md-12">
    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>Бахир Дима</strong> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i>
        </div>
        <div class="panel-body">
            <div class="text-muted" style="font-size:13px;margin-bottom:10px">21.01.2016 в 10:30:40</div>
            фыфыывфвфывфы
        </div><!-- /panel-body -->
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>Бахир Дима</strong> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i>
        </div>
        <div class="panel-body">
            <div class="text-muted" style="font-size:13px;margin-bottom:10px">21.01.2016 в 10:30:40</div>
            фыфыывфвфывфы
        </div><!-- /panel-body -->
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>Бахир Дима</strong> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i> <i class="fa fa-star" style="color:#f39c15;"></i>
        </div>
        <div class="panel-body">
            <div class="text-muted" style="font-size:13px;margin-bottom:10px">21.01.2016 в 10:30:40</div>
            фыфыывфвфывфы
        </div><!-- /panel-body -->
    </div>
</div>