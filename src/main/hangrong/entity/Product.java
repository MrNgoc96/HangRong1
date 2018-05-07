package main.hangrong.entity;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private double price;
    private String image;
    private String intro;
    private String detail;
    private boolean status;
    private int rate;
    private double discount;
    @Column(name = "sale_date")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date saleDate;
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;
    @ManyToOne
    @JoinColumn(name = "shop_id")
    private Shop shop;

    public Product() {
        // TODO Auto-generated constructor stub
    }

    public Product(String name, double price, String image, String intro, String detail, boolean status, Date saleDate, double discount,
                   int rate, Category category, Shop shop) {
        this.name = name;
        this.price = price;
        this.image = image;
        this.intro = intro;
        this.detail = detail;
        this.status = status;
        this.category = category;
        this.shop = shop;
        this.discount = discount;
        this.saleDate = saleDate;
        this.rate = rate;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public double getDiscount() {
        return discount;
    }

    public double getNewPrice() {
        return price * (1 - discount);
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String[] getImage() {
        if(image.equals("")){
            image = "resources/images/default-img.svg;";
        }
        return image.split(";");
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String[] getDetail() {
        return detail.split(";");
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

}
