<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh mục</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/topic.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="main w">

    <%--    main-left --%>

    <div class="border p-4" style="border-radius: 8px">
        <%--        Topic type--%>
        <div class="my-3">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="" style="width: fit-content">Topic Title</h2>
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <a role="button" class="btn btn-success px-4 py-3" href="#" id="open-mask" style="font-size: 15px"><span class="glyphicon glyphicon-pencil"></span>&nbsp;Up Topic</a>
                    </c:when>
                </c:choose>
            </div>
            <div style="width: 80%; margin: 0 auto">
                <form class="d-flex" action="/searchTopic.do" method="get">
                        <input class="form-control" name='searchTemp' style="margin-right: 10px" type="text" placeholder="Select of your topic" />
                        <button type="button" class="btn btn-primary">
                            <i class="fas fa-search"></i>
                        </button>

                </form>
            </div>
            <h2 class="my-3">Topic Type</h2>
            <div class="row text-center my-3 justify-content-around">
                <div class="col-2 border mx-1 border py-4" style="border-radius: 8px ">
                    <i class="fas fa-file-word pb-2" style="font-size: 40px"></i>
                    <h3>Discussion</h3>
                </div>
                <div class="col-2 border mx-1 border py-4" style="border-radius: 8px ">
                    <i class="far fa-question-circle" style="font-size: 40px"></i>
                    <h3>Question</h3>
                </div>
                <div class="col-2 border mx-1 border py-4" style="border-radius: 8px ">
                    <i class="fas fa-play-circle" style="font-size: 40px"></i>
                    <h3>Video</h3>
                </div>
                <div class="col-2 border mx-1 border py-4" style="border-radius: 8px ">
                    <i class="fas fa-list-ol" style="font-size: 40px"></i>
                    <h3>Other</h3>
                </div>
            </div>
            <div class="my-3">

            </div>
        </div>
        <div>
            <table class="table table-striped" style="font-size: 15px">
                <thead>
                <tr>
                    <th scope="col">Topic</th>
                    <th scope="col">Posts</th>
<%--                    <th scope="col">Comments</th>--%>
                    <th scope="col">Views</th>
<%--                    <th scope="col">Activity</th>--%>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topicList}" var="topic">
                        <tr>
                            <td>
                                <img src="../../upload/images/${topic.image}" class="rounded-circle mr-3" style="width: 50px; height: 50px ; object-fit: cover"/>
                                    <a href="listPostByTopic.do?topicId=${topic.topicId}">
                                            ${topic.name}
                                    </a>
<%--                                    <a href="listPostByTopic.do?topicId=${topic.topicId}">--%>
<%--                                            ${topic.content}--%>
<%--                                    </a>--%>
                            </td>
                            <td class="" style="vertical-align: center">${topic.listPost.size()}</td>
<%--                            <td>5</td>--%>
                            <td>${topic.totalViews}</td>
<%--                            <td>10 hour ago</td>--%>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="mask"></div>
<div class="upon-mask" style="height: fit-content; transform: translateY(-50%)">
    <form action="addTopic.do" enctype="multipart/form-data" method="post" style="font-size: 15px">
            <div class="text-danger mb-3 text-center">${error4}</div>
            <div class="form-group">
                <label for="topic">Topic</label>
                <input type="text" class="form-control w-100" name="name" id="topic" placeholder="Topic here" required>
            </div>
            <div class="form-group">
                <label for="content">Content</label>
                <input type="text" class="form-control w-100" name="content" id="content" placeholder="Content here" required>
            </div>
        <div class="form-group">
            <label for="content">Image</label>
            <input type="file" class="form-control w-100" name="myFileName" id="myFileName" required>
        </div>
        <button type="submit" class="btn btn-success">Upload</button>

    </form>
    <span id="close-mask">×</span>
</div>


<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript">
    $(function () {

        var openMask = $("#open-mask");
        var closeMask = $("#close-mask");
        var mask = $(".mask");
        var uponMask = $(".upon-mask");

        openMask.click(function () {
            mask.show();
            uponMask.show();
        });

        closeMask.click(function () {
            mask.hide();
            uponMask.hide();
        });
    });
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>












