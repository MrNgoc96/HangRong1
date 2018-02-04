package hangrong.controller;

import hangrong.entity.Customer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class CustomerController {

    // Hiển trang thông tin cá nhân của khách hàng
    @GetMapping("/personal-information")
    protected String showPersonalInformation(){
        return "customer-info";
    }

    @GetMapping("/orders")
    protected String showOrdersOfCustomer(){
        return "customer-order";
    }

    @GetMapping("/register")
    protected  String showRegisterPage(Model model, HttpSession session){
        Customer customer = (Customer) session.getAttribute("currentUser");
        return "register";
    }
}
