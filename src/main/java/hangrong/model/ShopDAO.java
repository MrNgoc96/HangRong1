package hangrong.model;

import hangrong.entity.Shop;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

@Repository("shopDAO")
@Transactional
public class ShopDAO extends CrudRepository {

    @Autowired
    SessionFactory sessionFactory;
    @Autowired
    ServletContext context;


    public String uploadAvatar(MultipartFile image,Shop shop){
        String imageLink = "";
        if(!image.isEmpty()){
            String path = context.getRealPath("resources/images") + "/shop_" + shop.getId() + "_" + image.getOriginalFilename();
            try {
                image.transferTo(new File(path));
                imageLink += "resources/images/shop_" + shop.getId() + "_" + image.getOriginalFilename();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return imageLink;
    }

    public ArrayList<Shop> getShops(int page, int size) {
        int firstResult = (page - 1) * size;
        Session session = sessionFactory.getCurrentSession();
        Query<Shop> query = session.createQuery("FROM Shop");
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Shop>) query.list();
    }

    public Shop getShopByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        try {
            String hql = "SELECT s FROM Shop s WHERE s.email = :email";
            Query<Shop> query = session.createQuery(hql);
            query.setParameter("email", email);
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

    public boolean saveShop(Shop shop) {
        return save(shop);
    }

    public boolean updateShop(Shop shop) {
        return update(shop);
    }

    public boolean deleteShop(int shopId) {
        Shop shop = getShop(shopId);
        return delete(shop);
    }


}
