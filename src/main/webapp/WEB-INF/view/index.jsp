<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="main w clearfix">
    <div class="main-left border" style="border-radius: 8px">
        <div class="d-flex justify-content-between align-items-center border-bottom py-3" >
            <p class="mx-4 my-0" style="font-size: 18px"><b><i class="fas fa-circle-notch text-success" ></i> Topic</b></p>
            <c:choose>
                <c:when test="${sessionScope.userId != null}">
                    <a role="button" class="btn btn-success mx-4 px-4" href="toPublish.do" style="font-size: 15px"><i class="fas fa-pencil-alt"></i> Write</a>
                </c:when>
            </c:choose>
        </div>
        <div class="post">
            <div class="post-wrap">
                <ul class="nav nav-tabs" style="font-size: 12px">
                    <li class="nav-item">
                        <a href="#" class="nav-link disabled"><b>Order by: </b></a>
                    </li>
                    <li class="nav-item">
                        <a href="listPostByNewestTime.do?curPage=1"  class="post-choice-current nav-link">Newest</a>
                    </li>
                    <li class="nav-item">
                        <a href="listPostByHottest.do?curPage=1"  class="nav-link ">Hottest</a>
                    </li>
                    <li class="nav-item">
                        <a href="listPostByLatestTime.do?curPage=1"  class="post-choice-last nav-link">Latest</a>
                    </li>
                </ul>

                <ul class="post-list">
                    <c:forEach items="${pageBean.list}" var="post">
                        <li class="">
<%--                            post-up--%>
                            <div class="d-flex align-items-center mb-3">
                                <div class="post-image mx-2">
                                    <a href="toProfile.do?userId=${post.user.userId}">
                                        <img src="../../upload/images/${post.user.headUrl}" style="object-fit: cover; border: 2px solid #3c763d" >
                                    </a>
                                </div>
                                <div class="post-title mx-2">
                                    <a href="toPost.do?postId=${post.postId}" style="font-size: 16px; text-decoration: none; color: #2A2F35"><b>${post.title}</b></a>
                                    <div class="post-username" style="font-size: 12px">
                                        author: <a href="toProfile.do?userId=${post.user.userId}">${post.user.username}</a>
                                    </div>
                                </div>
                            </div>
