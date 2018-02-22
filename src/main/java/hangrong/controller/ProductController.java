package hangrong.controller;

import hangrong.entity.Category;
import hangrong.entity.Product;
import hangrong.entity.Shop;
import hangrong.model.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
public class ProductController {

    @Autowired
    ProductDAO productDAO;

    private final int PAGE_SIZE = 6;
    private final String PRODUCT_DETAIL_VIEW_NAME =  "client-views/product-detail";
    private final String PRODUCTS_VIEW_NAME = "client-views/products";

    // Hiển thị chi tiết sản phẩm
    @GetMapping("/products")
    public String showProductDetail(@RequestParam String productId, Model model){
        Product product = productDAO.getProduct(productId);
        Shop shop = product.getShop();
        Category category = product.getCategory();
        ArrayList<Product> relatedProducts = productDAO.searchProduct("",category.getId(),1, PAGE_SIZE); // Lấy danh sách sản phẩm liên quan
        model.addAttribute("product",product);
        model.addAttribute("relatedProducts",relatedProducts);
        model.addAttribute("shop",shop);
        return PRODUCT_DETAIL_VIEW_NAME;
    }

    // Tìm kiếm sản phẩm
    @GetMapping ("/search-product")
    public String searchProduct(@RequestParam String key,@RequestParam String categoryId,@RequestParam(defaultValue = "1") int page,Model model){
        ArrayList<Product> products = productDAO.searchProduct(key,categoryId,page, PAGE_SIZE);
        int totalResults = productDAO.countSearchResults(key,categoryId);
        int totalPages = productDAO.getTotalPages(totalResults, PAGE_SIZE);
        model.addAttribute("products",products);
        model.addAttribute("totalResults",totalResults);
        model.addAttribute("currentPage",page);
        model.addAttribute("key",key);
        model.addAttribute("categoryId",categoryId);
        model.addAttribute("totalPages",totalPages);
        return PRODUCTS_VIEW_NAME;
    }


}
