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
            <img alt="Icon Inform" src="http://www.franklinlakes.org/vertical/Sites/%7B02E9C1B5-59B4-4B82-8487-CE42C675CF8A%7D/uploads/Information.png">
            <button class="btn btn-danger" id="close-popup">OK</button>
        </div>
    </div>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <c:if test="${sessionScope.userRole=='Shop'}">
                <ul class="nav" id="main-menu">
                    <li class="text-center bg-color-red"><h3 style="font-weight: bold;">${sessionScope.currentUser.name}</h3></li>
                    <li class="text-center">
                        <img src="${sessionScope.currentUser.avatar}" class="user-image img-responsive"/>
                    </li>
                    <li>
                        <a class="${view=='products'||view =='edit-product'? 'active-menu':''}" href="shop-management.html"><i
                                class="fa fa-list fa-3x"></i> Tất cả các sản phẩm</a>
                    </li>
                    <li>
                        <a  class="${view=='orders'? 'active-menu':''}" href="shop-management.html?managementOrders"><i class="fa fa-credit-card fa-3x"></i>Đơn hàng</a>
                    </li>
                    <li>
                        <a class="${view=='new-product'? 'active-menu':''}" href="shop-management.html?newProduct"><i
                                class="fa fa-newspaper-o fa-3x"></i>Thêm sản phẩm mới</a>
                    </li>
                    <li><a href="${googleLogin==true?'#':'log-out.html'}" onclick="${googleLogin==true?'signOut()':''}"><i
                            class="fa fa-sign-out fa-3x"></i> Đăng
                        xuất</a></li>
                </ul>
            </c:if>
            <c:if test="${sessionScope.userRole=='Admin'}">
                <ul class="nav" id="main-menu">
                    <li class="text-center bg-color-red"><h3 style="font-weight: bold;">${sessionScope.currentUser.name}</h3></li>
                    <li class="text-center">
                        <img src="https://www.codetechnology.in/wp-content/uploads/2017/05/user-icon-6.png" class="user-image img-responsive"/>
                    </li>
                    <li>
                        <a class="${view=='users'||view =='edit-product'? 'active-menu':''}" href="shop-management.html"><i
                                class="fa fa-list fa-3x"></i> Quản lý tài khoản</a>
                    </li>
                    <li>
                        <a href="adOrderProduct.html"><i class="fa fa-credit-card fa-3x"></i>Đơn hàng</a>
                    </li>
                    <li><a href="${googleLogin==true?'#':'log-out.html'}" onclick="${googleLogin==true?'signOut()':''}"><i
                            class="fa fa-sign-out fa-3x"></i> Đăng
                        xuất</a></li>
                </ul>
            </c:if>
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
<!-- /. WRAPPER  -->
</body>
</html>