<%--                            post-down--%>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="row" style="margin-left: 0px">
                                    <div class="border px-2 py-1 mr-2" style="border-radius: 10px">
                                        <a href="listPostByTopic.do?topicId=${post.topic.topicId}"
                                           class="topic-name">Topic: ${post.topic.name}</a>
                                    </div>
                                    <div class="border px-2 py-1 mr-2" style="border-radius: 10px"><p class="format-date">Post Time: ${post.publishTime} </p></div>
                                </div>
                                <div class="d-flex align-items-center ">
                                        <span class="mx-1" style="font-size: 15px">
                                            <i class="far fa-comment-alt"></i><sup><span
                                                class="badge badge-pill badge-success">${post.commentCount}</span></sup>
                                        </span>
                                    <span class="mx-1" style="font-size: 15px">
                                            <i class="far fa-thumbs-up"></i><sup><span
                                            class="badge badge-pill badge-success">${post.likeCount}</span></sup>
                                        </span>
                                    <span class="mx-1" style="font-size: 15px">
                                            <i class="far fa-eye"></i><sup><span
                                            class="badge badge-pill badge-success">${post.postVisitList.size()}</span></sup>
                                        </span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <nav class="col-md-10 col-md-offset-2">
                    <ul class="pagination pagination-sm">
                        <c:choose>
                            <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                <li><a href="listPostByNewestTime.do?curPage=1">Page 1</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                <li><a href="listPostByHottest.do?curPage=1">Page 1</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                <li><a href="listPostByLatestTime.do?curPage=1">Page 1</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${pageBean.curPage != 1 }">
                                <%--                                <li>--%>
                                <%--                                    <a href="listPostByNewestTime.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a>--%>
                                <%--                                </li>--%>
                                <c:choose>
                                    <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                        <li><a href="listPostByNewestTime.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a>
                                        </li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                        <li>
                                            <a href="listPostByHottest.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a>
                                        </li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                        <li><a href="listPostByLatestTime.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a>
                                        </li>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <li><span>&laquo;</span></li>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${pageBean.allPage<=10 }">
                                <c:forEach begin="1" end="${ pageBean.allPage}" var="i">
                                    <%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:when test="${pageBean.curPage<=5 }">
                                <c:forEach begin="1" end="10" var="i">
                                    <%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:when test="${pageBean.allPage-pageBean.curPage<5 }">
                                <c:forEach begin="${pageBean.allPage-9 }" end="${ pageBean.allPage}" var="i">
                                    <%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <c:forEach begin="${pageBean.curPage-4 }" end="${ pageBean.curPage+5}" var="i">--%>
                                    <%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a
                                                    href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${pageBean.curPage!=pageBean.allPage }">
                                <%--                                <li>--%>
                                <%--                                    <a href="listPostByNewestTime.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a>--%>
                                <%--                                </li>--%>
                                <c:choose>
                                    <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                        <li><a href="listPostByNewestTime.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a>
                                        </li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                        <li><a href="listPostByLatestTime.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a>
                                        </li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                        <li>
                                            <a href="listPostByHottest.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a>
                                        </li>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <li><span>&raquo;</span></li>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                <li><a href="listPostByNewestTime.do?curPage=${pageBean.allPage}">All page</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                <li><a href="listPostByLatestTime.do?curPage=${pageBean.allPage}">All page</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                <li><a href="listPostByHottest.do?curPage=${pageBean.allPage}">All page</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                </nav>

            </div>
        </div>
    </div>
    <div class="main-right">

        <div class="hot-user" style="border-radius: 8px">
            <div class="clearfix">
                <div class="hot-user-title"><i class="fab fa-hotjar text-danger"></i>&nbsp;&nbsp;Hot Users</div>
            </div>
            <ul class="hot-user-list">
                <c:forEach items="${hotUserList}" var="user">
                    <li class="clearfix">
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-image">
                            <img src="../../upload/images/${user.headUrl}" style="object-fit: cover; border: 2px solid #761c19" /></a>
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-name text-danger">${user.username}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="hot-user" style="border-radius: 8px">
            <div class="clearfix">
                <div class="hot-user-title"><i class="fas fa-user text-info"></i>&nbsp;&nbsp;New Users</div>
            </div>
            <ul class="hot-user-list">
                <c:forEach items="${newUserList}" var="user">
                    <li class="clearfix">
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-image"><img
                                src="../../upload/images/${user.headUrl}" style="object-fit: cover; border: 2px solid #1e88e5"></a>
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-name text-info">${user.username}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </div>
</div>

<%@ include file="footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript">

    function timeSince(date) {

        var seconds = Math.floor((new Date() - date) / 1000);

        var interval = seconds / 31536000;

        if (interval > 1) {
            return Math.floor(interval) + " years ago";
        }
        interval = seconds / 2592000;
        if (interval > 1) {
            return Math.floor(interval) + " months ago";
        }
        interval = seconds / 86400;
        if (interval > 1) {
            return Math.floor(interval) + " days ago";
        }
        interval = seconds / 3600;
        if (interval > 1) {
            return Math.floor(interval) + " hours ago";
        }
        interval = seconds / 60;
        if (interval > 1) {
            return Math.floor(interval) + " minutes ago";
        }
        return Math.floor(seconds) + " seconds ago";
    }

    for (let i = 0; i < document.querySelectorAll('.format-date').length; i++) {
        document.querySelectorAll('.format-date')[i].innerHTML = timeSince(new Date(document.querySelectorAll('.format-date')[i].innerHTML.split('ICT').join('')))
    }

    $(function () {
        var curPage = ${pageBean.curPage};
        $(".pageNum").each(function () {
            if ($(this).text() == curPage) {
                $(this).addClass("active");
            }
        });
    });

    // $('.nav li').click(function(){
    //     $(this).addClass('active').siblings().removeClass('active');
    // })

</script>
</body>
</html>
