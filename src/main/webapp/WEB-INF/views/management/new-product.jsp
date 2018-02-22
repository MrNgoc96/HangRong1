<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<!-- /. NAV SIDE  -->
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2 style="text-align: center;font-weight: bold">Thêm sản phẩm mới</h2>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-9 col-sm-12 col-xs-12">
                <div class="panel-body" id="form-product">
                    <form action="shop-management.html?addProduct" enctype="multipart/form-data" method="post">
                        <c:if test="${productName != null}">
                            <h3 style="color: red">Thêm thành công sản phẩm ${productName}</h3>
                        </c:if>
                        <label>Tên sản phẩm</label>
                        <input name="name" class="form-control" id="product-name"/>
                        <div class="input-error" id="error-name">Bạn phải nhập tên cho sản phẩm !</div>
                        <br>
                        <label>Giá sản phẩm</label>
                        <input name="price" class="form-control" id="product-price"/>
                        <div class="input-error" id="error-price">Bạn phải nhập giá sản phẩm chính xác ( là số và lớn
                            hơn 0 )!
                        </div>
                        <br>
                        <label>Loại sản phẩm</label>
                        <select name="categoryId" class="form-control">
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select><br>
                        <label>Giới thiệu sản phẩm</label>
                        <textarea name="intro" class="form-control" id="product-intro"></textarea>
                        <div class="input-error" id="error-intro">Bạn phải giới thiệu cho sản phẩm này !</div>
                        <br>
                        <label>Ảnh sản phẩm (Ít nhất 2 ảnh và tối đa 6 ảnh)</label>
                        <div id="select-image">
                            <button class="btn btn-primary" type="button" id="label"><i class="fa fa-image"></i> Chọn
                                ảnh
                            </button>
                            <input id="product-images" style="opacity: 0" type="file" name="images"
                                   accept=".jpg,.png,.jpeg" multiple><br>
                        </div>
                        <div class="input-error" id="error-less-image">Bạn phải chọn ít nhất 2 ảnh sản phẩm !</div>
                        <div class="input-error" id="error-more-image">Bạn chỉ có thể chọn tối đa 6 ảnh !</div>
                        <div id="pro-images" class="row"></div>
                        <br>
                        <label>Chi tiết sản phẩm</label>
                        <div class="input-error" id="error-detail">Bạn phải nhập thông tin chi tiết cho sản phẩm!</div>
                        <table class="table table-responsive" id="table-details">
                            <tr>
                                <th>Thông số</th>
                                <th>Mô tả</th>
                            </tr>
                        </table>
                        <input type="hidden" name="details" id="product-details">
                        <table class="table">
                            <tr id="add-detail">
                                <td><input class="form-control" id="param" placeholder="Thông số"></td>
                                <td><input class="form-control" id="description" placeholder="Mô tả"></td>
                                <td>
                                    <button type="button" onclick="addDetail()" class="btn btn-primary"><i
                                            class="fa fa-plus-circle"></i> Thêm
                                    </button>
                                </td>
                            </tr>
                        </table>
                        <button class="btn btn-success" style="margin-left: 35%"><i class="fa fa-plus"></i> Thêm sản
                            phẩm
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<c:if test="${addSucceed != null}">
    <span class="hidden" id="title"><s:message code="shop-management.product.popup-title"/></span>
    <span class="hidden" id="message"><s:message code="shop-management.product.addSucceed"
                                                 arguments="${addSucceed}"/></span>
    <script>
        let title = $('#title').html();
        let msg = $('#message').html();
        showPopup(title, msg);
    </script>
</c:if>
<!-- /. PAGE INNER  -->
</div>
</body>
</html>

