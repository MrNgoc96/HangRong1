package main.hangrong.controller;

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
    @Autowired
    private MailService mailService;

    private final String CUSTOMER_INFO_VIEW_NAME = "client-views/customer-info";
    private final String CUSTOMER_ORDER_VIEW_NAME = "client-views/customer-order";
    private final String REGISTER_VIEW_NAME = "client-views/register";
    private final String REDIRECT_CUSTOMER_INFO = "redirect:personal-information.html";
    private final String REDIRECT_CUSTOMER_ORDER = "redirect:orders.html";
    private final String REGISTER_SALE_VIEW_NAME = "client-views/register-sale";

    @GetMapping("/personal-information")
    protected String showPersonalInformation(Model model, HttpSession session) {
        Customer customer = (Customer) session.getAttribute("currentUser");
        model.addAttribute("customer", customer);
        return CUSTOMER_INFO_VIEW_NAME;
    }

    @PostMapping("/personal-information")
    protected String updatePersonalInfomation(RedirectAttributes ra, HttpSession session, @ModelAttribute Customer customer) {
        if (customerDAO.updateCustomer(customer)) {
            ra.addFlashAttribute("editInfoSucceed", true);
        }
        session.setAttribute("currentUser", customer);
        return REDIRECT_CUSTOMER_INFO;
    }

    @PostMapping("/check-password")
    protected String checkPassword(RedirectAttributes ra, HttpSession session, @RequestParam String olderPass) {
        Customer customer = (Customer) session.getAttribute("currentUser");
        User user = userDAO.getUser(customer.getEmail());
        olderPass = userDAO.encryptPassword(olderPass);
        boolean isPassCorrect = olderPass.equals(user.getPassword());
        ra.addFlashAttribute("isPassCorrect", isPassCorrect);
        return REDIRECT_CUSTOMER_INFO;
    }

    @PostMapping("/change-password")
    protected String changePassword(RedirectAttributes ra, HttpSession session, @RequestParam String newPass) {
        Customer customer = (Customer) session.getAttribute("currentUser");
        User user = userDAO.getUser(customer.getEmail());
        newPass = userDAO.encryptPassword(newPass);
        user.setPassword(newPass);
        if (userDAO.updateUser(user)) {
            ra.addFlashAttribute("changePassSucceed", true);
        }
        return REDIRECT_CUSTOMER_INFO;
    }

    @GetMapping("/cancel-order")
    protected String cancelOrder(@RequestParam int orderId, RedirectAttributes ra) {
        Order order = orderDAO.getOrder(orderId);
        order.setStatus("Yêu cầu hủy");
        if (orderDAO.updateOrder(order)) {
            ra.addFlashAttribute("cancelOrder", true);
        }
        return REDIRECT_CUSTOMER_ORDER;
    }

    @GetMapping("/orders")
    protected String showOrdersOfCustomer(Model model, HttpSession session) {
        Customer customer = (Customer) session.getAttribute("currentUser");
        ArrayList<Order> orders = orderDAO.getListOrders(customer.getId(), false);
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
        if (!customerDAO.hasCustomerWithEmail(customer.getEmail())) {
            customerDAO.saveCustomer(customer);
        }
        boolean registerSucceed = userDAO.saveUser(user);
        model.addAttribute("registerSucceed", registerSucceed);
        return REGISTER_VIEW_NAME;
    }

    @PostMapping("/order")
    protected String order(@RequestParam String name, @RequestParam String email, @RequestParam String address, @RequestParam String gender,
                           HttpSession session, RedirectAttributes redirectAttributes) {
        CartBean cart = (CartBean) session.getAttribute("cartBean");
        Customer customer;
        if (customerDAO.hasCustomerWithEmail(email)) {
            customer = customerDAO.getCustomerByEmail(email);
        } else {
            customer = new Customer(email, name, gender, "", new Date(), address);
            customerDAO.saveCustomer(customer);
        }
        ArrayList<Integer> shops = cart.getShopInCart();
        boolean result = false;
        Order newOrder = null;
        for (int shopId : shops) {
            Shop shop = shopDAO.getShop(shopId);
            newOrder = new Order(address, "Đang đặt hàng", new Date(), customer, shop);
            if (orderDAO.saveOrder(newOrder)) {
                ArrayList<OrderDetail> orderDetails = cart.orderDetailForShop(shopId, newOrder);
                for (OrderDetail od : orderDetails) {
                    result = orderDAO.saveOrderDetail(od);
                }
            }
        }
        newOrder = orderDAO.getOrder(newOrder.getId());
        if (result) {
            final String from = "hangrongonline@gmail.com";
            final String to = customer.getEmail();
            final String subject = "Đặt hàng thành công đơn hàng DH" + newOrder.getId();
            final String body = mailService.prepareMail(newOrder);
            Runnable runnable = () -> {
                try {
                    mailService.send(from, to, subject, body, null);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            };
            Thread thread = new Thread(runnable);
            thread.start();
        }
        redirectAttributes.addFlashAttribute("body", mailService.prepareMail(newOrder));
        redirectAttributes.addFlashAttribute("orderSucceed", result);
        return "redirect:home.html";
    }

    @GetMapping("/register-sale")
    protected String showRegisterSalePage(Model model) {
        model.addAttribute("shop", new Shop());
        return REGISTER_SALE_VIEW_NAME;
    }

    @PostMapping("/register-sale")
    protected String registerSale(@ModelAttribute Shop shop, @RequestParam String password, Model model) {
        shop.setJoinDate(new Date());
        shop.setLevel("Mới tham gia");
        shop.setAvatar("http://files.softicons.com/download/business-icons/pretty-office-11-icons-by-custom-icon-design/ico/shop.ico");
        if (shopDAO.getShopByEmail(shop.getEmail()) == null) {
            if (shopDAO.saveShop(shop)) {
                User user = new User(shop.getEmail(), password, "Shop");
                model.addAttribute("registerSucceed", true);
            }
        } else {
            model.addAttribute("emailUsed", true);
        }
        return REGISTER_SALE_VIEW_NAME;
    }

    @GetMapping("/view-order-details")
    protected String viewOrderDerails(@RequestParam int orderId, Model model) {
        ArrayList<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
        model.addAttribute("orderDetails", orderDetails);
        return CUSTOMER_ORDER_VIEW_NAME;
    }


}
