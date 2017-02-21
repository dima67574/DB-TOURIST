<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty success}">
    <div class="alert alert-success alert-styled-left alert-arrow-left alert-bordered">
        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span>
        </button>
            ${success}
    </div>
</c:if>
<div class="col-lg-6">
    test
</div>