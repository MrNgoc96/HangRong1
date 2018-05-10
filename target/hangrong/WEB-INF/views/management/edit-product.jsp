<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<!-- /. NAV SIDE  -->
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <a class="btn btn-danger" href="shop-management.html"><i class="fa fa-arrow-circle-left "></i> Quay lại</a>
                <h2 style="text-align: center;font-weight: bold">Sản phẩm ${product.name}</h2>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-9 col-sm-12 col-xs-12">
                <div class="panel-body" id="form-product">
                    <form action="shop-management.html?editProduct"  method="post" enctype="multipart/form-data">
                        <input name="productId" type="hidden" value="${product.id}" />
                        <div id="pro-images" class="row">
                            <c:forEach items="${product.image}" var="image" varStatus="i">
                                <div style="position: relative;" class="img-rmv image col-md-4">
                                    <input type="hidden" value="${i.index}" class="img-path">
                                    <img src="${image}" width="90%" height="90%"
                                         class="img-thumbnail img-rounded img-responsive ">
                                    <c:if test="${image != 'resources/images/default-img.svg'}">
                                        <button type="button" class="btn-danger img-remove"
                                                style="border-radius: 50%;top: 1%;right: 1%;position: absolute;">x
                                        </button>
                                    </c:if>
                                </div>
                            </c:forEach>
                            <input type="hidden" id="remove-images" name="removeImgIndex">
                            <c:forEach begin="${fn:length(product.image)}" end="5" varStatus="i">
                                <div style="position: relative;" class="image col-md-4">
                                    <img style="z-index: 10;" src="http://mfmhyattsville1.org/Images/Dock/ImageUp.png"
                                         width="80%" class="img-thumbnail  img-rounded img-responsive ">
                                    <input class="product-image" name="file"
                                           style="position: absolute;top:0;left: 0;opacity: 0;width: 100%;height: 100%;cursor: pointer"
                                           type="file"
                                           accept=".jpg,.png,.jpeg">
                                </div>
                            </c:forEach>
                        </div>
                        <br>
                        <label>Tên sản phẩm</label>
                        <input name="name" class="form-control" value="${product.name}" id="product-name"/>
                        <div class="input-error" id="error-name">Bạn phải nhập tên cho sản phẩm !</div>
                        <br>
                        <label>Giá sản phẩm</label>
                        <input name="price" value="${product.price}" class="form-control" id="product-price"/>
                        <div class="input-error" id="error-price">Bạn phải nhập giá sản phẩm chính xác ( là số và lớn
                            hơn 0 )!
                        </div>
                        <br>
                        <label>Giới thiệu sản phẩm</label>
                        <textarea name="intro" class="form-control" id="product-intro">${product.intro}</textarea>
                        <div class="input-error" id="error-intro">Bạn phải giới thiệu cho sản phẩm này !</div>
                        <br>
                        <label>Giảm giá (%)</label>
                        <input name="discount" value="${product.discount * 100}" id="product-discount"
                               class="form-control">
                        <div class="input-error" id="error-discount">Bạn phải nhập giảm giá là số và phải lớn hơn hoặc
                            bằng 0 !
                        </div>
                        <br>
                        <input name="detail" type="hidden" id="product-details"/>
                        <a data-toggle="modal" data-target="#details" class="btn btn-primary"><i
                                class="fa fa-pencil"></i> Chỉnh sửa chi tiết</a>
                        <div class="input-error" id="error-detail">Bạn phải nhập thông tin chi tiết cho sản phẩm!</div>
                        <br>
                        <button class="btn btn-lg btn-success" style="margin-left: 35%"><i class="fa fa-save"></i> Cập
                            nhật
                        </button>
                    </form>
                </div>
                <div class="modal" id="details" style="width: 50%;margin: auto;">
                    <div class="modal-header text-center"><h2 style="color: white">Chi tiết sản phẩm</h2></div>
                    <div class="modal-body">
                        <div class="modal-content">
                            <table class="table table-responsive" id="table-details">
                                <tr>
                                    <th>Thông số</th>
                                    <th>Mô tả</th>
                                </tr>
                                <c:forEach items="${product.detail}" var="detail" varStatus="i">
                                    <tr class="detail">
                                        <c:forTokens items="${detail}" delims=":" var="item" varStatus="i">
                                            <c:if test="${i.index == 0}">
                                                <td class="title-detail">${item} :</td>
                                            </c:if>
                                            <c:if test="${i.index == 1}">
                                                <td class="content-detail"><input class="form-control " value="${item}">
                                                </td>
                                            </c:if>
                                        </c:forTokens>
                                        <td>
                                            <button type="button" class="btn btn-danger remove-detail"><i
                                                    class="fa fa-trash"></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<c:if test="${updateSucceed != null}">
    <script>
        showPopup("Thông báo", "Cập nhật thành công sản phẩm <b>${updateSucceed}</b> !");
    </script>
</c:if>
<!-- /. PAGE INNER  -->
</div>
</body>
</html>

