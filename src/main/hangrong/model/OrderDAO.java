package main.hangrong.model;

import main.hangrong.entity.Order;
import main.hangrong.entity.OrderDetail;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
@Transactional
public class OrderDAO {

    @Autowired
    SessionFactory sessionFactory;
    @Autowired
    CrudRepository cr;

    public ArrayList<Order> getOrders(int firstResult, int size) {
        Session session = sessionFactory.getCurrentSession();
        Query<Order> query = session.createQuery("FROM Order");
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Order>) query.list();
    }


    public Order getOrder(int OrderId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Order.class, OrderId);
    }

    public boolean saveOrder(Order order) {
        return cr.save(order);
    }

    public boolean saveOrderDetail(OrderDetail orderDetail) {
        return cr.save(orderDetail);
    }

    public boolean updateOrder(Order order) {
        return cr.update(order);
    }

    public boolean deleteOrder(int orderId) {
        Order order = getOrder(orderId);
        return cr.delete(order);
    }


    public ArrayList<Order> getListOrders(int id,boolean orderOfShop){
        Session session = sessionFactory.getCurrentSession();
        String hql = "";
        if(orderOfShop){
            hql = "SELECT o FROM Order o inner join o.shop s WHERE s.id = :id ";
        }else{
            hql = "SELECT o FROM Order o inner join o.customer c WHERE c.id = :id";
        }
        Query<Order> query = session.createQuery(hql);
        query.setParameter("id",id);
        return (ArrayList<Order>) query.list();
    }

    public ArrayList<Order> searchOrders(String key,String typeSearch,int shopId,int page,int size){
        Session session = sessionFactory.getCurrentSession();
        int firstResult = (page - 1) * size;
        String hql = "";
        switch (typeSearch){
            case "status":
                hql = "SELECT o FROM Order o inner join o.shop s WHERE o.status like :key and s.id = :shopId";
                break;
            case "customerName":
                hql = "SELECT o FROM Order o inner join o.shop s inner join o.customer c where c.name like :key and s.id = :shopId";
                break;
        }
        Query<Order> query = session.createQuery(hql);
        query.setParameter("key",key+"%");
        query.setParameter("shopId",shopId);
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Order>) query.list();
    }

    public int getNumberResultSearchOrder(String key,String typeSearch,int shopId){
        Session session = sessionFactory.getCurrentSession();
        String hql = "";
        switch (typeSearch){
            case "status":
                hql = "SELECT count (o) FROM Order o inner join o.shop s WHERE o.status like :key and s.id = :shopId";
                break;
            case "customerName":
                hql = "SELECT count (o) FROM Order o inner join o.shop s inner join o.customer c where c.name like :key and s.id = :shopId";
                break;
        }
        Query<Long> query = session.createQuery(hql);
        query.setParameter("key",key+"%");
        query.setParameter("shopId",shopId);
        return  (int) (long) query.getSingleResult();
    }

    public ArrayList<OrderDetail> getOrderDetails(int orderId){
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT od FROM OrderDetail od inner join od.order o WHERE o.id = :orderId";
        Query<OrderDetail> query = session.createQuery(hql);
        query.setParameter("orderId",orderId);
        return (ArrayList<OrderDetail>) query.list();
    }


    public String getOrderStatusById(int id){
        switch (id) {
            case 1:
                return  "Đang đặt hàng";
            case 2:
                return "Đang giao hàng";
            case 3:
                return  "Đã nhận hàng";
            case 4:
                return "Yêu cầu hủy";
            default:
                return "";
        }
    }



}
