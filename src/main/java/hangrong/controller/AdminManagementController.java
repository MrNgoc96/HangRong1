package hangrong.controller;

import hangrong.model.ShopDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin-management")
public class AdminManagementController {
    @Autowired
    private ShopDAO shopDAO;

    private final String MANAGEMENT_VIEW_NAME = "management/management";

    @GetMapping("")
    protected String showAdminManagementPage(Model model) {
        return "";
    }

}
