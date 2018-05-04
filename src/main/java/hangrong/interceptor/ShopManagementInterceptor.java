package hangrong.interceptor;

import hangrong.entity.Shop;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopManagementInterceptor extends HandlerInterceptorAdapter {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Shop shop = (Shop)  request.getSession().getAttribute("currentUser");
        if(shop == null){
            response.sendRedirect("error.html");
            return false;
        }
        return true;
    }
}
