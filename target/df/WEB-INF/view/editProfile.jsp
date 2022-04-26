<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa trang cá nhân</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/editProfile.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="main w clearfix" style="font-size: 15px">
    <div class="edit-header"><i class="fas fa-user" style="color: #00B091"></i>&nbsp;&nbsp;Update Profile</div>
    <form action="uploadImage.do" method="post" enctype="multipart/form-data">
        <div class="row mx-5 align-items-center position-relative">
            <input type="file" class="hidden" name="myFileName" id="photo" accept="image/*"  onchange="picField(this);">
            <input type="hidden" name="addTo" value="avatar">
<%--            <img src="../../upload/images/${user.headUrl}">--%>
            <div class="border rounded-circle" style="width: fit-content">
                <img src="../../upload/images/${user.headUrl}" class="border border-dark rounded-circle" id="output" style="width: 120px; height: 120px; object-fit: cover"/>
            </div>
            <label class="mx-3 position-absolute" for="photo" style="left: 36px; opacity: 20%"><i class="fas fa-camera fa-2x"></i></label>
            <button class="btn text-white mx-5" style="font-size: 15px; background-color: #00B091;">Save Photo</button>
        </div>
    </form>
    <form action="editProfile.do" method="post" class="p-3">

        <div class="form-group row">
            <input type="hidden" name="userId" value="${user.userId}">
            <label for="username" class="col-2 mx-3">Username: </label>
            <input class="form-control col-9 mx-3" type="text" name="username" id="username" value="${user.username}" style="font-size: 15px" />
        </div>

        <div class="form-group row mx-0">
            <div class="row col">
                <label for="dateOfBirth" class="mx-3" style="width: 139.998px">Date of Birth：</label>
                <input class="form-control col-6 mx-3" type="date" id="dateOfBirth" name="dateOfBirth" style="font-size: 15px" />
            </div>

            <div class="row col">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                    <label class="form-check-label" for="inlineRadio1">Male</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                    <label class="form-check-label" for="inlineRadio2">Female</label>
                </div>
            </div>
        </div>



        <div class="form-group row">
            <label for="description" class="col-2 mx-3">Description：</label>
            <input class="form-control col-9 mx-3" type="text" id="description" name="description" value="${user.description}" style="font-size: 15px" />
        </div>

        <div class="form-group row">
            <label for="position" class="col-2 mx-3">Position：</label>
            <input class="form-control col-9 mx-3" type="text" id="position" name="position" value="${user.position}" style="font-size: 15px" />
        </div>

        <div class="form-group row">
            <label for="school" class="col-2 mx-3">School：</label>
            <input class="form-control col-9 mx-3" type="text" id="school" name="school" value="${user.school}" style="font-size: 15px" />
        </div>

        <%--			<div class="edit-title">--%>
        <%--				Last Name：<input type="text" name="lastName" value="${user.fullName.lastName}">--%>
        <%--			</div>--%>
        <%--			<div class="edit-title">--%>
        <%--				First Name：<input type="text" name="firstName" value="${user.fullName.firstName}">--%>
        <%--			</div>--%>

        <div class="form-group row">
            <label for="job" class="col-2 mx-3">Job：</label>
            <input class="form-control col-9 mx-3" type="text" id="job" name="job" value="${user.job}" style="font-size: 15px" />
        </div>
        <div class="form-group" style="margin: 0px 10px">
            <button class="btn text-white" style="font-size: 15px; background-color: #00B091;">Submit</button>
        </div>
    </form>

    <div style="margin-top: 60px;"></div>
    <div class="edit-header"><i class="fas fa-unlock-alt" style="color: #00B091"></i>&nbsp;&nbsp;Change Password</div>
    <form action="updatePassword.do" method="post">

        <div class="text-danger ml-5 mb-3">${passwordError}</div>
        <div class="form-group row">
            <label for="password" class="col-3 mx-3">Current Password: </label>
            <input class="form-control col-8 mx-3" type="password" id="password" name="password" style="font-size: 15px" />
        </div>

        <div class="form-group row">
            <label for="newpassword" class="col-3 mx-3">New Password: </label>
            <input class="form-control col-8 mx-3" type="password" id="newpassword" name="newpassword" style="font-size: 15px" />
        </div>

        <div class="form-group row">
            <label for="repassword" class="col-3 mx-3">Confirm New Password： </label>
            <input class="form-control col-8 mx-3" type="password" id="repassword" name="repassword" style="font-size: 15px" />
        </div>

        <div class="form-group" style="margin: 0px 10px">
            <button class="btn text-white" style="font-size: 15px; background-color: #00B091;">Submit</button>
        </div>

    </form>

</div>


<%@ include file="footer.jsp" %>
<script>

    var loadFile = function(event) {
        var output = document.getElementById('output');
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function() {
            URL.revokeObjectURL(output.src) // free memory
        }
    };

    document.getElementById('photo').onchange = function (evt) {
        var tgt = evt.target || window.event.srcElement,
            files = tgt.files;

        // FileReader support
        if (FileReader && files && files.length) {
            var fr = new FileReader();
            fr.onload = function () {
                document.getElementById(outImage).src = fr.result;
            }
            fr.readAsDataURL(files[0]);
        }

        // Not supported
        else {
            // fallback -- perhaps submit the input to an iframe and temporarily store
            // them on the server until the user's session ends.
        }
    }
</script>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>













