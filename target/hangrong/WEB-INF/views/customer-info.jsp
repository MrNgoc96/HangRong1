<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<html>
<jsp:include page="head.jsp"/>
<body>
<jsp:include page="menu.jsp"/>
<div class="gird ">
    <div class="left">
        <div class="wellcome">
            <h4 style="text-align:center;padding:25px;">Xin chào! Trọng Hậu</h4>
        </div>
    </div>

    <div class="right">
        <ul class="breadcrumb">
            <li><a href="index.html">Home</a> <span class="divider">/</span></li>
            <li class="active">Individual page</li>
        </ul>
        <h4>Quản lý tài khoản</h4>
        <div class="QLTK">
            <div class="personal">
                <div class="stt" style="width:100%;height:30px;position:relative;">
                    <h4>Thông tin cá nhân</h4>
                    <a href="edit.html"><button class="btn btn-success" style="height:50px;width:100px;position:absolute;left:220px;top:1px;">Chỉnh sửa</button></a>
                </div>
                <hr>
                <p>Tên tài khoản: <strong>Tronghau</strong></p>
                <p>Email: <strong>Hauvtph04977@fpt.edu.vn</strong></p>
                <p>Điện thoại: <strong>0986156330</strong></p>
                <hr>
                <a href="#"><p style="color:#F00;font-size:18px">Thay đổi mật khẩu</p></a>
            </div>
            <!-- ...................................................................................-->
            <div class="personal">
                <div class="stt" style="width:100%;height:30px;position:relative;">
                    <h4>Địa chỉ nhận hàng</h4>
                    <p>(Mặc định)</p>
                    <a href="edit.html"><button class="btn btn-success" style="height:50px;width:100px;position:absolute;left:220px;top:1px;">Chỉnh sửa</button></a>
                </div>
                <hr>
                <p>Họ tên: <strong>Vũ Trọng Hậu</strong></p>
                <p>Địa chỉ</p>
                <textarea rows="5" cols="25" style="width:90%;height:120px;margin-left:10px;">Đơn nguyên 1 ,Ký túc xá Mỹ ĐÌnh 2,Đường Hàm nghi,Nam Từ liêm,Hà nội
Hà Nội, Quận Nam Từ Liêm, Phường Mỹ Đình 2</textarea>
                <p>Điện thoại: <strong>0986156330</strong></p>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
