<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript" src="/resources/vendor/maps/jquery.googlemap.js"></script>
<style>
    .gm-style-iw h1 {
        margin: 0px;
        font-size: 14px;
    }
</style>
<div class="col-md-12">
<div id="map" style="width: 800px; height: 600px;"></div>
<script type="text/javascript">
    $(function() {
        $("#map").googleMap();
        <c:forEach var="o" items="${objects}">
        $("#map").addMarker({
            coords: [${o.xCoordinate}, ${o.yCoordinate}],
            title: '<div><a href="/object/${o.id}">${o.name}</a></div><div style="font-weight:normal;margin:5px 0 5px 0"><a href="/locality/${o.locality.id}">${o.locality.name}</a></div>',
            text:  '<img src="<c:if test="${!empty o.cover.file}">/photo?name=thumb_${o.cover.file}</c:if><c:if test="${empty o.cover.file}">/resources/images/noimage.jpg</c:if>" style="width:230px">'
        });
        </c:forEach>
    })
</script>
</div>