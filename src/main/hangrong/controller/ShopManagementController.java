package main.hangrong.controller;


import hangrong.entity.*;
import main.hangrong.model.OrderDAO;
import main.hangrong.model.ProductDAO;
import main.hangrong.model.ShopDAO;
import main.hangrong.model.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/shop-management")
public class ShopManagementController {

    @Autowired
    ProductDAO productDAO;
    @Autowired
    OrderDAO orderDAO;
    @Autowired
    ShopDAO shopDAO;
    @Autowired
    UserDAO userDAO;
    private final int PAGE_SIZE = 4;
    private final String MANAGEMENT_VIEW_NAME = "management/management";
    private final String REDIRECT_SHOP_MANAGEMENT = "redirect:shop-management.html";

    @GetMapping()
    protected String showShopManagementPage(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session,
                                            @ModelAttribute ArrayList<Category> categories) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        int totalProducts = productDAO.getNumberProductsOfShop(shop.getId());
        ArrayList<Product> products = productDAO.getProductsOfShop(shop.getId(), page, PAGE_SIZE);
        model.addAttribute("products", products);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("view", "products");
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productDAO.getTotalPages(totalProducts, PAGE_SIZE));
        return MANAGEMENT_VIEW_NAME;
    }

    @PostMapping(params = "editInfo")
    protected String editInfomationOfShop(RedirectAttributes ra, @RequestParam String name,
                                          @RequestParam String address, HttpSession session, MultipartFile image) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        String avatar = image.isEmpty() ? shop.getAvatar() : shopDAO.uploadAvatar(image, shop);
        shop.setName(name);
        shop.setAddress(address);
        shop.setAvatar(avatar);
        if (shopDAO.updateShop(shop)) {
            ra.addFlashAttribute("editInfoSucceed", true);
        }
        return REDIRECT_SHOP_MANAGEMENT;
    }

    @PostMapping(params = "search-product")
    protected String searchProduct(@RequestParam String key, @RequestParam(defaultValue = "1") int page, HttpSession session, Model model) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        int totalProducts = productDAO.countSearchProductOfShop(key,shop.getId());
        ArrayList<Product> products = productDAO.searchProductOfShop(key,shop.getId(),page,PAGE_SIZE);
        model.addAttribute("products", products);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("view", "products");
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productDAO.getTotalPages(totalProducts, PAGE_SIZE));
        model.addAttribute("isSearch", true);
        model.addAttribute("key", key);
        return MANAGEMENT_VIEW_NAME;
    }

    @ModelAttribute(name = "categories")
    protected ArrayList<Category> categories() {
        return productDAO.getAllCategories();
    }

    @GetMapping(params = "newProduct")
    protected String showNewProductPage(Model model, @ModelAttribute ArrayList<Category> categories) {
        model.addAttribute("view", "new-product");
        return MANAGEMENT_VIEW_NAME;
    }

    @PostMapping(params = "check-password")
    protected String checkPassword(RedirectAttributes ra, HttpSession session, @RequestParam String olderPass) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        User user = userDAO.getUser(shop.getEmail());
        olderPass = userDAO.encryptPassword(olderPass);
        boolean isPassCorrect = olderPass.equals(user.getPassword());
        ra.addFlashAttribute("isPassCorrect", isPassCorrect);
        return REDIRECT_SHOP_MANAGEMENT;
    }

    @PostMapping(params = "change-password")
    protected String changePassword(RedirectAttributes ra, HttpSession session, @RequestParam String newPass) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        User user = userDAO.getUser(shop.getEmail());
        newPass = userDAO.encryptPassword(newPass);
        user.setPassword(newPass);
        if (userDAO.updateUser(user)) {
            ra.addFlashAttribute("changePassSucceed", true);
        }
        return REDIRECT_SHOP_MANAGEMENT;
    }

    @GetMapping(params = "editProduct")
    protected String showEditProductPage(HttpSession session, @RequestParam String productId, Model model, @ModelAttribute ArrayList<Category> categories) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        Product product = productDAO.getProduct(productId);
        if (product == null) {
            model.addAttribute("view", "error");
            return MANAGEMENT_VIEW_NAME;
        }
        if (productDAO.isProductofShop("SP" + product.getId(), shop.getId())) {
            model.addAttribute("view", "edit-product");
            model.addAttribute("product", product);
        } else {
            model.addAttribute("view", "error");
        }
        return MANAGEMENT_VIEW_NAME;
    }

    @PostMapping(params = "editProduct")
    protected String editProduct(Model model, @RequestParam int productId, @RequestParam String name,
                                 @RequestParam double price, @RequestParam String intro, @RequestParam double discount,
                                 @RequestParam String detail, @RequestParam String removeImgIndex, MultipartHttpServletRequest multipartRequest) {
        Product product = productDAO.getProduct("SP" + productId);
        String productImages = productDAO.removeImageLink(removeImgIndex, product.getImage());
        productImages = productDAO.uploadImage(productImages, product.getId(), multipartRequest.getFiles("file"));
        product.setDiscount(discount / 100);
        product.setImage(productImages);
        product.setName(name);
        product.setPrice(price);
        product.setIntro(intro);
        product.setDetail(detail);
        productDAO.updateProduct(product);
        model.addAttribute("product", product);
        model.addAttribute("view", "edit-product");
        model.addAttribute("updateSucceed", product.getName());
        return MANAGEMENT_VIEW_NAME;
    }

    @GetMapping(params = "removeProduct")
    protected String deleteProduct(Model model, @RequestParam String productId, HttpSession session, RedirectAttributes redirectAttributes) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        Product product = productDAO.getProduct(productId);
        if (product != null) {
            String[] productImgLinks = product.getImage();
            if (!productDAO.isProductofShop(productId, shop.getId())) {
                model.addAttribute("view", "error");
                return MANAGEMENT_VIEW_NAME;
            }
            if (productDAO.deleteProduct(productId)) {
                for (String imgLink : productImgLinks) {
                    productDAO.removeImage(imgLink);
                }
                redirectAttributes.addFlashAttribute("deleteSucceed", product.getName());
            }
        }
        return REDIRECT_SHOP_MANAGEMENT;
    }

    @PostMapping(params = "addProduct")
    protected String addProduct(Model model, HttpSession session, @RequestParam String name, @RequestParam double price, @RequestParam String intro,
                                @RequestParam MultipartFile[] images, @RequestParam String categoryId, @RequestParam String details) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        Category category = productDAO.getCategory(categoryId);
        Product product = new Product(name, price, "", intro, details, true, new Date(), 0, 0, category, shop);
        int productId = productDAO.saveProduct(product);
        List<MultipartFile> productImages = Arrays.asList(images);
        String imageLink = productDAO.uploadImage("", productId, productImages);
        product.setImage(imageLink);
        productDAO.updateProduct(product);
        model.addAttribute("view", "new-product");
        model.addAttribute("addSucceed", product.getName());
        return MANAGEMENT_VIEW_NAME;
    }


    @GetMapping(params = "managementOrders")
    protected String managementOrder(Model model, HttpSession session, @RequestParam(defaultValue = "1") int orderStatus,
                                     @RequestParam(defaultValue = "1") int page) {
        final int SIZE = 6;
        String status = orderDAO.getOrderStatusById(orderStatus);
        Shop shop = (Shop) session.getAttribute("currentUser");
        ArrayList<Order> orders = orderDAO.searchOrders(status, "status", shop.getId(), page, SIZE);
        int numberOrders = orderDAO.getNumberResultSearchOrder(status, "status", shop.getId());
        int numberOrderStatus1 = orderDAO.getNumberResultSearchOrder("Đang đặt hàng", "status", shop.getId());
        int numberOrderStatus2 = orderDAO.getNumberResultSearchOrder("Đang giao hàng", "status", shop.getId());
        int numberOrderStatus3 = orderDAO.getNumberResultSearchOrder("Đã nhận hàng", "status", shop.getId());
        int numberOrderStatus4 = orderDAO.getNumberResultSearchOrder("Yêu cầu hủy", "status", shop.getId());
        int totalPages = productDAO.getTotalPages(numberOrders, SIZE);
        model.addAttribute("orders", orders);
        model.addAttribute("orderStatus", orderStatus);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("view", "orders");
        model.addAttribute("status1", numberOrderStatus1);
        model.addAttribute("status2", numberOrderStatus2);
        model.addAttribute("status3", numberOrderStatus3);
        model.addAttribute("status4", numberOrderStatus4);
        return MANAGEMENT_VIEW_NAME;
    }

    @GetMapping(params = "updateOrderStatus")
    protected String updateOrderStatus(RedirectAttributes ra, int orderId, int statusId) {
        if (statusId > 0 && statusId < 3) {
            statusId++;
            Order order = orderDAO.getOrder(orderId);
            String status = orderDAO.getOrderStatusById(statusId);
            SimpleDateFormat format = new SimpleDateFormat("HH:mm dd/MM/yyyy");
            String date = format.format(new Date());
            order.setStatus(status + " (Cập nhật: " + date + ")");
            if (orderDAO.updateOrder(order)) ra.addFlashAttribute("updateOrderSucceed", true);
        }
        return "redirect:shop-management.html?managementOrders";
    }

    @GetMapping(params = "deleteOrder")
    protected String deleteOrder(int orderId, RedirectAttributes ra, HttpSession session, Model model) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        int shopId = orderDAO.getOrder(orderId).getShop().getId();
        if (shopId != shop.getId()) {
            model.addAttribute("view", "error");
            return MANAGEMENT_VIEW_NAME;
        }
        if (orderDAO.deleteOrder(orderId)) {
            ra.addFlashAttribute("deleteOrderSucceed", true);
        }
        return "redirect:shop-management.html?managementOrders";
    }

}
