package hangrong.controller;

import hangrong.entity.*;
import hangrong.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;

@Controller
public class CustomerController {

    @Autowired
    private CustomerDAO customerDAO;
    @Autowired
    private UserDAO userDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private ShopDAO shopDAO;

    private final String CUSTOMER_INFO_VIEW_NAME = "client-views/customer-info";
    private final String CUSTOMER_ORDER_VIEW_NAME = "client-views/customer-order";
    private final String REGISTER_VIEW_NAME = "client-views/register";

    @GetMapping("/personal-information")
    protected String showPersonalInformation() {
        return CUSTOMER_INFO_VIEW_NAME;
    }

    @GetMapping("/orders")
    protected String showOrdersOfCustomer(Model model,HttpSession session) {
        Customer customer = (Customer) session.getAttribute("currentUser");
        ArrayList<Order> orders = orderDAO.getListOrders(customer.getId(),false);
        model.addAttribute("orders", orders);
        return CUSTOMER_ORDER_VIEW_NAME;
    }

    @GetMapping("/register")
    protected String showRegisterPage(Model model) {
        model.addAttribute("customer", new Customer());
        return REGISTER_VIEW_NAME;
    }

    @PostMapping("/register")
    protected String register(@ModelAttribute Customer customer, @RequestParam String password, Model model) {
        boolean emailUsed = userDAO.checkEmail(customer.getEmail());
        if (emailUsed) {
            model.addAttribute("emailUsed", emailUsed);
            return REGISTER_VIEW_NAME;
        }
        User user = new User(customer.getEmail(), password, "Customer");
        boolean registerSucceed = customerDAO.saveCustomer(customer);
        if (registerSucceed) userDAO.saveUser(user);
        model.addAttribute("registerSucceed", registerSucceed);
        return REGISTER_VIEW_NAME;
    }

    @PostMapping("/order")
    protected String order(@RequestParam String name, @RequestParam String email, @RequestParam String address, @RequestParam String gender,
                           HttpSession session, RedirectAttributes redirectAttributes) {
        CartBean cart = (CartBean) session.getAttribute("cartBean");
        Customer customer;
        if (userDAO.checkEmail(email)) {
            customer = customerDAO.getCustomerByEmail(email);
        } else {
            customer = new Customer(email, name, gender, "", new Date(), address, "");
            customerDAO.saveCustomer(customer);
        }
        ArrayList<Integer> shops = cart.getShopInCart();
        boolean result = false;
        for (int shopId : shops) {
            Shop shop = shopDAO.getShop(shopId);
            Order newOrder = new Order(address, "Đang đặt hàng", new Date(), customer, shop);
            if (orderDAO.saveOrder(newOrder)) {
                ArrayList<OrderDetail> orderDetails = cart.orderDetailForShop(shopId, newOrder);
                for (OrderDetail od : orderDetails) {
                    result = orderDAO.saveOrderDetail(od);
                }
            }
        }
        session.setAttribute("cartBean",null);
        redirectAttributes.addFlashAttribute("orderSucceed", result);
        return "redirect:orders.html";
    }

    @GetMapping("/view-order-details")
    protected String viewOrderDerails(@RequestParam int orderId,Model model){
        ArrayList<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
        model.addAttribute("orderDetails",orderDetails);
        return CUSTOMER_ORDER_VIEW_NAME;
    }


}
