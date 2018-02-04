package hangrong.controller;


import hangrong.entity.Product;
import hangrong.model.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;


@Controller
public class HomeController {

    @Autowired
    ProductDAO productDAO;

    // Chuyển đến phương thức home
    @RequestMapping("/")
    protected String redirectToHome() {
        return "redirect:home.html";
    }

    @GetMapping("/home") // Hiển thị trang chủ
    protected String home(Model model) {
        ArrayList<Product> newProducts = productDAO.getAllProduct(1,8);
        ArrayList<Product> featureProducts = productDAO.getFeatureProducts(1,6);
        model.addAttribute("newProducts", newProducts);
        model.addAttribute("featureProducts", featureProducts);
        return "index";
    }


}
