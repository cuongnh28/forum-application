<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trang cá nhân</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/profile.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>


</head>
<body>
<%@ include file="header.jsp" %>


<div class="w main">

<%--    wallpaper    --%>
    <div class="border position-relative d-flex justify-content-center align-items-center" style="height: 400px; background-color: #c1c1c1">
        <form action="uploadImage.do" method="post" enctype="multipart/form-data">
            <p class="" style="font-size: 50px"> <b>This is wallpaper</b></p>
            <div class="w-100 h-100 position-absolute" style="top: 0 ; bottom: 0; left: 0; right: 0">
                <img class="w-100 h-100" id="output" src="../../upload/images/${user.cover}" style="width: 100%; height: auto; object-fit: cover"/>
                <input type="file" class="hidden" name="myFileName" id="photo" accept="image/*" onchange="loadFile(event)">
                <input type="hidden" name="addTo" value="cover">
            </div>

            <div class="position-absolute btn-group" role="group" aria-label="Basic example" style="bottom: 20px; right: 20px">
                <label role="button" class="btn" for="photo" style=" font-size: 15px ; background-color: #fff"><i class="fas fa-camera"></i></label>
                <button class="btn btn-secondary text-white" style="font-size: 15px;">Save</button>
            </div>
        </form>
    </div>

<%--    left-content    --%>
    <div class="row">
        <div class="bg-white border border-success row flex-column align-items-center  m-0" style="border-radius: 6px ;width: 30% ;height: 320px; transform: translate(10%,-50%)">
            <img class="rounded-circle my-4"  src="../../upload/images/${user.headUrl}" style="width: 120px;  height: 120px; object-fit:cover; border: 2px solid #28a745">
            <p class="m-0 text-success" style="font-size: 20px"><b>${user.username}</b></p>
            <div class="border-bottom w-75 text-center py-3 mb-4">

            </div>
            <div class="row mt-3 w-100 text-center" style="font-size: 15px">
                <p class="col my-0"><b>Follows</b></p>
                <p class="col my-0"><b>Followers</b></p>
                <p class="col my-0"><b>Posts</b></p>
            </div>
            <div class="row mt-3 w-100 text-center text-success" style="font-size: 15px">
                <p class="col my-0"><b>${user.followCount}</b></p>
                <p class="col my-0"><b>${user.followerCount}</b></p>
                <p class="col my-0"><b>${postList.size()}</b></p>
            </div>
        </div>

<%--        right-bottom-content   --%>
        <div class="col border " style=" margin: 15px 30px 15px 45px ; border-radius: 6px; font-size: 15px; min-height: 400px ; height: fit-content">
            <nav>
                <div class="nav nav-tabs pt-2" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Profile</a>
                    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Posts</a>
                    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Favorite Posts</a>
                    <a class="btn col text-right" href="toEditProfile.do" style="font-size: 15px"><i class="fas fa-cog"></i> Setting</a>
                </div>
            </nav>

<%--            content of tabs--%>
            <div class="tab-content" id="nav-tabContent">
<%--                tab 1--%>
                <div class="tab-pane show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                    <p class="mt-4"><b>Description: </b> ${user.description}</p>
                    <p><b>Position: </b> ${user.position}</p>
                    <p><b>School: </b> ${user.school}</p>
                    <p><b>Job: </b> ${user.job}</p>
                </div>
<%--                tab 2--%>
                <div class="tab-pane" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                    <h3 class="mt-4 pb-2 mb-4 border-bottom">Total Post: <span class="text-success">${postList.size()}</span></h3>

<%--                    list of posts--%>
                    <ul class="user-post-list">
                        <c:forEach items="${postList}" var="post">
                            <li class="my-3 px-4 row justify-content-between">
                                <div class="col">
                                    <i class="far fa-copy"></i>
                                    <a href="toPost.do?postId=${post.postId}"> ${post.title}</a>
                                </div>

                                <p class="format-date">${post.publishTime}</p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
<%--                tab 3--%>
                <div class="tab-pane" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                    <h3 class="mt-4 pb-2">Not interest anythings</h3>
                </div>
            </div>
        </div>
    </div>

</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
<script>

    var loadFile = function(event) {
        var output = document.getElementById('output');
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function() {
            URL.revokeObjectURL(output.src) // free memory
        }
    };

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
</script>
</body>
</html>













