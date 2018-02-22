package hangrong.controller;


import hangrong.entity.Category;
import hangrong.entity.Order;
import hangrong.entity.Product;
import hangrong.entity.Shop;
import hangrong.model.OrderDAO;
import hangrong.model.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/shop-management")
public class ShopManagementController {

    @Autowired
    ProductDAO productDAO;
    @Autowired
    OrderDAO orderDAO;
    private final int PAGE_SIZE = 4;
    private final String MANAGEMENT_VIEW_NAME = "management/management";

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

    @ModelAttribute(name = "categories")
    protected ArrayList<Category> categories() {
        return productDAO.getAllCategories();
    }

    @GetMapping(params = "newProduct")
    protected String showNewProductPage(Model model, @ModelAttribute ArrayList<Category> categories) {
        model.addAttribute("view", "new-product");
        return MANAGEMENT_VIEW_NAME;
    }

    @GetMapping(params = "editProduct")
    protected String showEditProductPage(HttpSession session, @RequestParam String productId, Model model, @ModelAttribute ArrayList<Category> categories) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        Product product = productDAO.getProduct(productId);
        if (productDAO.isProductofShop(product.getId(), shop.getId())) {
            model.addAttribute("view", "edit-product");
            model.addAttribute("product", product);
        } else {
            model.addAttribute("view", "error");
        }
        return MANAGEMENT_VIEW_NAME;
    }

    @PostMapping(params = "editProduct")
    protected String editProduct(Model model, HttpSession session, @RequestParam String id, @RequestParam String name,
                                 @RequestParam double price, @RequestParam String intro, @RequestParam double discount, @RequestParam String detail) {
        Product product = productDAO.getProduct(id);
        product.setName(name);
        product.setPrice(price);
        product.setIntro(intro);
        product.setDiscount(discount / 100);
        product.setDetail(detail);
        productDAO.updateProduct(product);
        model.addAttribute("product", product);
        model.addAttribute("view", "edit-product");
        model.addAttribute("updateSucceed", name);
        return MANAGEMENT_VIEW_NAME;
    }

    @GetMapping(params = "removeProduct")
    protected String deleteProduct(Model model, @RequestParam String productId, HttpSession session, RedirectAttributes redirectAttributes) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        Product product = productDAO.getProduct(productId);
        String[] productImgLinks = product.getImage();
        if (!productDAO.isProductofShop(productId, shop.getId())) {
            model.addAttribute("view", "error");
            return MANAGEMENT_VIEW_NAME;
        }
        if (productDAO.deleteProduct(productId)) {
            productDAO.removeProductImage(productImgLinks, session.getServletContext());
            redirectAttributes.addFlashAttribute("deleteSucceed", product.getName());
        }
        return "redirect:shop-management.html";
    }

    @PostMapping(params = "addProduct")
    protected String addProduct(Model model, HttpSession session, @RequestParam String name, @RequestParam double price, @RequestParam String intro,
                                @RequestParam MultipartFile[] images, @RequestParam String categoryId, @RequestParam String details) {
        Shop shop = (Shop) session.getAttribute("currentUser");
        Category category = productDAO.getCategory(categoryId);
        Product product = new Product(name, price, "", intro, details, true, new Date(), 0, 0, category, shop);
        String productId = productDAO.saveProduct(product);
        String imageLink = productDAO.uploadImage(productId, images, session.getServletContext());
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
        int numberOrderStatus1 = orderDAO.getNumberResultSearchOrder("Đang đặt hàng","status",shop.getId());
        int numberOrderStatus2 = orderDAO.getNumberResultSearchOrder("Đang giao hàng","status",shop.getId());
        int numberOrderStatus3 = orderDAO.getNumberResultSearchOrder("Đã nhận hàng","status",shop.getId());
        int numberOrderStatus4 = orderDAO.getNumberResultSearchOrder("Yêu cầu hủy","status",shop.getId());
        int totalPages = productDAO.getTotalPages(numberOrders, SIZE);
        model.addAttribute("orders",orders);
        model.addAttribute("orderStatus",orderStatus);
        model.addAttribute("totalPages",totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("view", "orders");
        model.addAttribute("status1",numberOrderStatus1);
        model.addAttribute("status2",numberOrderStatus2);
        model.addAttribute("status3",numberOrderStatus3);
        model.addAttribute("status4",numberOrderStatus4);
        return MANAGEMENT_VIEW_NAME;
    }

    @GetMapping(params = "updateOrderStatus")
    protected String updateOrderStatus(RedirectAttributes ra, int orderId, int statusId) {
        if (statusId > 0 && statusId < 3) {
            statusId++;
            Order order = orderDAO.getOrder(orderId);
            String status = orderDAO.getOrderStatusById(statusId);
            order.setStatus(status + " (Cập nhật :" + new Date() + ")");
            if (orderDAO.updateOrder(order)) ra.addFlashAttribute("updateOrderSucceed", true);
        }
        return "redirect:shop-management.html?managementOrders";
    }

    @GetMapping(params = "deleteOrder")
    protected String deleteOrder(int orderId,RedirectAttributes ra,HttpSession session,Model model){
        Shop shop = (Shop) session.getAttribute("currentUser");
        int shopId = orderDAO.getOrder(orderId).getShop().getId();
        if(shopId!=shop.getId()){
            model.addAttribute("view", "error");
            return MANAGEMENT_VIEW_NAME;
        }
        if(orderDAO.deleteOrder(orderId)){
            ra.addFlashAttribute("deleteOrderSucceed", true);
        }
        return "redirect:shop-management.html?managementOrders";
    }

}
