package hangrong.model;

import hangrong.entity.Shop;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
@Transactional
public class ShopDAO {

    @Autowired
    SessionFactory sessionFactory;

    public ArrayList<Shop> getShops(int page,int size) {
        int firstResult = (page - 1) * size;
        Session session = sessionFactory.getCurrentSession();
        Query<Shop> query = session.createQuery("FROM Shop");
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Shop>) query.list();
    }

    public Shop getShopByEmail(String email){
        Session session = sessionFactory.getCurrentSession();
        try {
            String hql = "SELECT s FROM Shop s WHERE s.email = :email";
            Query<Shop> query = session.createQuery(hql);
            query.setParameter("email",email);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public Shop getShop(int id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Shop.class, id);
    }

    public boolean saveShop(Shop Shop) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.save(Shop);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateShop(Shop shop) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.update(shop);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteShop(int ShopId) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.delete(ShopId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



}
