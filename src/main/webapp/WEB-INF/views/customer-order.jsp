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
        <h4>Đơn đặt hàng gần đây</h4>
        <div class="RecentOrders">
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">Mã đơn hàng</th>
                    <th scope="col">Ngày Đặt hàng</th>
                    <th scope="col">Tổng tiền</th>
                    <th scope="col">tình trạng</th>
                    <th scope="col">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">2</th>
                    <td>21/1/2017</td>
                    <td>$700</td>
                    <td>Đã đóng
                        (Giao ngày 23/1/2017)</td>
                    <td><button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal" style="width:150px; height:30px;">Chi tiết đơn hàng</button>
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Chi tiết đơn hàng</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th scope="col">Mã đơn hàng</th>
                                                <th scope="col">Tên sản phẩm</th>
                                                <th scope="col">Hình ảnh</th>
                                                <th scope="col">Tổng tiền</th>
                                                <th scope="col">Ngày Đặt hàng</th>
                                                <th scope="col">Tình trạng</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <th scope="row">#1234567</th>
                                                <td>Máy ảnh kĩ thuật số </td>
                                                <td><img src="themes/images/products/1.jpg"></td>
                                                <td>$500</td>
                                                <td>23/1/2017</td>
                                                <td>Đã đóng</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--/Modal-->
                        <button class="btn btn-danger" style="width:150px; height:30px;">Hủy đơn hàng</button></td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>

<jsp:include page="footer.jsp"/>
</body>
</html>
