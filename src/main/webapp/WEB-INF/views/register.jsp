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
<jsp:include page="slider.jsp"/>
<div id="mainBody">
    <div class="container">
        <div class="row">
            <jsp:include page="sitebar.jsp"/>
            <div class="span9">
                <ul class="breadcrumb">
                    <li><a href="index.html">Home</a> <span class="divider">/</span></li>
                    <li class="active">Registration</li>
                </ul>
                <h3> Registration</h3>
                <div class="well">
                    <form class="form-horizontal" >
                        <h4>Thông tin cá nhân</h4>

                        <div class="control-group">
                            <label class="control-label">Họ tên <sup>*</sup></label>
                            <div class="controls">
                                <input type="text" class="form-control" id="name" placeholder="Your Name">
                            </div>
                            <br>
                            <div class="control-group">
                                <label class="control-label">Date of Birth <sup>*</sup></label>
                                <div class="controls">
                                    <input type="text" class="form-control" id="datepicker" placeholder="Your Birthday">
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Giới tính <sup>*</sup></label>
                            <div class="controls">
                                <select class="span1" name="days">
                                    <option value="">-</option>
                                    <option value="1">Nam</option>
                                    <option value="2">Nữ</option>
                                    <option value="3">Khác</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input_email">Tài khoản <sup>*</sup></label>
                            <div class="controls">
                                <input type="text" id="input_email" placeholder="Email">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputPassword1">Mật khẩu<sup>*</sup></label>
                            <div class="controls">
                                <input type="password" id="inputPassword1" placeholder="Password">
                            </div>
                        </div>


                        <div class="alert alert-block alert-error fade in">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <strong>Chú ý *</strong> Phần địa chỉ là nơi giao hàng cần phải điền thật chính xác.</div>

                        <h4>Địa chỉ của bạn</h4>
                        <div class="control-group">
                            <label class="control-label" for="address">Địa chỉ<sup>*</sup></label>
                            <div class="controls">
                                <input type="text" id="address" placeholder="Adress"/> <span>số nhà,Xã,huyện,...</span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="city">Thành phố<sup>*</sup></label>
                            <div class="controls">
                                <input type="text" id="city" placeholder="city"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="mobile">Điện thoại </label>
                            <div class="controls">
                                <input type="text"  name="mobile" id="mobile" placeholder="Mobile Phone"/>
                            </div>
                        </div>

                        <p><sup>*</sup>Phần bắt buộc	</p>

                        <div class="control-group">
                            <div class="controls">
                                <button class="btn btn-large btn-success" type="submit" >Register</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script src="resources/js/register.js"></script>
</body>
</html>
