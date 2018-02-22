package hangrong.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CrudRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public boolean save(Object object){
        Session session = sessionFactory.getCurrentSession();
        try {
            session.save(object);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean delete(Object object){
        Session session = sessionFactory.getCurrentSession();
        try {
            session.delete(object);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean update(Object object){
        Session session = sessionFactory.getCurrentSession();
        try {
            session.update(object);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
