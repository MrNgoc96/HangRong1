package main.hangrong.entity;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "order_address")
    private String address;
    private String status;
    @Temporal(TemporalType.DATE)
    @Column(name = "order_date")
    private Date orderDate;
    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;
    @ManyToOne
    @JoinColumn(name="shop_id")
    private Shop shop;
    @OneToMany(mappedBy = "order",fetch = FetchType.EAGER,orphanRemoval = true)
    private List<OrderDetail> orderDetails;

    public Order() {
        // TODO Auto-generated constructor stub
    }

    public Order(String address, String status, Date orderDate, Customer customer,Shop shop) {
        this.address = address;
        this.status = status;
        this.orderDate = orderDate;
        this.customer = customer;
        this.shop = shop;
    }

    public ArrayList<OrderDetail> getOrderDetails() {
        return new ArrayList<OrderDetail>(orderDetails);
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderDate() {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(orderDate);
    }

    public int getStatusId(){
        if(status.contains("Đang đặt hàng")){
            return 1;
        }else if(status.contains("Đang giao hàng")){
            return 2;
        }else if(status.contains("Đã giao hàng")){
            return 3;
        }else if(status.contains("Yêu cầu hủy")){
            return 4;
        }else {
            return 0;
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public double getTotalPrice(){
        double total = 0;
        for (OrderDetail od : getOrderDetails()){
            total += od.getProduct().getNewPrice() * od.getQuantity();
        }
        return total;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }


}
