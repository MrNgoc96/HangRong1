package hangrong.controller;


import hangrong.entity.Product;
import hangrong.model.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;


@Controller
public class HomeController {

    @Autowired
    @Qualifier("productDAO")
    ProductDAO productDAO;
    private final int SIZE = 8;

    @RequestMapping("/")
    protected String redirectToHome() {
        return "redirect:home.html";
    }

    @GetMapping("/home")
    protected String showHomePage (Model model, HttpSession session) {

        ArrayList<Product> newProducts = productDAO.getAllProduct(1,SIZE);
        ArrayList<Product> featureProducts = productDAO.getFeatureProducts(1,6);
        model.addAttribute("newProducts", newProducts);
        model.addAttribute("featureProducts", featureProducts);
        return "index";
    }
    @GetMapping("/error")
    protected String showErrorPage(){
        return "error";
    }


}
