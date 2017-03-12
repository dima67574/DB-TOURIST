<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-map/3.0-rc1/jquery.ui.map.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript" src="/resources/vendor/maps/jquery.gmap.min.js"></script>
<style>
    .gm-style-iw h1 {
        margin: 0px;
        font-size: 14px;
    }
</style>
<div class="col-md-12">
<div id="map_canvas" style="width: 100%; height: 800px;"></div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#map_canvas').gMap({
            controls: {
                panControl: false,
                zoomControl: true,
                mapTypeControl: true,
                scaleControl: true,
                streetViewControl: false,
                overviewMapControl: false
            },
            scrollwheel: true,
            markers: [
                <c:forEach var="o" items="${objects}" varStatus="i">
                {
                    latitude: ${o.xCoordinate},
                    longitude: ${o.yCoordinate},
                    html: '<div><a href="/object/${o.id}"><b>${o.name}</b></a></div><div style="font-weight:normal;margin:5px 0 5px 0"><a href="/locality/${o.locality.id}">${o.locality.name}</a></div><img src="<c:if test="${!empty o.cover.file}">/photo?name=thumb_${o.cover.file}</c:if><c:if test="${empty o.cover.file}">/resources/images/noimage.jpg</c:if>" style="width:230px">',
                    popup: false,
                },
                </c:forEach>
            ]
        });

        $('#map_canvas').gMap('centerAt', {
            <c:if test="${!empty xCoordinate && !empty yCoordinate}">
                latitude: ${xCoordinate},
                longitude: ${yCoordinate},
                zoom: 20
            </c:if>
            <c:if test="${empty xCoordinate || empty yCoordinate}">
                latitude: 53.7272,
                longitude: 28.0587,
                zoom: 7
            </c:if>
        });
    });
</script>
</div>