package main.hangrong.model;

import main.hangrong.entity.Order;
import main.hangrong.entity.OrderDetail;
import main.hangrong.entity.Product;

import java.util.ArrayList;
import java.util.HashMap;

public class CartBean extends HashMap<String, ProductPTO> {

    public void addProduct(ProductPTO product) {
        String key = "SP"+product.getProduct().getId();
        if (containsKey(key)) {
            int oldQuantity = get(key).getQuantity();
            this.get(key).setQuantity(oldQuantity + 1);
        } else {
            put(key, product);
        }
    }

    public void removeProduct(String productId) {
        if (containsKey(productId)) {
            remove(productId);
        }
    }

    public int getTotalPrice() {
        int totalPrice = 0;
        for (String key : this.keySet()) {
            ProductPTO productPTO = this.get(key);
            if (productPTO.getQuantity() > 1) {
                totalPrice += productPTO.getProduct().getPrice() * productPTO.getQuantity();
            } else {
                totalPrice += productPTO.getProduct().getPrice();
            }
        }
        return totalPrice;
    }

    public ArrayList<Integer> getShopInCart() {
        ArrayList<Integer> shops = new ArrayList<>();
            Object[] keys = this.keySet().toArray();
            for (int i = 0; i < keys.length; i++) {
                int shopI = this.get(keys[i]).getProduct().getShop().getId();
                boolean add = true;
                for (int j = 0; j < keys.length; j++) {
                   int shopJ = this.get(keys[j]).getProduct().getShop().getId();
                    if (shopI==shopJ && i > j) {
                        add = false;
                        break;
                    }
                }
                if (add) shops.add(shopI);
            }
        return shops;
    }

    public ArrayList<OrderDetail> orderDetailForShop(int shopId, Order order) {
        ArrayList<OrderDetail> orderDetails = new ArrayList<>();
        for (String key : this.keySet()) {
            int id = this.get(key).getProduct().getShop().getId();
            if (id == shopId) {
                Product product = this.get(key).getProduct();
                int quantity = this.get(key).getQuantity();
                orderDetails.add(new OrderDetail(order, product, quantity));
            }

        }
        return orderDetails;
    }


}
