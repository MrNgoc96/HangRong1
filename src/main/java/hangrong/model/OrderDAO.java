package hangrong.model;

import hangrong.entity.Order;
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

    public ArrayList<Order> getOrders(int firstResult,int size) {
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
        Session session = sessionFactory.getCurrentSession();
        try {
            session.save(order);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOrder(Order Order) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.update(Order);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteOrder(int OrderId) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.delete(OrderId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



}
