<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrapper-page">
    <div class=" card-box">
        <div class="panel-heading">
            <h3 class="text-center"> ${title} </h3>
        </div>
        <div class="panel-body">
            <c:if test="${!empty error}">
                <div class="alert alert-danger alert-styled-left alert-bordered">
                    <c:if test="${empty hideForm}">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span>
                        </button>
                    </c:if>
                        ${error}
                </div>
            </c:if>
            <c:if test="${empty hideForm}">
                <form method="post" action="/restore/confirm/${token}" class="form-horizontal m-t-20">
                    <c:if test="${empty error}">
                        <div class="alert alert-info">
                            Введите новый пароль для входа в систему
                        </div>
                    </c:if>
                    <div class="form-group">
                        <div class="col-xs-12">
                            <input class="form-control" id="password" type="password" required="required"
                                   name="password" placeholder="Новый пароль">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12">
                            <input data-parsley-equalto="#password" type="password" class="form-control"
                                   type="confirmPassword" required="required" name="confirmPassword"
                                   placeholder="Новый пароль еще раз">
                        </div>
                    </div>
                    <div class="form-group text-center m-t-20">
                        <div class="col-xs-12">
                            <button class="btn btn-inverse btn-block text-uppercase waves-effect waves-light"
                                    type="submit">Сменить пароль
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>
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