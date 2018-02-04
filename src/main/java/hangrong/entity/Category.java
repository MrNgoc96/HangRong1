package hangrong.entity;


import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="Categories")
public class Category {
	@Id
	@Column(name="id")
	private String id;
	@Column(name="name")
	private String name;
	@Column(name="image")
	private String image;
	@OneToMany(mappedBy="category")
	private List<Product> products;
	
	public Category() {
		// TODO Auto-generated constructor stub
	}
	
	public Category(String id,String name, String image) {
		this.name = name;
		this.image = image;
	}
	public List<Product> getListProduct() {
		return new ArrayList<Product>(products);
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	

}
