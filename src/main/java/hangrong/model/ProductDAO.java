package hangrong.model;

import hangrong.entity.Category;
import hangrong.entity.Product;
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
import java.util.List;

@Repository
@Transactional
public class ProductDAO {

    @Autowired
    SessionFactory sessionFactory;

    public ArrayList<Product> getAllProduct(int page, int size) {
        int firstResult = (page-1) * size;
        Session session = sessionFactory.getCurrentSession();
        Query<Product> query = session.createQuery("SELECT p FROM Product p");
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Product>) query.list();
    }

    public ArrayList<Category> getAllCategories(){
        Session session = sessionFactory.getCurrentSession();
        Query<Category> query = session.createQuery("SELECT c FROM Category c");
        return (ArrayList<Category>) query.list();
    }

    public String uploadImage(String productId,MultipartFile[] files, ServletContext context){
        String imageLink = "";
        for(MultipartFile file : files){
            String path = context.getRealPath("resources/images")+"/"+productId+"_"+file.getOriginalFilename();
            try {
                file.transferTo(new File(path));
            } catch (IOException e) {
                e.printStackTrace();
            }
            imageLink += "resources/images/"+productId+"_"+file.getOriginalFilename()+";";
        }
        return imageLink;
    }

    public void removeProductImage(String[] productImgLinks,ServletContext context){
        for(String imgPath : productImgLinks){
            String path = context.getRealPath(imgPath);
            File file = new File(path);
            file.delete();
        }
    }

    public Category getCategory(String categoryId){
        Session session = sessionFactory.getCurrentSession();
        return session.get(Category.class,categoryId);
    }

    public ArrayList<Product> getFeatureProducts(int page, int size) {
        int firstResult = (page-1) * size;
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT p FROM Product p ORDER BY p.rate desc";
        Query<Product> query = session.createQuery(hql);
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Product>) query.list();
    }

    public Product getProduct(String productId) {
        int id = getRealProductId(productId);
        Session session = sessionFactory.getCurrentSession();
        return session.get(Product.class, id);
    }

    public String saveProduct(Product product) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.save(product);
            return product.getId();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public boolean updateProduct(Product product) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.update(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(String productId) {
        Session session = sessionFactory.getCurrentSession();
        try {
            Product product = getProduct(productId);
            session.delete(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<Product> searchProduct(String key, String categoryId, int page, int size) {
        Session session = sessionFactory.getCurrentSession();
        int firstResult = (page - 1) * size;
        String hql = "";
        Query<Product> query;
        if (categoryId.equals("All")) {
            hql = "SELECT p FROM Product p inner join p.category c WHERE p.name like :productName";
            query = session.createQuery(hql);
            query.setParameter("productName", "%" + key + "%");
        } else {
            hql = "SELECT p FROM Product p inner join p.category c WHERE p.name like :productName and c.id = :categoryId";
            query = session.createQuery(hql);
            query.setParameter("productName", "%" + key + "%");
            query.setParameter("categoryId", categoryId);
        }
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Product>) query.list();
    }

    public boolean isProductofShop(String productId,int shopId){
        int id = getRealProductId(productId);
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT p FROM Product p inner join p.shop s WHERE p.id = :productId and s.id = :shopId";
        Query<Product> query = session.createQuery(hql);
        query.setParameter("shopId",shopId);
        query.setParameter("productId",id);
        return query.list().size() > 0;
    }

    public ArrayList<Product> getProductsOfShop(int shopId,int page,int size){
        int firstResult = (page-1) * size;
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT p FROM Product p inner join p.shop s WHERE s.id = :shopId";
        Query<Product> query = session.createQuery(hql);
        query.setParameter("shopId",shopId);
        query.setFirstResult(firstResult);
        query.setMaxResults(size);
        return (ArrayList<Product>) query.list();
    }

    public int getNumberProductsOfShop(int shopId){
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT count(p) FROM Product p inner join p.shop s WHERE s.id = :shopId";
        Query<Long> query = session.createQuery(hql);
        query.setParameter("shopId",shopId);
        return (int) (long) query.getSingleResult();
    }

    public int countTotalProductOfShop(int shopId){
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT count(p) FROM Product p inner join p.shop s WHERE s.id = :shopId";
        Query<Long> query = session.createQuery(hql);
        query.setParameter("shopId",shopId);
        return (int)(long) query.getSingleResult();
    }


    public int countSearchResults(String key, String categoryId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "";
        Query<Long> query;
        if (categoryId.equals("All")) {
            hql = "SELECT count(p) FROM Product p inner join p.category c WHERE p.name like :productName";
            query = session.createQuery(hql);
            query.setParameter("productName", "%" + key + "%");
        } else {
            hql = "SELECT count(p) FROM Product p inner join p.category c WHERE p.name like :productName and c.id = :categoryId";
            query = session.createQuery(hql);
            query.setParameter("productName", "%" + key + "%");
            query.setParameter("categoryId", categoryId);
        }
        return (int) (long) query.getSingleResult();
    }

    public int getTotalPages(int totalResults,int size) {
        int totalPages = totalResults / size;
        if (totalResults % size > 0) {
            return totalPages + 1;
        } else {
            return totalPages;
        }
    }

    public int getRealProductId(String productId){
        return Integer.parseInt(productId.replaceAll("[SP,sp,Sp,sP]", ""));
    }

}
