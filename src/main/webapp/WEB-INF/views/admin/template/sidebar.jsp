<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navbar-default sidebar" role="navigation">
    <div class="sidebar-nav navbar-collapse">
        <ul class="nav" id="side-menu">
            <li>
                <a href="/admin/epoch"><i class="fa fa-calendar fa-fw"></i> Эпохи</a>
            </li>
            <li>
                <a href="/admin/style"><i class="fa fa-folder fa-fw"></i> Стили</a>
            </li>
            <li>
                <a href="/admin/type"><i class="fa fa-folder fa-fw"></i> Типы</a>
            </li>
            <li>
                <a href="/admin/style"><i class="fa fa-tasks fa-fw"></i> Объекты</a>
            </li>
            <li>
                <a href="/admin/users"><i class="fa fa-users fa-fw"></i> Пользователи</a>
            </li>
            <li>
                <a href="#"><i class="fa fa-map-marker fa-fw"></i> Административное деление<span class="fa arrow"></span></a>
                <ul class="nav nav-second-level">
                    <li>
                        <a href="/admin/region">Области</a>
                    </li>
                    <li>
                        <a href="/admin/district">Районы</a>
                    </li>
                    <li>
                        <a href="/admin/locality">Населенные пункты</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="/admin/comment"><i class="fa fa-volume-down fa-fw"></i> Отзывы <span class="label label-primary">2</span></a>
            </li>
            <li>
                <a href="/admin/pages"><i class="fa fa-file-text-o fa-fw"></i> Статические страницы</a>
            </li>
        </ul>
    </div>
    <!-- /.sidebar-collapse -->
</div>
<!-- /.navbar-static-side -->