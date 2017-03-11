<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-md-12">
    <script type="text/JavaScript">
        $(document).ready(function () {
            $("#filter").keyup(function () {
                var filter = $(this).val(), count = 0;

                $(".object-title").each(function () {

                    // If the list item does not contain the text phrase fade it out
                    if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                        $(this).parent().parent().parent().hide();
                    } else {
                        $(this).parent().parent().parent().show();
                        count++;
                    }
                });

                var numberItems = count;
                if(filter.length > 0) {
                    $("#filter-count").text(count > 0 ? "Найдено стилей: " + count : 'Ничего не найдено');
                } else {
                    $("#filter-count").text('');
                }
            });
        });
    </script>
    <div style="margin-bottom: 20px;">
        <input type="text" class="form-control" id="filter" placeholder="Поиск"
               style="width: 50%;display: inline-block;"/>
        <span id="filter-count" style="margin-left: 10px;color: #717171;"></span>
    </div>
    <c:forEach var="e" items="${styles}">
        <div>
            <div class="row">
                <div class="col-md-5">
                    <a href="/style/${e.id}/gallery">
                        <img class="img-responsive"
                             src="<c:if test="${!empty e.cover.file}">/photo?name=${e.cover.file}</c:if><c:if test="${empty e.cover.file}">/resources/images/noimage.jpg</c:if>"
                             alt="">
                    </a>
                </div>
                <div class="col-md-6">
                    <h3 class="object-title">${e.name}</h3>
                    <p>${e.description}</p>
                    <a class="btn btn-primary" href="/style/${e.id}/objects">Показать все объекты <span
                            class="glyphicon glyphicon-chevron-right"></span></a>
                </div>
            </div>
            <hr>
        </div>
    </c:forEach>
</div>