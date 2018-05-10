package hangrong.controller;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import hangrong.entity.Customer;
import hangrong.entity.Shop;
import hangrong.entity.User;
import hangrong.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    @Qualifier("userDAO")
    UserDAO userDAO;
    @Autowired
    @Qualifier("customerDAO")
    CustomerDAO customerDAO;
    @Autowired
    @Qualifier("shopDAO")
    ShopDAO shopDAO;
    @Autowired
    GoogleService googleService;
    @Autowired
    @Qualifier("productDAO")
    ProductDAO productDAO;

    @GetMapping("/login")
    protected String checkViewForUser(HttpSession session) {
        String userRole = session.getAttribute("userRole") + "";
        if (userRole.equals("Shop")) {
            return "redirect:shop-management.html";
        } else if (userRole.equals("Admin")) {
            return "redirect:admin-management.html";
        } else {
            return "redirect:home.html";
        }
    }

    @PostMapping("/login")
    protected String login(@RequestParam String username, @RequestParam String password, RedirectAttributes ra, HttpSession session) {
        if (userDAO.checkLogin(username, password)) {
            checkUserRole(username, session);
        } else {
            ra.addFlashAttribute("message", "Tài khoản hoặc mật khẩu không chính xác !");
        }
        return "redirect:home.html";
    }


    @PostMapping("/google-log-in")
    protected String googleLogin(@RequestParam String idToken, HttpSession session, Model model) {
        GoogleIdToken.Payload payload = googleService.getGoogleUser(idToken);
        String email = payload.getEmail();
        User user = userDAO.getUser(email);
        if (user == null) {
            model.addAttribute("message", email);
        } else {
            checkUserRole(email, session);
            session.setAttribute("googleLogin", true);
        }

        return "index";
    }

    @GetMapping("/log-out")
    protected String logOut(HttpSession session) {
        session.setAttribute("currentUser", null);
        session.setAttribute("googleLogin", null);
        return "redirect:home.html";
    }

    @GetMapping("/google-log-out")
    protected String googleLogOut(HttpSession session) {
        session.setAttribute("googleLogin", null);
        session.setAttribute("currentUser", null);
        return "index";
    }

    private void checkUserRole(String username, HttpSession session) {
        User user = userDAO.getUser(username);
        if (user.getRole().equals("Shop")) {
            Shop shop = shopDAO.getShopByEmail(username);
            session.setAttribute("currentUser", shop);
            session.setAttribute("userRole", "Shop");
        } else if (user.getRole().equals("Customer")) {
            Customer customer = customerDAO.getCustomerByEmail(username);
            session.setAttribute("currentUser", customer);
            session.setAttribute("userRole", "Customer");
        } else {
            session.setAttribute("currentUser", user);
            session.setAttribute("userRole", "Admin");
        }
    }
}
