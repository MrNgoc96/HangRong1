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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/menu.jsp"/>
<c:if test="${orderSucceed}">
    <script>
        showPopup("Thông báo","Bạn vừa đặt hàng thành công, đơn hàng của bạn đang được chúng tôi xử lý !");
    </script>
</c:if>
<div class="gird ">
    <h4>Đơn đặt hàng gần đây</h4>
    <div class="RecentOrders">
        <table class="table">
            <thead class="thead-dark">
            <tr>
                <th scope="col">Mã đơn hàng</th>
                <th scope="col">Ngày Đặt hàng</th>
                <th scope="col">Tổng tiền</th>
                <th scope="col">Tình trạng</th>
                <th scope="col">Cửa hàng</th>
                <th scope="col">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${orders != null}">
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <th scope="row">ĐH${order.id}</th>
                        <td>${order.orderDate}</td>
                        <td>${order.totalPrice}$</td>
                        <td>${order.status}</td>
                        <td>${order.shop.name}</td>
                        <td>
                            <button type="button" class="btn btn-success" data-toggle="modal"
                                    data-target="#orderDetail" onclick="viewOrder('${order.id}')"
                                    style="width:150px; height:30px;">Chi tiết đơn hàng
                            </button>
                            <button class="btn btn-danger" ${order.status == 'Yêu cầu hủy'?'disabled':''} style="width:150px; height:30px;">Hủy đặt hàng</button>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
        <div class="modal fade" id="orderDetail" tabindex="-1" role="dialog"
              aria-hidden="true" style="width: 50%;">
            <div class="modal-dialog" role="document" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Chi tiết đơn hàng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="orderDetails">
                        <table class="table">
                            <thead>
                            <tr style="text-align: center;">
                                <th scope="col">STT</th>
                                <th scope="col">Hình ảnh</th>
                                <th scope="col">Tên sản phẩm</th>
                                <th scope="col">Giá</th>
                                <th scope="col">Khuyến mại</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${orderDetails}" var="od" varStatus="i">
                                <tr style="text-align: center;">
                                    <th scope="row">${i.index}</th>
                                    <td style="width: 20%;"><img src="${od.product.image[0]}" width="60%"></td>
                                    <td style="width: 40%;color: #1f6377">${od.product.name}</td>
                                    <td style="color: #009B50;">${od.product.price}$</td>
                                    <td style="color: red;"><fmt:formatNumber value="${od.product.discount}" type="percent" /></td>
                                    <td style="color:#2a6496;">${od.quantity}</td>
                                    <td style="color:red;font-weight: bold;">${od.quantity * od.product.newPrice}$</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
