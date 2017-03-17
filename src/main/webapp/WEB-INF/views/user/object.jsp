<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-md-12">

        <div>
            <div class="row">
                <div class="col-lg-5">
                    <a href="/object/${object.id}/gallery">
                        <img style="width:100%"
                             src="<c:if test="${!empty object.cover.file}">/photo?name=${object.cover.file}</c:if><c:if test="${empty object.cover.file}">/resources/images/noimage.jpg</c:if>"
                             alt="">
                    </a>
                </div>
                <div>
                    <h3 class="object-title">${object.name}</h3>
                    <p>${object.description}</p>
                </div>
            </div>
            <hr>

            <div class="container">
                <div class="col-xs-12">
                    <h1>Bootstrap 3 Thumbnail Slider</h1>

                    <div class="well">
                        <div id="myCarousel" class="carousel slide">

                            <!-- Carousel items -->
                            <div class="carousel-inner">
                                <div class="item active">
                                    <div class="row">
                                        <div class="col-xs-3"><a href="#x"><img src="http://placehold.it/500x500" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x"><img src="http://placehold.it/500x500" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x"><img src="http://placehold.it/500x500" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x"><img src="http://placehold.it/500x500" alt="Image" class="img-responsive"></a>
                                        </div>
                                    </div>
                                    <!--/row-->
                                </div>
                                <!--/item-->
                                <div class="item">
                                    <div class="row">
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                    </div>
                                    <!--/row-->
                                </div>
                                <!--/item-->
                                <div class="item">
                                    <div class="row">
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                        <div class="col-xs-3"><a href="#x" class="thumbnail"><img src="http://placehold.it/250x250" alt="Image" class="img-responsive"></a>
                                        </div>
                                    </div>
                                    <!--/row-->
                                </div>
                                <!--/item-->
                            </div>
                            <!--/carousel-inner--> <a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>

                            <a class="right carousel-control" href="#myCarousel" data-slide="next">›</a>
                        </div>
                        <!--/myCarousel-->
                    </div>
                    <!--/well-->
                </div>
            </div>
</div>
    <script>
        $(document).ready(function() {
            $('#myCarousel').carousel({
                interval: 10000
            })

            $('#myCarousel').on('slid.bs.carousel', function() {
                //alert("slid");
            });


        });

    </script>