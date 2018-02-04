package hangrong.controller;


import hangrong.entity.Category;
import hangrong.entity.Product;
import hangrong.entity.Shop;
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
    final int PAGE_SIZE = 4;

    @GetMapping()
    protected String showShopManagementPage(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session,
                                            @ModelAttribute ArrayList<Category> categories){
        Shop shop = (Shop) session.getAttribute("currentUser");
        int totalProducts = productDAO.getNumberProductsOfShop(shop.getId());
        ArrayList<Product> products = productDAO.getProductsOfShop(shop.getId(),page,PAGE_SIZE);
        model.addAttribute("products",products);
        model.addAttribute("totalProducts",totalProducts);
        model.addAttribute("view","products");
        model.addAttribute("currentPage",page);
        model.addAttribute("totalPages",productDAO.getTotalPages(totalProducts,PAGE_SIZE));
        return "management/management";
    }

    @ModelAttribute(name = "categories")
    protected ArrayList<Category> categories(){
        return productDAO.getAllCategories();
    }

    @GetMapping(params = "newProduct")
    protected String showNewProductPage(Model model,@ModelAttribute ArrayList<Category> categories){
        model.addAttribute("view","new-product");
        return "management/management";
    }

    @GetMapping(params = "editProduct")
    protected String showEditProductPage(HttpSession session,@RequestParam String productId,Model model,@ModelAttribute ArrayList<Category> categories){
        Shop shop = (Shop) session.getAttribute("currentUser");
        Product product = productDAO.getProduct(productId);
        if(productDAO.isProductofShop(product.getId(),shop.getId())){
            model.addAttribute("view","edit-product");
            model.addAttribute("product",product);
        }else{
            model.addAttribute("view","error");
        }
        return "management/management";
    }
    @PostMapping(params = "editProduct")
    protected String editProduct(Model model,HttpSession session,@RequestParam String id,@RequestParam String name,
                                 @RequestParam double price,@RequestParam String intro,@RequestParam double discount,@RequestParam String detail ){
        Product product = productDAO.getProduct(id);
        product.setName(name);
        product.setPrice(price);
        product.setIntro(intro);
        product.setDiscount(discount/100);
        product.setDetail(detail);
        productDAO.updateProduct(product);
        model.addAttribute("product",product);
        model.addAttribute("view","edit-product");
        model.addAttribute("updateSucceed",name);
        return "management/management";
    }
    @GetMapping(params = "removeProduct")
    protected String deleteProduct(Model model, @RequestParam String productId, HttpSession session, RedirectAttributes redirectAttributes){
        Shop shop = (Shop) session.getAttribute("currentUser");
        Product product = productDAO.getProduct(productId);
        String[] productImgLinks = product.getImage();
        if(!productDAO.isProductofShop(productId,shop.getId())) {
            model.addAttribute("view","error");
            return "management/management";
        }
        if(productDAO.deleteProduct(productId)){
            productDAO.removeProductImage(productImgLinks,session.getServletContext());
            redirectAttributes.addFlashAttribute("deleteSucceed",product.getName());
        }
        return "redirect:shop-management.html";
    }

    @PostMapping(params = "addProduct")
    protected String addProduct(Model model,HttpSession session, @RequestParam String name, @RequestParam double price, @RequestParam String intro,
                                 @RequestParam MultipartFile[] images,@RequestParam String categoryId,@RequestParam String details){
        Shop shop = (Shop) session.getAttribute("currentUser");
        Category category = productDAO.getCategory(categoryId);
        Product product = new Product(name,price,"",intro, details,true,new Date(),0,0,category,shop);
        String productId = productDAO.saveProduct(product);
        String imageLink = productDAO.uploadImage(productId,images,session.getServletContext());
        product.setImage(imageLink);
        productDAO.updateProduct(product);
        model.addAttribute("view","new-product");
        model.addAttribute("addSucceed",product.getName());
        return "management/management";
    }



}
