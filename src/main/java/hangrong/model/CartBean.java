package hangrong.model;

import java.util.HashMap;

public class CartBean extends HashMap<String,ProductPTO> {

    public void addProduct(ProductPTO product) {
        String key = product.getProduct().getId();
        if(containsKey(key)) {
            int oldQuantity = ((ProductPTO) get(key)).getQuantity();
            ((ProductPTO) this.get(key)).setQuantity(oldQuantity+1);
        }else {
            put(product.getProduct().getId(),product);
        }
    }
    public void removeProduct(String productId) {
        if(containsKey(productId)) {
            remove(productId);
        }
    }
    public int getTotalPrice() {
        int totalPrice = 0;
        for(String key : this.keySet()) {
            ProductPTO productPTO = this.get(key);
            if(productPTO.getQuantity() > 1) {
                totalPrice += productPTO.getProduct().getPrice() * productPTO.getQuantity();
            }else {
                totalPrice += productPTO.getProduct().getPrice();
            }
        }
        return totalPrice;
    }


}
