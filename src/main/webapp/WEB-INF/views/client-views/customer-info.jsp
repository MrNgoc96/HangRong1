<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/menu.jsp"/>
<div class="gird ">
        <ul class="breadcrumb">
            <li><a href="index.html">Home</a> <span class="divider">/</span></li>
            <li class="active">Individual page</li>
        </ul>
        <h4>Quản lý tài khoản</h4>
        <div class="QLTK">
                    <h4><s:message code="home.personalInfomation"/></h4>
                    <a href="edit.html"><button class="btn btn-success">Chỉnh sửa</button></a>
                <hr>
                <p><s:message code="cart.customerName"/>: <strong>${sessionScope.currentUser.name}</strong></p>
                <p>Email: <strong>${sessionScope.currentUser.email}</strong></p>
                <p><s:message code="register.mobilephone"/>: <strong>${sessionScope.currentUser.phone}</strong></p>
                <hr>
                <button class="btn btn-danger">Thay đổi mật khẩu</button>
        </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
