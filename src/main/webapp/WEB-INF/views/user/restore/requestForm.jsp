<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrapper-page">
    <div class=" card-box">
        <div class="panel-heading">
            <h3 class="text-center"> ${title} </h3>
        </div>
        <div class="panel-body">
            <form class="form-horizontal m-t-20" method="post" action="/restore">

                <c:if test="${!empty info}">
                    <div class="alert alert-info alert-styled-left alert-arrow-left">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span>
                        </button>
                            ${info}
                    </div>
                </c:if>

                <c:if test="${!empty error}">
                    <div class="alert alert-danger alert-styled-left alert-bordered">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span>
                        </button>
                            ${error}
                    </div>
                </c:if>

                <c:if test="${empty info && empty error}">
                    <div class="alert alert-info">
                        Введите <b>Email</b>, привязанный к аккаунту в системе
                    </div>
                </c:if>
                <div class="form-group">
                    <div class="col-xs-12">
                        <input type="email" name="email" class="form-control" placeholder="Email адрес"
                               required="required">
                    </div>
                </div>
                <div class="form-group m-t-20">
                    <div class="col-xs-12">
                        <button type="submit" class="btn btn-inverse btn-block text-uppercase waves-effect waves-light">
                            Восстановить
                        </button>
                    </div>
                </div>


            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 text-center">
            <p>
                <a href="/" class="text-primary m-l-5"><i class="glyphicon glyphicon-circle-arrow-left"></i> <b>На
                    главную</b></a>
            </p>
        </div>
    </div>
</div>