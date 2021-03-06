package hangrong.controller;


import hangrong.entity.Product;
import hangrong.model.CartBean;
import hangrong.model.ProductDAO;
import hangrong.model.ProductPTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class CartController {

    @Autowired
    @Qualifier("productDAO")
    ProductDAO productDAO;

    private final String CART_VIEW_NAME = "client-views/cart";

    @GetMapping("/view-cart")
    public String viewCart() {
        return CART_VIEW_NAME;
    }

    @GetMapping("/add-to-cart")
    public String addToCart(@RequestParam String productId, @RequestParam(defaultValue = "1") int quantity, HttpSession session) {
        CartBean cartBean = (CartBean) session.getAttribute("cartBean");
        if (cartBean == null) {
            cartBean = new CartBean();
        }
        Product product = productDAO.getProduct(productId);
        cartBean.addProduct(new ProductPTO(product, quantity));
        session.setAttribute("cartBean", cartBean);
        return "index";
    }

    @GetMapping("/remove-product")
    public String removeProduct(@RequestParam String productId, HttpSession session) {
        CartBean cartBean = (CartBean) session.getAttribute("cartBean");
        if (cartBean != null) {
            cartBean.removeProduct(productId);
            session.setAttribute("cartBean", cartBean);
        }
        return CART_VIEW_NAME;
    }

    @GetMapping("/update-quantity")
    public String updateQuantity(@RequestParam String productId, @RequestParam boolean increased, HttpSession session) {
        CartBean cartBean = (CartBean) session.getAttribute("cartBean");
        ProductPTO productPTO = cartBean.get(productId);
        if (productPTO == null) {
            return CART_VIEW_NAME;
        }
        cartBean.removeProduct(productId);
        int quantity = productPTO.getQuantity();
        if (increased) {
            if (quantity < 5)
                productPTO.setQuantity(quantity + 1);
        } else {
            if (quantity > 1)
                productPTO.setQuantity(quantity - 1);
        }
        cartBean.addProduct(productPTO);
        session.setAttribute("cartBean", cartBean);
        return CART_VIEW_NAME;
    }

}
