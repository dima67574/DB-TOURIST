<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-md-4">
    <div id="MainMenu">
        <div class="list-group panel">

            <c:forEach var="r" items="${regions}">
            <a href="#demo${r.id}" class="list-group-item strong" data-toggle="collapse" data-parent="#MainMenu" style="border: none;">
                    ${r.name}
                <i class="fa fa-caret-down"></i></a>
            <div class="collapse" id="demo${r.id}">
                <c:forEach var="d" items="${r.districts}">
                    <a href="/localities/${d.id}" class="list-group-item" >${d.name}</a>
                </c:forEach>
            </div>
            </c:forEach>

        </div>
    </div>
</div>