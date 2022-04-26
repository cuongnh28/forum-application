<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="image/icons/favicon.ico"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="limiter">
    <div class="container-login100 ">
        <div class="wrap-login100">
            <div class="login100-pic js-tilt" data-tilt>
                <img src="image/img-01.png" alt="IMG">
            </div>

            <%--            Login --%>
            <form class="login100-form validate-form" action="login.do" method="post" id="login">
					<span class="login100-form-title">
						Member Login
					</span>

                <div id="error" style="color: red" class="error-message text-center p-0 mb-4">${error}</div>

                <div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                    <input id="login-email" class="input100" type="text" name="email" value="${email}" placeholder="Email" />
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Password is required">
                    <input class="input100" type="password" name="password" placeholder="Password"/>
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
                </div>

                <div class="container-login100-form-btn">
                    <button class="login100-form-btn" type="submit" id="btn">
                        Login
                    </button>
                </div>

                <div class="text-center p-t-12">
						<span class="txt1">
							Forgot
						</span>
                    <a class="txt2" href="#">
                        Username / Password?
                    </a>
                </div>

                <div class="text-center p-t-136">
                    <a class="txt2" id="moveToRegister" href="#" onClick="moveToRegister(event)">
                        Create your Account
                        <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                    </a>
                </div>
            </form>

            <%-- Register --%>
            <form class="login100-form validate-form d-none" action="register.do" method="post" id="register">
					<span class="login100-form-title">
						Create Your Account
					</span>

                <div id="error-message" class="error-message text-center p-0 mb-4">${error}</div>

                <%--                <div class="error-message text-center p-0">${error}</div>--%>

                <div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                    <input id="email" class="input100" type="email" name="email" value="${email}" placeholder="Email" />
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Password is required">
                    <input class="input100" type="password" name="password" placeholder="Password" />
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-lock" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Re-Password is required">
                    <input class="input100" type="password" name="repassword" placeholder="Confirm Your Password" />
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
                </div>

                <div class="container-login100-form-btn">
                    <button class="login100-form-btn">
                        Register
                    </button>
                </div>

                <div class="text-center p-t-136">
                    <a class="txt2" id="moveToLogin" href="#" onclick="moveToLogin(event)">
                        <i class="fa fa-long-arrow-left m-r-5" aria-hidden="true"></i>
                        Have an account ? Login now
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script >
    $('.js-tilt').tilt({
        scale: 1.1
    })

    function moveToRegister(e){
        e.preventDefault();
        document.querySelector('#login').className += ' d-none'
        document.querySelector('#register').classList.remove('d-none')
    }

    function moveToLogin(e){
        e.preventDefault();
        document.querySelector('#register').className += ' d-none'
        document.querySelector('#login').classList.remove('d-none')
    }

</script>
<!--===============================================================================================-->
<%--<script src="js/main.js"></script>--%>




<%--<div class="main w clearfix">--%>
<%--    <div class="buttons clearfix">--%>
<%--        <a href="#" id="login-button" class="selected"><span class="glyphicon glyphicon-user"></span>&nbsp;Login</a>--%>
<%--        <a href="#" id="register-button" class="unselected"><span class="glyphicon glyphicon-pencil"></span>&nbsp;Register</a>--%>
<%--    </div>--%>
<%--    <div class="contents">--%>

<%--        <div id="login-area">--%>
<%--            <form action="login.do" method="post">--%>
<%--                <div class="error-message">${error}</div>--%>
<%--                <div class="email form-group ">--%>
<%--                    <label for="login-email">Email</label>--%>
<%--                    <input id="login-email" type="text" name="email" class="form-control w-100" value="${email}"--%>
<%--                           required>--%>
<%--                </div>--%>
<%--                <div class="password form-group ">--%>
<%--                    <label for="login-password">Password</label>--%>
<%--                    <input type="password" id="login-password" name="password" class="form-control w-100" required>--%>
<%--                </div>--%>
<%--                <div class="row justify-content-center">--%>
<%--                    <button id="login-submit" class="btn col-5 m-0 mx-2 p-0">Login</button>--%>
<%--                    <button type="button" class="btn col-5 m-0 p-0 mx-2" id="forget-password"--%>
<%--                            onclick="location.href='/forgetPassword.do'">Forget Password--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--                &lt;%&ndash;                <input type="button" id="forgetPassword" value="Forget Password" onclick="location.href='/forgetPassword.do'">&ndash;%&gt;--%>
<%--            </form>--%>
<%--        </div>--%>

<%--        <div id="register-area">--%>
<%--            <form action="register.do" method="post">--%>
<%--                <div id="error-message" class="error-message text-center p-0">${error}</div>--%>
<%--                <div class="email form-group">--%>
<%--                    <label for="email">Email</label>--%>
<%--                    <input class="form-control w-100" type="email" name="email" value="${email}" id="email" required/>--%>
<%--                </div>--%>
<%--                <div class="password">--%>
<%--                    <label for="password">Password</label>&nbsp;--%>
<%--                    <input class="form-control w-100" type="password" name="password" id="password" required/>--%>
<%--                </div>--%>
<%--                <div class="password relative clearfix">--%>
<%--                    <label for="repassword">Confirm Password&nbsp;</label>--%>
<%--                    <input class="form-control w-100" type="password" name="repassword" id="repassword" required/>--%>
<%--                </div>--%>
<%--                <button class="w-100 position-static" id="register-submit">Register</button>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>


<%--<%@ include file="footer.jsp" %>--%>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
<%--<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>--%>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="js/tilt.jquery.min.js"></script>


<script type="text/javascript">
    $(function () {
        // var loginButton = $("#login-button");
        // var registerButton = $("#register-button");
        // var lArea = $("#login-area");
        // var rArea = $("#register-area");
        // rArea.hide();
        //
        // loginButton.click(function () {
        //     loginButton.addClass("selected");
        //     loginButton.removeClass("unselected");
        //     registerButton.addClass("unselected");
        //     registerButton.removeClass("selected");
        //     lArea.show();
        //     rArea.hide();
        // });
        //
        // registerButton.click(function () {
        //     registerButton.addClass("selected");
        //     registerButton.removeClass("unselected");
        //     loginButton.addClass("unselected");
        //     loginButton.removeClass("selected");
        //     lArea.hide();
        //     rArea.show();
        // });

        if (location.href.indexOf("#register") >= 0) {
            document.querySelector('#moveToRegister').click();
        } else {
            document.querySelector('#moveToLogin').click();
        }

        <%--var hideInfo = "${register}";--%>
        <%--if (hideInfo != null && hideInfo != "") {--%>
        <%--    registerButton.click();--%>
        <%--}--%>


        // $("#email").blur(function () {
        //     var value = $(this).val();
        //     if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/.test(value)) {
        //         $("#error-message").text("Username or password is wrong.");
        //     } else {
        //         $("#error-message").text("");
        //     }
        // });

        // $("#forget-password").click(function () {
        //     $.click({
        //         type: "GET",
        //         url: "forgetPassword.do",
        //         data: {email: $("#login-email").val()},
        //         success: function (response, status, xhr) {
        //             location.href = "afterForgetPassword.do";
        //         }
        //     });
        // });
    });


</script>

</body>
</html>
