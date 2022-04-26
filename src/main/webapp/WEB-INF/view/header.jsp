<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div style="height: 63px">
    <div class="position-fixed w-100 nav nav-tabs d-flex bg-dark text-white justify-content-between"
         style="font-size: 16px; z-index: 10">
        <%--        left        --%>
        <ul class="nav py-3 row align-items-center">
            <li class="nav-item rounded"><a href="toIndex.do" class="text-white" style="font-size: 20px"><b>Home</b></a></li>
            <li class="nav-item rounded"><a href="listTopic.do" class="text-white">Topics</a></li>
            <li class="nav-item rounded"><a href="toLog.do" class="text-white">Activity Log</a></li>
            <c:choose>
                <c:when test="${sessionScope.user != null and sessionScope.user.isAdmin.equalsIgnoreCase('Y')}">
                    <li class="nav-item rounded"><a href="admin.do" class="text-white">Admin</a></li>
                </c:when>
            </c:choose>
        </ul>

        <div class="nav">

            <%--             search         --%>
            <form action="/searchPost.do" method="get" class="row">
                <div class="form-group d-flex align-items-center m-0">
                    <input class="form-control col-8 mx-1" placeholder="title" type="text" style="font-size: 15px" name="searchTemp">
                    <button type="submit" class="btn btn-success col-4 mx-1" style="font-size: 15px">Search</button>
                </div>
            </form>

            <%--          right          --%>
            <ul class="nav align-items-center ml-5">
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <p class="mx-3 my-0">Hi <a href="toMyProfile.do">${sessionScope.user.username}</a>,</p>
                        <div class="dropdown ml-4">
                                <a role="button" class="dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img src="../../upload/images/${sessionScope.user.headUrl}"
                                         style="height: 30px ; width: 30px ;border: 1px solid grey; border-radius: 50%">
                                </a>
                                <div class="dropdown-menu bg-dark" aria-labelledby="dropdownMenuButton"
                                     style="font-size: 14px">
                                    <a class="col-12 text-white d-block my-2" href="toMyProfile.do" style="text-decoration: none">My Profile</a>
                                    <a class="col-12 text-white d-block my-2" href="logout.do" style="text-decoration: none">Log out</a>
                                </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="toLogin.do" class="text-white">Login</a>
                        </li>
                        <%--                        <a href="toLogin.do">/</a>--%>
                        <li>
                            <a href="toLogin.do#register" class="text-white">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <%--            <li><input type="text"></li>--%>
            </ul>
        </div>
    </div>
</div>
