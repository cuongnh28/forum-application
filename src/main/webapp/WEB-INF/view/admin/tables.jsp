<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Start your development with a Dashboard for Bootstrap 4.">
  <meta name="author" content="Creative Tim">
  <title>Quản lý bài đăng</title>
  <!-- Favicon -->
  <link rel="icon" href="admin/img/brand/favicon.png" type="image/png">
  <!-- Fonts -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
  <!-- Icons -->
  <link rel="stylesheet" href="admin/vendor/nucleo/css/nucleo.css" type="text/css">
  <link rel="stylesheet" href="admin/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
  <!-- Argon CSS -->
  <link rel="stylesheet" href="admin/css/argon.css?v=1.2.0" type="text/css">

  <style>
    .modal-dialog{
      max-width: 800px;
    }
    .table td, .table th {
       white-space: normal;
    }
  </style>
</head>

<body>
<!-- Sidenav -->
<nav class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-white" id="sidenav-main">
  <div class="scrollbar-inner">
    <!-- Brand -->
    <div class="sidenav-header  align-items-center">
      <a class="navbar-brand" href="/admin.do">
        <img src="admin/img/brand/blue.png" class="navbar-brand-img" alt="...">
      </a>
    </div>
    <div class="navbar-inner">
      <!-- Collapse -->
      <div class="collapse navbar-collapse" id="sidenav-collapse-main">
        <!-- Nav items -->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="/admin.do">
              <i class="ni ni-tv-2 text-primary"></i>
              <span class="nav-link-text">Dashboard</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="/postPendingTables.do">
              <i class="ni ni-bullet-list-67 text-default"></i>
              <span class="nav-link-text">Tables</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>
<!-- Main content -->
<div class="main-content" id="panel">
  <!-- Topnav -->
  <nav class="navbar navbar-top navbar-expand navbar-dark bg-primary border-bottom">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- Search form -->
<%--        <form class="navbar-search navbar-search-light form-inline mr-sm-3" id="navbar-search-main">--%>
<%--          <div class="form-group mb-0">--%>
<%--            <div class="input-group input-group-alternative input-group-merge">--%>
<%--              <div class="input-group-prepend">--%>
<%--                <span class="input-group-text"><i class="fas fa-search"></i></span>--%>
<%--              </div>--%>
<%--              <input class="form-control" placeholder="Search" type="text">--%>
<%--            </div>--%>
<%--          </div>--%>
<%--          <button type="button" class="close" data-action="search-close" data-target="#navbar-search-main" aria-label="Close">--%>
<%--            <span aria-hidden="true">×</span>--%>
<%--          </button>--%>
<%--        </form>--%>
        <!-- Navbar links -->
        <ul class="navbar-nav align-items-center  ml-md-auto ">
          <li class="nav-item d-xl-none">
            <!-- Sidenav toggler -->
            <div class="pr-3 sidenav-toggler sidenav-toggler-dark" data-action="sidenav-pin" data-target="#sidenav-main">
              <div class="sidenav-toggler-inner">
                <i class="sidenav-toggler-line"></i>
                <i class="sidenav-toggler-line"></i>
                <i class="sidenav-toggler-line"></i>
              </div>
            </div>
          </li>
          <li class="nav-item d-sm-none">
            <a class="nav-link" href="#" data-action="search-show" data-target="#navbar-search-main">
              <i class="ni ni-zoom-split-in"></i>
            </a>
          </li>
        </ul>
        <ul class="navbar-nav align-items-center  ml-auto ml-md-0 ">
          <li class="nav-item dropdown">
            <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <div class="media align-items-center">
                  <span class="avatar avatar-sm rounded-circle">
                    <img alt="Image placeholder" src="../../upload/images/${sessionScope.headUrl}">
                  </span>
                <div class="media-body  ml-2  d-none d-lg-block">
                  <span class="mb-0 text-sm  font-weight-bold">${sessionScope.user.username}</span>
                </div>
              </div>
            </a>
            <div class="dropdown-menu  dropdown-menu-right ">
              <div class="dropdown-header noti-title">
                <h6 class="text-overflow m-0">Welcome!</h6>
              </div>
              <a href="/toMyProfile.do" class="dropdown-item">
                <i class="ni ni-single-02"></i>
                <span>My profile</span>
              </a>
