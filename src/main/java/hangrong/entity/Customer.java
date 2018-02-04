package hangrong.entity;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Customers")
public class Customer {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	@Column(name = "email", unique = true)
	private String email;
	@Column(name = "name")
	private String name;
	@Column(name = "gender")
	private String gender;
	@Column(name = "phone")
	private String phone;
	@Column(name = "date_of_birth")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date dateOfBirth;
	@Column(name = "address")
	private String address;
	@Column(name = "avatar")
	private String avatar;
	@OneToMany(mappedBy="customer")
	private List<Order> orders;
	@OneToMany(mappedBy = "product")
	private List<Reviews> reviews;

	public Customer() {
		// TODO Auto-generated constructor stub
	}

	public Customer(String email, String name, String gender, String phone, Date dateOfBirth, String address,
			String avatar) {
		this.email = email;
		this.name = name;
		this.gender = gender;
		this.phone = phone;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
		this.avatar = avatar;
	}

	public List<Reviews> getReviews() {
		return reviews;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

}
