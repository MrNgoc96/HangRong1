package main.hangrong.interceptor;

import main.hangrong.entity.Customer;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CustomerInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Customer customer = (Customer) request.getSession().getAttribute("currentUser");
        if(customer==null){
            response.sendRedirect("error.html");
            return false;
        }
        return true;
    }
}
