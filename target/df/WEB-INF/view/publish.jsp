<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đăng bài viết</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/publish.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

</head>
<body>
<%@ include file="header.jsp" %>


	<div class="main w clearfix">
		<form action="publishPost.do" method="post" id="new-post-form">
            <input type="hidden" name="userId" value="${sessionScope.userId}">

			<div class="pub-header"><span></span>&nbsp;Đăng bài viết</div>
			<div class="pub-title">
				<input type="text" name="title" placeholder="Tên bài viết">
			</div>
			<div class="pub-topic">
				<span>Topic：</span>
				<div class="topic-list">
					<c:forEach items="${topicList}" var="topic">
                        <a class="topics" href="#" title="${topic.topicId}" onclick="chooseTopic(this)">${topic.name}</a>
<%--						<input>--%>
                    </c:forEach>
				</div>
			</div>

			<div class="pub-textarea">
				<div style="width: 920px;">
					<textarea name="content" id="input-content" style="height: 300px;max-height: 1000px;"></textarea>
				</div>
                <button class="pub-button">Publish</button>
			</div>
		</form>

	</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/wangEditor.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script src="../../ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function () {
		let form = document.getElementById("new-post-form");
		form.onsubmit = function (ev) {
			ev.preventDefault();
			let selectedTopics = document.getElementsByClassName("selectedTopic");
			let data = {
				title: document.getElementsByName("title")[0].value,
				content: CKEDITOR.instances["input-content"].getData(),
				topic: {topicId: selectedTopics != null && selectedTopics.length > 0 ? selectedTopics[0].getAttribute("title") : null},
				user: {userId: document.getElementsByName("userId")[0].value}
			};

			// validate here
			if (data.title == null || data.title === "") {
				alert("Chưa Nhập Topic");
				return;
			}

			addNewPost(data, "/publishPost.do");
		};
	};

	function addNewPost(post, url) {
		let req = new XMLHttpRequest();
		req.open("POST", url, true);
		req.setRequestHeader("Content-Type", "application/json");
		req.responseType = "text";
		req.onreadystatechange = function () {
			if (this.readyState !== XMLHttpRequest.DONE) {
				return;
			}
			if (this.status !== 200) {
				alert("Vui lòng chọn Topic hoặc xem lại nội dung bài viết.");
			} else {
				window.location = "/toIndex.do";
			}
		};
		req.send(JSON.stringify(post));
	}

	function chooseTopic(topicElement) {
		topicElement.classList.add("selectedTopic");
	}

	CKEDITOR.replace('content');
    $(function(){

        var topics = $(".topics");
        var topicId = $("#topicId");
        topics.click(function () {
            for (var i = 0; i < topics.length; i++) {
                $(topics[i]).css("background-color", "#fff");
            }
            $(this).css("background-color", "#1abc9c");
            topicId.val(this.title);
        });

    });

</script>
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













