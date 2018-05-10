<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Hàng Rong</title>
    <!-- BOOTSTRAP STYLES-->
    <link href="resources/css/bootstrap.css" rel="stylesheet"/>
    <!-- FONTAWESOME STYLES-->
    <link rel="shortcut icon" href="resources/images/logo.png">
    <link href="resources/css/font-awesome.css" rel="stylesheet"/>
    <!-- CUSTOM STYLES-->
    <link href="resources/css/admin&shop.css" rel="stylesheet"/>
    <link href="resources/css/popup&dialog.css" rel="stylesheet"/>
    <link href="resources/css/morris-0.4.3.min.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/8b4f508587.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
</head>

<body>
<div id="wrapper">
    <div id="popup">
        <div id="popup-message">
            <div id="popup-title">
                <h3>Thông Báo</h3>
            </div>
            <p>Bạn phải nhập mật khẩu !</p>
            <img alt="Icon Inform"
                 src="http://www.franklinlakes.org/vertical/Sites/%7B02E9C1B5-59B4-4B82-8487-CE42C675CF8A%7D/uploads/Information.png">
            <button class="btn btn-danger" id="close-popup">OK</button>
        </div>
    </div>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li class="text-center bg-color-red"><h3
                        style="font-weight: bold;">${sessionScope.currentUser.name}</h3></li>
                <li class="text-center">
                    <img src="${sessionScope.currentUser.avatar}" class="user-image img-responsive"/>
                    <button class="btn btn-success" data-toggle="modal" data-target="#edit-info"><i
                            class="fa fa-pencil"></i>
                    </button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#change-pass"><i
                            class="fa fa-key"></i>
                    </button>
                </li>
                <li>
                    <a class="${view=='products'||view =='edit-product'? 'active-menu':''}"
                       href="shop-management.html"><i
                            class="fa fa-list fa-3x"></i> Tất cả các sản phẩm</a>
                </li>
                <li>
                    <a class="${view=='orders'? 'active-menu':''}" href="shop-management.html?managementOrders"><i
                            class="fa fa-credit-card fa-3x"></i>Đơn hàng</a>
                </li>
                <li>
                    <a class="${view=='new-product'? 'active-menu':''}" href="shop-management.html?newProduct"><i
                            class="fa fa-newspaper-o fa-3x"></i>Thêm sản phẩm mới</a>
                </li>
                <li><a href="${googleLogin==true?'#':'log-out.html'}" onclick="${googleLogin==true?'signOut()':''}"><i
                        class="fa fa-sign-out fa-3x"></i> Đăng
                    xuất</a></li>
            </ul>
        </div>
    </nav>
    <script
            src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="resources/js/popup-dialog.js"></script>
    <script src="resources/js/admin&shop.js"></script>
    <jsp:include page="${view}.jsp"/>
</div>
<div class="modal fade" id="edit-info" tabindex="-1" role="dialog" style="width: 50%;margin: auto;"
     aria-hidden="true" style="width: 50%;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="shop-management.html?editInfo" enctype="multipart/form-data" method="post">
                <input path="id" type="hidden"/>
                <div class="modal-header">
                    <h3 style="text-align: center;color: #2a6496;" class="modal-title" id="exampleModalLabel">Thông tin
                        cửa hàng</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="customer-info">
                    <table class="table">
                        <tr>
                            <td colspan="2" style="text-align: center;"><img class="img-thumbnail" width="30%"
                                                                             id="avatar-shop"
                                                                             src="${sessionScope.currentUser.avatar}">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="position: relative;height: 50px;">
                                <button type="button" style="position: absolute;top:10px;left: 200px;"
                                        class="btn btn-danger"><i class="fa fa-file-photo-o"></i> Thay ảnh
                                </button>
                                <input id="shop-avatar" style="position: absolute;top: 10px;left: 200px;opacity: 0;"
                                       name="image"
                                       type="file">
                            </td>
                        </tr>
                        <tr>
                            <td><b>Tên cửa hàng</b></td>
                            <td><input type="text" value="${sessionScope.currentUser.name}"
                                       class="form-control" name="name"
                                       id="name"/></td>
                        </tr>
                        <tr>
                            <td><b>Địa chỉ</b></td>
                            <td><textarea name="address"
                                          class="form-control">${sessionScope.currentUser.address}</textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">Cập nhật</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="change-pass" tabindex="-1" role="dialog" style="width: 50%;margin: auto;"
     aria-hidden="true" style="width: 50%;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="shop-management.html?change-password" method="post" id="form-change-pass">
                <input path="id" type="hidden"/>
                <div class="modal-header">
                    <h3 style="text-align: center;color: #2a6496;" class="modal-title">Thay đổi mật khẩu</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <img id="loading-pass" style="display: none" src="resources/images/Loading.gif" width="10%">
                                <input value="${isPassCorrect}" type="hidden" id="is-pass-correct">
                                <div class="error" style="color: red;font-weight: bold" id="wrong-pass">Mật khẩu cũ bạn vừa nhập chưa
                                    chính xác !
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Mật khẩu cũ</b>:</td>
                            <td><input class="form-control" type="password" id="older-pass">
                                <div class="error" id="error-older-pass">Bạn phải nhập mật khẩu cũ<br></div>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Mật khẩu mới</b>:</td>
                            <td><input class="form-control" type="password" name="newPass" id="new-pass">
                                <div class="error" id="error-new-pass">Bạn phải nhập mật khẩu mới và độ dài trên 5 ký tự !</div>
                            </td>

                        </tr>
                        <tr>
                            <td><b>Nhập lại mật khẩu</b>:</td>
                            <td><input class="form-control" type="password" id="re-pass">
                                <div class="error" id="error-re-pass">Mật khẩu không trùng khớp !</div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="changePassword()">Cập nhật</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- /. WRAPPER  -->
</body>
</html>

