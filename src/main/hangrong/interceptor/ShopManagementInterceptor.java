package main.hangrong.interceptor;


import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopManagementInterceptor extends HandlerInterceptorAdapter {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String userRole = request.getSession().getAttribute("userRole")+"";
        if(!userRole.equals("Shop")){
            response.sendRedirect("error.html");
            return false;
        }
        return true;
    }
}
