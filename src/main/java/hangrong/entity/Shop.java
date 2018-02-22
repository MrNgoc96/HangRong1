package hangrong.entity;


import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class Shop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "email", unique = true)
    private String email;
    private String name;
    @Column(name = "join_date")
    @Temporal(TemporalType.DATE)
    private Date joinDate;
    private String avatar;
    private String level;
    @OneToMany(mappedBy = "shop")
    private List<Product> products;
    @OneToMany(mappedBy = "shop")
    private List<Order> orders;

    public Shop() {
    }

    public Shop(String email, String name, String avatar, String level) {
        this.email = email;
        this.name = name;
        this.avatar = avatar;
        this.level = level;
    }

    public ArrayList<Order> getOrders() {
        return new ArrayList<Order>(orders);
    }

    public String getJoinDate() {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(joinDate);
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public List<Product> getListProduct() {
        return new ArrayList<Product>(products);
    }

    public void setListProduct(List<Product> listProduct) {
        this.products = listProduct;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }


}
