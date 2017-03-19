<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAnonymous()" var="isAnonymous"/>
<c:if test="${!empty success}">
    <div class="alert alert-success alert-styled-left alert-arrow-left alert-bordered">
        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span>
        </button>
            ${success}
    </div>
</c:if>
<div class="col-lg-12">
    <c:if test="${isAnonymous}">
        top 20 from top 50 random. slider
    </c:if>
    <c:if test="${!isAnonymous}">

        <div class="row carousel-holder">

            <div class="col-md-12">
                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <c:forEach var="o" items="${objects}" varStatus="i">
                            <li data-target="#carousel-example-generic" data-slide-to="${i.index}"
                                class="<c:if test="${i.index == 0}">active</c:if>"></li>
                        </c:forEach>
                    </ol>
                    <div class="carousel-inner">
                        <c:forEach var="o" items="${objects}" varStatus="i">
                            <div class="item<c:if test="${i.index == 0}"> active</c:if>">
                                <a href="/object/${o.id}">
                                    <div style="position: absolute;color: #fff;text-align: center;bottom: 0;background: rgba(0, 0, 0, 0.5);padding: 20px;width: 100%;">${o.name}</div>
                                    <img class="slide-image"
                                         src="<c:if test="${!empty o.cover.file}">/photo?name=${o.cover.file}</c:if><c:if test="${empty o.cover.file}">/resources/images/noimage.jpg</c:if>"
                                         alt="">
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                </div>
            </div>

        </div>
    </c:if>
</div>