<%--              <a href="#!" class="dropdown-item">--%>
<%--                <i class="ni ni-settings-gear-65"></i>--%>
<%--                <span>Settings</span>--%>
<%--              </a>--%>
<%--              <a href="#!" class="dropdown-item">--%>
<%--                <i class="ni ni-calendar-grid-58"></i>--%>
<%--                <span>Activity</span>--%>
<%--              </a>--%>
<%--              <a href="#!" class="dropdown-item">--%>
<%--                <i class="ni ni-support-16"></i>--%>
<%--                <span>Support</span>--%>
<%--              </a>--%>
              <div class="dropdown-divider"></div>
              <a href="/logout.do" class="dropdown-item">
                <i class="ni ni-user-run"></i>
                <span>Logout</span>
              </a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- Header -->
  <!-- Header -->
  <div class="header bg-primary pb-6">
    <div class="container-fluid">
      <div class="header-body">
        <div class="row align-items-center py-4">
          <div class="col-lg-6 col-7">
            <h6 class="h2 text-white d-inline-block mb-0">Tables</h6>
            <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
              <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i></a></li>
                <li class="breadcrumb-item"><a href="#">Tables</a></li>
                <li class="breadcrumb-item active" aria-current="page">Tables</li>
              </ol>
            </nav>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Page content -->
  <div class="container-fluid mt--6">
    <div class="row">
      <div class="col">
        <div class="card">
          <!-- Card header -->
          <div class="card-header border-0">
            <h3 class="mb-0">Posts need to approve</h3>
          </div>
          <!-- Light table -->
          <div class="table-responsive">
            <table class="table align-items-center table-flush">
              <thead class="thead-light">
              <tr>
                <th scope="col" class="sort" data-sort="name">Name</th>
                <th scope="col" class="sort" data-sort="budget">Topic</th>
                <th scope="col" class="sort" data-sort="status">Created Time</th>
                <th scope="col">Author</th>
                <th scope="col" class="sort" data-sort="completion">Action</th>
<%--                <th scope="col"></th>--%>
              </tr>
              </thead>
              <tbody class="list">
              <c:forEach items="${listPost}" var="post" varStatus="vs">
                <tr>
                <th scope="row">
                  <div class="media align-items-center">
                    <a href="#" class="avatar rounded-circle mr-3">
                      <img alt="Image placeholder" src="admin/img/theme/images.png">
                    </a>
                    <div class="media-body">
                      <button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#myModal${vs.index}">
                        <span class="name mb-0 text-sm">${post.title}</span>
                      </button>
                        <div class="modal fade" id="myModal${vs.index}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">${post.title}</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                  ${post.content}
                              </div>
