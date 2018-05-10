package hangrong.model;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;

import hangrong.entity.Order;
import hangrong.entity.OrderDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;

@Service
public class MailService {

    @Autowired
    JavaMailSender mailer;
    @Autowired
    ServletContext context;


    public void send(String from, String to, String subject, String body, File file) throws Exception {
        MimeMessage mail = mailer.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");
        helper.setFrom(from, from);
        helper.setTo(to);
        helper.setReplyTo(from, from);
        helper.setSubject(subject);
        mail.setContent(body, "text/html;charset=utf-8");
        mail.saveChanges();
        if (file != null) {
            helper.addAttachment(file.getName(), file);
        }
        mailer.send(mail);
    }

    public String prepareMail(Order order) {
        StringBuilder contentBuilder = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(context.getRealPath("/resources/mailOrder.html")),"UTF-8"));
            String str;
            while ((str = in.readLine()) != null) {
                contentBuilder.append(str);
            }
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String content = contentBuilder.toString();
        content = content.replace("@customerName", order.getCustomer().getName());
        content = content.replace("@orderId", "DH" + order.getId());
        content = content.replace("@orderDate", order.getOrderDate());
        content = content.replace("@orderAddress", order.getAddress());
        content = content.replace("@phone", order.getCustomer().getPhone());
        content = content.replace("@orderDetail", genOrderDetail(order.getOrderDetails()));
        content = content.replace("@totalOrder", order.getTotalPrice()+"");
        return content;
    }

    public String genOrderDetail(ArrayList<OrderDetail> orderDetails) {
        StringBuilder content = new StringBuilder();
        for (OrderDetail od : orderDetails) {
            content.append("<tr>\n" +
                    "    <th>" + od.getProduct().getName() + "</th>\n" +
                    "   <th>$" + od.getProduct().getPrice() + "</th>\n" +
                    "   <th>" + od.getProduct().getDiscount() * 100 + "%</th>\n" +
                    "   <th>" + od.getQuantity() + "</td>\n" +
                    "   <th>$"+ od.getProduct().getNewPrice() * od.getQuantity()+"</th>\n" +
                    "  </tr>");
        }
        return content.toString();
    }

}