<%--                              <div class="modal-footer">--%>
<%--                                <form id="acceptPost" action="acceptPost.do" method="post">--%>
<%--                                  <input type="hidden" name="postId" value="${post.postId}">--%>
<%--                                  <button type="button" onclick="accept_post()" class="btn btn-primary" data-dismiss="modal">Accept</button>--%>
<%--                                </form>--%>
<%--                                <form id="rejectPost" action="rejectPost.do" method="post">--%>
<%--                                  <input type="hidden" name="postId" value="${post.postId}">--%>
<%--                                  <button type="button" onclick="reject_post()" class="btn btn-danger" data-dismiss="modal" >Reject</button>--%>
<%--                                </form>--%>
<%--                              </div>--%>
                            </div>
                          </div>
                        </div>
                    </div>
                  </div>
                </th>
                <td class="budget">
                  ${post.topic.name}
                </td>
                <td>
                      <span class="badge badge-dot mr-4">
                        <i class="bg-warning"></i>
                        <span class="format-date">${post.publishTime}</span>
                      </span>
                </td>
                <td>
                  <div class="avatar-group">
                    <a href="#" class="avatar avatar-sm rounded-circle" data-toggle="tooltip" <%-- data-original-title="${post.user.description}" --%>>
                      <img alt="Image placeholder" src="../../upload/images/${post.user.headUrl}" style="height: 100%; object-fit: cover">
                    </a>
                    ${post.user.username}
                  </div>
                </td>
                <td>
                  <div class="d-flex align-items-center">
                    <form action="acceptPost.do" method="post">
                      <input type="hidden" name="postId" value="${post.postId}">
                      <button type="submit" class="btn btn-sm btn-primary mx-2" onclick="return confirm('Are you sure?')">Accept</button>
                    </form>
                    <form action="rejectPost.do" method="post">
                      <input type="hidden" name="postId" value="${post.postId}">
                      <button type="submit" class="btn btn-sm btn-danger mx-2" onclick="return confirm('Are you sure?')">Reject</button>
                    </form>
                  </div>
                </td>
                <td class="text-right">
                  <div class="dropdown">
                    <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                      <a class="dropdown-item" href="#">Accept</a>
                      <a class="dropdown-item" href="#">None</a>
                      <a class="dropdown-item" href="#">Delete</a>
                    </div>
                  </div>
                </td>
              </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
          <!-- Card footer -->
          <div class="card-footer py-4">
            <nav aria-label="...">
              <ul class="pagination justify-content-end mb-0">
                <li class="page-item disabled">
                  <a class="page-link" href="#" tabindex="-1">
                    <i class="fas fa-angle-left"></i>
                    <span class="sr-only">Previous</span>
                  </a>
                </li>
                <li class="page-item active">
                  <a class="page-link" href="#">1</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                </li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#">
                    <i class="fas fa-angle-right"></i>
                    <span class="sr-only">Next</span>
                  </a>
                </li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
    <!-- Footer -->
    <footer class="footer pt-0">
      <div class="row align-items-center justify-content-lg-between">
        <div class="col-lg-6">
          <div class="copyright text-center  text-lg-left  text-muted">
            &copy; 2022 <a href="https://facebook.com/cuongnh28" class="font-weight-bold ml-1" target="_blank">Vito</a>
          </div>
        </div>
        <div class="col-lg-6">
          <ul class="nav nav-footer justify-content-center justify-content-lg-end">
            <li class="nav-item">
              <a href="https://www.creative-tim.com" class="nav-link" target="_blank">Creative Tim</a>
            </li>
            <li class="nav-item">
              <a href="https://www.creative-tim.com/presentation" class="nav-link" target="_blank">About Us</a>
            </li>
            <li class="nav-item">
              <a href="http://blog.creative-tim.com" class="nav-link" target="_blank">Blog</a>
            </li>
            <li class="nav-item">
              <a href="https://github.com/creativetimofficial/argon-dashboard/blob/master/LICENSE.md" class="nav-link" target="_blank">MIT License</a>
            </li>
          </ul>
        </div>
      </div>
    </footer>
  </div>
</div>
<!-- Argon Scripts -->
<!-- Core -->
<script src="admin/vendor/jquery/dist/jquery.min.js"></script>
<script src="admin/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="admin/vendor/js-cookie/js.cookie.js"></script>
<script src="admin/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
<script src="admin/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
<!-- Argon JS -->
<script src="admin/js/argon.js?v=1.2.0"></script>
<script type="text/javascript">

  function accept_post() {
    if (confirm('Are you sure?')) {
      document.getElementById("acceptPost").submit();
    }
  }

  function reject_post() {
    if (confirm('Are you sure?')) {
      document.getElementById("rejectPost").submit();
    }
  }

  <%--    change time format--%>

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