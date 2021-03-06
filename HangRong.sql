
Create database HANGRONG
go

Use HANGRONG
go

Create table Users (
	username varchar(200) primary key,
	password varchar(200),
	role varchar(30)
)
Create table Categories (
	id varchar(10) primary key,
	name nvarchar(500),
	image varchar(500)
)
Create table Customers (
	id int identity primary key,
	email varchar(200) unique,
	name nvarchar(200),
	gender nvarchar(5),
	phone varchar(15),
	address nvarchar(500),
	date_of_birth datetime,
	avatar varchar(500)
)
Create table Shop (
	id int identity primary key,
	email varchar(200) unique,
	name nvarchar(200),
	join_date datetime,
	avatar varchar(500),
	level nvarchar(500),
)
Create table Products (
	id int identity primary key,
	name nvarchar(500),
	price numeric(9,0),
	image varchar(2000),
	intro nvarchar(4000),
	detail nvarchar(4000),
	status bit,
	rate decimal(5,1),
	discount decimal(2,1),
	sale_date datetime,
	category_id varchar(10) foreign key references Categories (id),
	shop_id int foreign key references Shop (id)  
)
Create table Rate (
	id int identity primary key,
	rate tinyint,
	product_id int foreign key references Products (id),
	customer_id int foreign key references Customers(id)
)
Create table Comments (
	id int identity primary key,
	title nvarchar(1000),
	comment nvarchar(4000),
	product_id int foreign key references Products (id)
)

Create table Orders (
	id int identity primary key,
	order_date datetime,
	order_address nvarchar(500),
	customer_id int foreign key references Customers(id),
	shop_id int foreign key references Shop (id), 
	status nvarchar(200)
)
Create table Order_Detail (
	id int identity primary key,
	order_id int foreign key references Orders (id),
	product_id int foreign key references Products (id),
	quantity int
)

Insert into Users 
Values ('longoc96','96917f9f2174fdb810fc091653116a79705a32c9','Admin')
Insert into Users 
Values ('hauvt98','8cb2237d0679ca88db6464eac60da96345513964','Admin')
Insert into Users 
Values ('ngoclhph05136@fpt.edu.vn','8cb2237d0679ca88db6464eac60da96345513964','Shop')
Insert into Users 
Values ('hauvtph04977@fpt.edu.vn','8cb2237d0679ca88db6464eac60da96345513964','Shop')
Insert into Users 
Values ('duythe98@gmail.com','8cb2237d0679ca88db6464eac60da96345513964','Customer')
Insert into Users 
Values ('doanhuy93@gmail.com','8cb2237d0679ca88db6464eac60da96345513964','Customer')


Insert into Shop
Values ('ngoclhph05136@fpt.edu.vn','Mr Ngoc Shop','2015-10-20','https://f4.bcbits.com/img/0003616747_10.jpg',N'Shop VIP')
Insert into Shop
Values ('hauvtph04977@fpt.edu.vn','Halogen Shop','2016-08-25','https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/1614802/300/200/m1/fpnw/wm0/halogen-shop-logo-3-.jpg?1472752842&s=2091d31342cf5ab6f5af2594bccd4e2a',N'Shop PRO')
Insert into Shop
Values ('thend@fpt.edu.vn','Hebrew Shop','2013-5-25','https://i.pinimg.com/736x/85/94/55/8594553d7d7e514ac4771ee9ff53345b--drink-coffee-coffee-cafe.jpg',N'Shop PRO')
Insert into Shop
Values ('luongtt@fpt.edu.vn','Eozy Shop','2016-5-12','https://i.pinimg.com/280x280_RS/c2/aa/31/c2aa31498eea2497c0b0392e580289df.jpg',N'Shop PRO')


Insert into Customers
Values ('duythe98@gmail.com',N'Nguyễn Duy Thế',N'Nam','01658220250',N'Thái Bình','1998-05-12','');
Insert into Customers
Values ('doanhuy93@gmail.com',N'Đoàn Quốc Huy',N'Nam','01647882510',N'Hải Phòng','1993-03-20','');

Insert into Categories
Values ('TBDT',N'Thiết bị điện tử','')
Insert into Categories
Values ('DGDS',N'Đa dụng,Đời sống','')
Insert into Categories
Values ('TT',N'Thời trang','')
Insert into Categories
Values ('TTDL',N'Thể thao,Du lịch','')
Insert into Categories
Values ('MOTOR',N'Ô tô,Xe máy','')




Insert into Products
Values(N'Apple iPhone X 64GB (Đen nhám)',1000,'https://vn-live-02.slatic.net/p/2/apple-iphone-x-64gb-den-nham-hang-nhap-khau-1509714671-20109302-1b0ef4104d06ef595476b2bad4500927-zoom.jpg;https://vn-live-01.slatic.net/p/2/apple-iphone-x-64gb-den-nham-hang-nhap-khau-1509946257-20109302-f8b292c6e6097386bdd99ba08f621687-zoom.jpg;https://vn-live-02.slatic.net/p/2/apple-iphone-x-64gb-den-nham-hang-nhap-khau-1509946257-20109302-eb194e481894e905cd9df1f29c02d609-zoom.jpg;https://vn-live-01.slatic.net/p/2/apple-iphone-x-64gb-den-nham-hang-nhap-khau-1509946257-20109302-bdc067236825734f722069a3ccd7e15b-zoom.jpg',
       N'Thiết kế lạ mắt không nút Home cứng Điện Thoại iPhone X 64GB là chiếc điện thoại hoàn toàn mới của Apple vừa mới ra mắt tuần vừa qua. Trên cơ bản, iPhone X vẫn có những tính năng như những dòng iPhone khác nhưng thiết kế bên ngoài lạ mắt hơn, không trang bị nút Home cứng, viền kim loại sang trọng và đặc biệt là cụm camera sau được trang bị theo chiều dọc tạo điểm nhấn cho chiếc điện thoại.',
       N'Camera Back:11 to 15MP;Camera trước:7 MP trở lên;Screen Size (inches):5.8;Mẫu mã:iphoneX;Hệ điều hành:iOS;RAM:3GB;Bộ nhớ trong:64GB;Thời gian bảo hành:12 tháng',1,2,0.15,'2017-5-25','TBDT',1)
Insert into Products
Values(N'Samsung Galaxy Note 8 64GB (Đen)',950,'https://vn-live-02.slatic.net/p/2/samsung-galaxy-note-8-64gb-den-hang-nhap-khau-1513175474-73088751-3542287a4ad19520501e2d9a3fbcab64-zoom.jpg;https://vn-live.slatic.net/v2/resize/products/S-12792-084259971dadfbe84a502cffbb5db15f.jpg;https://vn-live.slatic.net/v2/resize/products/S-12792-eab2646e9a4a80c898758668000aec46.jpg',
       N'Nếu đã từng sử dụng series Galaxy Note của Samsung, bạn chắc chắn sẽ không thể bỏ qua siêu phẩm lần này. So với trước kia, Galaxy Note 8 sở hữu các đặc tính chưa từng xuất hiện, chẳng hạn camera kép, bút S-Pen hỗ trợ hàng loạt thao tác nhanh, dock DeX cho công việc cũng như được kiểm định cực gắt gao nhằm đảm bảo tối đa sự an toàn cho khách hàng.;Chiếc Galaxy Note có màn hình lớn nhất từ trước đến nay sẽ đưa bạn đến những trải nghiệm rộng lớn chưa từng có. Với màn hình vô cực lên tới 6.3 inch, Galaxy Note 8 đã phá vỡ mọi giới hạn. Nhưng điều tuyệt vời hơn là mọi thứ vẫn vừa vặn khi trong tay bạn là một chiếc máy màn hình cong không viền đẳng cấp.;Camera Samsung Galaxy Note 8 có khả năng lấy nét trực tiếp. Nghĩa là bạn có thể chụp ảnh xóa phông, làm nổi bật chủ thể và mờ hậu cảnh. Nhưng đặc biệt hơn là ngay cả sau khi chụp, bạn vẫn dễ dàng điều chỉnh được vị trí lấy nét, độ mờ cho đến khi thực sự hài lòng.',
       N'Screen Size (inches):5.8;Mẫu mã:samsung galaxy note 8;Hệ điều hành:Android 7.0;RAM:3GB;Bộ nhớ trong:64GB;Thời gian bảo hành:12 tháng',1,3,0.05,'2017-8-25','TBDT',1)
Insert into Products
Values(N'Dàn âm thanh Blu-ray 5.1 Sony BDV-E4100',500,'https://vn-live-03.slatic.net/p/2/dan-am-thanh-blu-ray-51-sony-bdv-e4100-1450122879-53957-1-zoom.jpg;https://vn-live-01.slatic.net/p/2/dan-am-thanh-blu-ray-51-sony-bdv-e4100-1450122879-53957-2-zoom.jpg',
       N'Việc đầu tư một dàn âm thanh hoành tráng như trong rạp chiếu phim không phải là điều dễ dàng đối với hầu hết gia chủ, ngay cả khi hầu bao rủng rỉnh. Đó chính là lý do để những dàn âm thanh rạp hát tại gia “lên ngôi”. Sony BDV-E4100 là một trong những sản phẩm đáp ứng tốt xu hướng giải trí này, và được các gia đình đặc biệt ưa chuộng. Dàn âm thanh rạp hát tại gia Sony BDV-E4100 bao gồm đầu đĩa Blu-ray, và hệ thống loa 5.1 kênh hứa hẹn sẽ mang lại cho bạn những trải nghiệm hình ảnh và âm thanh sống động. ',
       N'SKU:SO993ELABMLBANVN-78471;Chứng nhận:Certificate of Origin;Màu:Đen;Cổng kết nối:1 x USB, 1 x Ethernet, 1 x HDMI;Độ phân giải màn hình (pixels):Full HD 1080p;Kích thước sản phẩm (D x R x C cm):108.2 x 34.9 x 30.2 cm;Loiaj:blu-ray 3d;Trọng lượng(Kg):18.5;Sản xuất tại: Malaysia; Thời gian bảo hành:12 tháng;Loại hình bảo hành: Invoice',1,5,0.05,'2017-10-10','TBDT',1)
Insert into Products
Values(N'Máy ảnh KTS Sony DSC-H300',350,'https://vn-live-02.slatic.net/p/2/may-anh-kts-sony-cyber-shot-dsc-h400-201mp-va-zoom-quang-63x-den-1475131141-8901571-2f3823b8a37e25f2f3040bad58406fec-zoom.jpg;https://vn-live-01.slatic.net/p/2/may-anh-kts-sony-cyber-shot-dsc-h400-201mp-va-zoom-quang-63x-den-1475131141-8901571-d88483b2dedc83028aa691ddfcefc224-zoom.jpg;https://vn-live-03.slatic.net/p/2/may-anh-kts-sony-cyber-shot-dsc-h400-201mp-va-zoom-quang-63x-den-1475131141-8901571-c1bb6481a2e511e33b8a6717ac422c10-zoom.jpg;https://vn-live-03.slatic.net/p/2/may-anh-kts-sony-cyber-shot-dsc-h400-201mp-va-zoom-quang-63x-den-1475131141-8901571-4dada0dd6cd7ad095ce9e2ea0c4d3c5d-zoom.jpg',
       N'Chiếc máy ảnh gọn nhẹ để lưu lại mọi khoảng khắc trong cuộc sống là vật dụng không thể thiếu đối với những tín đồ du lịch. Sony DSC-H300 sở hữu thiết kế nhỏ gọn nhưng không kém phần sang trọng, hiện đại cùng những tính năng chụp hình vượt trội chắc chắn sẽ là người đồng hành lý tưởng cho bạn chinh phục mọi nẻo đường. Ấn tượng với độ phân giải 20.1MP cùng bộ cảm biến Super HAD CCD Sony DSC-H300 cho hình ảnh sáng, rõ và cực kỳ sắc nét không khác gì một chiếcmáy ảnh chuyên nghiệp. Ngoài ra, được đánh giá là chiếc máy ảnh siêu zoom của dòng máy Cyber-shot, Model DSC-H300 cho phép người dùng có thể tiếp cận gần như trực diện các hình ảnh. Hơn nữa sự hỗ trợ tuyệt vời của chiều dài tiêu cự tối thiếu 25mm không quá khó để người dùng có thể nhanh chóng ghi lại mọi khoảnh khắc của từng cảnh vật, từng con người. ',
       N'SKU:SO993ELAA11J5MVNAMZ-1470595;Kích thước màn hình:3.0;Mẫu mã:Huyhoangdigital (Tp.HCM)-H400;Zoom quang:63.0;Kích thước sản phẩm (D x R x C cm):10 x 6 x 3;Trọng lượng (KG):0.2;Sản xuất tại:China;Độ phân giải video:720p;Thời gian bảo hành:2 Years;Loại hình bảo hành:Invoice',1,4,0.2,'2017-05-15','TBDT',1)
Insert into Products
Values(N'Giày Sneak Nam Thời Trang Đen Phối Đỏ.',130,'https://vn-live-02.slatic.net/p/7/giay-sneak-nam-thoi-trang-sodoha-sdn29029-den-phoi-do-1513174298-2415884-f931200631b71eabfe224184fa0d2cea-zoom_850x850.jpg;https://vn-live-03.slatic.net/p/7/giay-sneak-nam-thoi-trang-sodoha-sdn29029-den-phoi-do-1512612056-2415884-9c7285843e00c5cb5c80a3e2fbbd8cd9-zoom_850x850.jpg;https://vn-live-03.slatic.net/p/7/giay-sneak-nam-thoi-trang-sodoha-sdn29029-den-phoi-do-1512612056-2415884-16721368b96622c9aae6237faad2c21c-zoom_850x850.jpg;https://vn-live-01.slatic.net/p/7/giay-sneak-nam-thoi-trang-sodoha-sdn29029-den-phoi-do-1512612056-2415884-e33afcb07a814b2b3308a91151def970-zoom_850x850.jpg;',
       N'Giày Sneak Nam Thời Trang Sodoha SDN29029 Đen Phối Đỏ.Với kiểu dáng thể thao lại có phần thời trang hiện đại mang lại vẻ đẹp trẻ trung năng động.. ',
       N'SKU:SO412FAAA2WPEEVNAMZ-30339389;Chất liệu vải:Denim;Kiểu khóa giày:Lace-up;Xu Hướng Nam:Office;Mẫu mã:Casual;Kích thước sản phẩm (D x R x C cm):21x21x12;Trọng lượng (KG):2;Chiều cao của sneaker cổ cao:Medium Cut;Loại hình bảo hành:No Warranty',1,3,0.1,'2018-1-10','TT',3)
Insert into Products
Values(N'Kính mát Tom Ford gọng đen',470,'https://vn-live-01.slatic.net/p/8/kinh-mat-tom-ford-gong-den-phoi-doi-moi-tf-346-56n-1493006774-5361145-e782a05c9ce95fe1c766430e94b12d19-zoom.jpg;https://vn-live-02.slatic.net/p/8/kinh-mat-tom-ford-gong-den-phoi-doi-moi-tf-346-56n-1493006774-5361145-dee6269d4a13e283e60d2b9cc63eba4c-zoom.jpg;https://vn-live-03.slatic.net/p/8/kinh-mat-tom-ford-gong-den-phoi-doi-moi-tf-346-56n-1493006774-5361145-055bb452801a9b0a9c9e81e7b2e2c227-zoom.jpg;',
       N'Tom Ford là thương hiệu của nhà thiết kế cùng tên được thành lập vào năm 2007 chuyên sản xuất các loại phụ kiện- mỹ phẩm và trang phục thời trang. Các sản phẩm của Tom Ford luôn có tính ứng dụng cao- phù hợp với thị hiếu người tiêu dùng cũng như xu hướng thời trang của thế giới. Đến nay- Tom Ford đã và đang phát triển- khẳng định vị trí và thương hiệu trong lòng công chúng yêu thời trang khắp nơi trên thế giới.',
       N'SKU:TO441OTAA37ZN7VNAMZ-5632000;Màu gọng:Mercury;Màu tròng:Black;Mẫu mã:VN101HW-Sunny (Tp.HCM);Kích thước sản phẩm (D x R x C cm):13.5x13.5x3;Trọng lượng (KG):0.2;Thời gian bảo hành:3 Years;Loại hình bảo hành:Local supplier warranty',1,5,0.12,'2017-12-25','TT',3)
Insert into Products
Values(N'Kính mát Tom Ford gọng đen TF 9331 01B',770,'https://vn-live-03.slatic.net/p/8/kinh-mat-tom-ford-gong-den-tf-9331-01b-1488442216-1248174-e4205308507c92777582801a7afab656-zoom.jpg;https://vn-live-01.slatic.net/p/8/kinh-mat-tom-ford-gong-den-tf-9331-01b-1488442216-1248174-4b05cd263476cbc50c4091d130acf4e4-zoom.jpg;https://vn-live-01.slatic.net/p/8/kinh-mat-tom-ford-gong-den-tf-9331-01b-1488442216-1248174-f7dfde75a53f4d5d732b439dc5ca1aa4-zoom.jpg',
       N'Tom Ford là thương hiệu của nhà thiết kế cùng tên được thành lập vào năm 2007 chuyên sản xuất các loại phụ kiện- mỹ phẩm và trang phục thời trang. Các sản phẩm của Tom Ford luôn có tính ứng dụng cao- phù hợp với thị hiếu người tiêu dùng cũng như xu hướng thời trang của thế giới. Đến nay- Tom Ford đã và đang phát triển- khẳng định vị trí và thương hiệu trong lòng công chúng yêu thời trang khắp nơi trên thế giới',
       N'SKU:TO441OTAA2T4R9VNAMZ-4829909;Màu gọng:Mercury;Màu tròng:Multicolor;Mẫu mã:VN101HW-Sunny (Tp.HCM);Kích thước sản phẩm (D x R x C cm):13.5x13.5x3;Trọng lượng (KG):0.2;Thời gian bảo hành:3 Years;Loại hình bảo hành:Local supplier warranty',1,3,0.2,'2017-9-20','TT',3)
Insert into Products
Values(N'Quần jogger hoa văn chìm chất lừ phong cách',50,'https://vn-live-01.slatic.net/p/7/quan-jogger-hoa-van-chim-chat-lu-phong-cach-1504846155-30250821-628dc6740eaa79a60fc48fb246b15e35-zoom_850x850.jpg;https://vn-live-01.slatic.net/p/7/quan-jogger-hoa-van-chim-chat-lu-phong-cach-1504846155-30250821-d9dd64e4657f175f1fbe7d85fe450b72-zoom_850x850.jpg;https://vn-live-03.slatic.net/p/7/quan-jogger-hoa-van-chim-chat-lu-phong-cach-1504846155-30250821-15a4542aadc3a1e4ae9d4fed4de1b99e-zoom_850x850.jpg;https://vn-live-02.slatic.net/p/7/quan-jogger-hoa-van-chim-chat-lu-phong-cach-1504846155-30250821-f3d32eaf5d9a3e02d29e9848b50f7b1c-zoom_850x850.jpg;https://vn-live-02.slatic.net/p/7/quan-jogger-hoa-van-chim-chat-lu-phong-cach-1504846155-30250821-d88041612e7e482e48754090e8037aa9-zoom_850x850.jpg',
       N'Chất liệu cao cấp ( 95% polyester 5% cotton) co giản thoải mái Thiết kế thời trang Kiểu dáng đa phong cách Dễ phối trang phục Cam kết 99% sản phẩm đúng chất lượng mô tả Shop hỗ trợ đổi,trả nếu các bạn không hài lòng về sản phẩm',
       N'SKU:UY747FAAA7MGK3VNAMZ-14211042;Mẫu mã:quần jogger nam;Sản xuất tại:Hong Kong - China;Thời gian bảo hành:1 Month;Loại hình bảo hành:Invoice',1,4,0.15,'2017-12-20','TT',3)
Insert into Products
Values(N'Bộ sản phẩm dưỡng da cao cấp Biellee ',870,'https://vn-live-02.slatic.net/p/5/bo-san-pham-chong-lao-hoa-duong-trang-va-duong-am-da-cao-cap-biellee-1513935200-64370182-ea4c48fb9cd7657a4855ef71990fb457-zoom.jpg;https://vn-live-02.slatic.net/p/5/bo-san-pham-chong-lao-hoa-duong-trang-va-duong-am-da-cao-cap-biellee-1513935200-64370182-1ec8a81c7d430eeb4f4c11bee1f91aad-zoom.jpg;https://vn-live-03.slatic.net/p/5/bo-san-pham-chong-lao-hoa-duong-trang-va-duong-am-da-cao-cap-biellee-1513935200-64370182-1f0e5635e7d794a7af67e10fb7d1fb70-zoom.jpg;https://vn-live-01.slatic.net/p/5/bo-san-pham-chong-lao-hoa-duong-trang-va-duong-am-da-cao-cap-biellee-1513935200-64370182-a6ecee39cb0cec4af554fe4bf7a4b58c-zoom.jpg',
       N'Lợi ích: Các dưỡng chất cung cấp sinh lực cho làn da bị hư tổn và cải thiện các liên kết mô để giảm các kích thích bên ngoài cho da.
    Da sẽ duy trì được vẻ hồng hào mà vẫn duy trì được tình trạng da tốt nhất và kiểm soát được sự lưu thông máu trong các mạch máu nhỏ nhất dưới da
    Tinh chất từ nhuỵ hoa đậm đặc NANO POLLEN và trọng lượng nhỏ của phân tử NANO HYALURONIC A-xít giữ độ ẩm cho da thô và khô trong thời gian dài và giúp tăng độ ẩm, da trở nên đàn hồi và mịn màng từ bên trong.
    Ngoài ra, những vùng tối máu trên da cũng sẽ được cải thiện trở nên sáng hơn, giúp da đều màu và trong suốt.
    Ngăn ngừa lão hoá da, tái tạo tế bào da hư tổn, và làm mờ đi các nếp nhăn bằng cách kích thích sự tăng trưởng của các mô da mới.
         Hướng dẫn sử dụng: Sau khi rửa sạch mặt vào buổi tối, lấy một lượng nhỏ Biellee Ampoule (2~3 giọt, 1 giọt thoa cho 1 vùng nhất định), nhẹ nhàng thoa lên vùng má, trán, mũi và xung quanh vùng miệng, sau đó lần lượt bôi serum và kem dưỡng đều khắp mặt. Vỗ nhẹ để các dưỡng chất được thẩm thấu.',
       N'SKU:BI658HBAAGQFRMVNAMZ-34793323;Mẫu mã:Biellee Pollen Whitening Wrinkle Time Repair Collection;Sản xuất tại: 	Republic of Korea;Loại da:Signs of Ageing|All types;Loại hình bảo hành:No Warranty',1,5,0.1,'2018-1-25','DGDS',2)
Insert into Products
Values(N'Ohui The Frist -Tinh chất vàng 24K',800,'https://vn-live-01.slatic.net/p/5/ohui-the-frist-tinh-chat-vang-24k-1503027923-85055601-d36d03e727ec04b5ee626acc426d3884-zoom.jpg;https://vn-live-03.slatic.net/p/5/ohui-the-frist-tinh-chat-vang-24k-1503027923-85055601-2cf5b979373a74af1f307ed9f2134d82-zoom.jpg;https://vn-live-02.slatic.net/p/5/ohui-the-frist-tinh-chat-vang-24k-1503027923-85055601-7cf61961c9719d05332a4c196a7e2361-zoom.jpg',
       N'Tinh chất Vàng OHUI The First Ampoule Advanced thế hệ IV đậm đặc dưỡng chất gấp 10 lần,là sản phẩm vạn năng cung cấp chất dinh dưỡng,thúc đẩy năng lượng tái sinh da, tổng hợp collagen giúp làm đầy nếp nhăn vày tinh chất vàng 24k ngăn ngừa quá trình Oxy hóa làn da.
      Tinh chất đặc trị chứa Vàng 24K & 29 thành tố trong dung dịch nuôi dưỡng tế bào gốc chăm sóc tập trung cho quá trình tăng trưởng & hồi sinh của da, cải thiện rất nhiều vấn đề lão hoá trên da',
       N'SKU:OH483HBAA6CDHUVNAMZ-11703435;Nguồn gốc xuất xứ:America;Hình dạng sản phẩm:Serums;Mẫu mã:TINH CHẤT VÀNG -THE FIRST AMPOULE ADVANCED;Sản xuất tại:Republic of Korea;Lợi ích:Pore Control;Chăm sóc da:Pores;Loại da:Dry|Oily|Sensitive|Acne-prone|Dull|Signs of Ageing|All types;Kích cỡ:Regular size;Thể tích (ml):33.00;Thời gian bảo hành:1 Month;Loại hình bảo hành:Local supplier warranty',1,4,0.13,'2018-1-02','DGDS',2)
Insert into Products
Values(N'Baby collagen trẻ hoá làn da OHUI Age Recovery ',730,'https://vn-live-01.slatic.net/p/5/baby-collagen-tre-hoa-lan-da-ohui-age-recovery-1509980475-2284195-3e73430c2c96dd3f47d63a67d98bca74-zoom.jpg;https://vn-live-01.slatic.net/p/5/baby-collagen-tre-hoa-lan-da-ohui-age-recovery-1509980475-2284195-d4afe55d2e90566aaf0972bab7f2d0d8-zoom.jpg;https://vn-live-03.slatic.net/p/5/baby-collagen-tre-hoa-lan-da-ohui-age-recovery-1500863405-2284195-342a1468d17987ba8439ab30398a1616-zoom.jpg;https://vn-live-01.slatic.net/p/5/baby-collagen-tre-hoa-lan-da-ohui-age-recovery-1500863405-2284195-21bda7dc7ca530212151dff5781f6a6a-zoom.jpg',
       N'Nghiên cứu của OHUI cho thấy rằng có tới 27 loại Collagen trong da! Khi nói đến Collagen, hầu hết các sản phẩm chăm sóc da trên thị trường đều tập trung vào Collagen loại 1 (loại collagen có nhiều ở da người lớn), nhưng OHUI đã phát hiện ra rằng Baby Collagen – Collagen loại 3 có nhiều ở da em bé, tạo nên tế bào da trẻ, là collagen cốt lõi chăm sóc sự mềm mại, săn chắc và nếp nhăn của da. Vì sao được gọi là BABY COLLAGEN? Chính bởi vì loại Collagen này có hình dạng là sợi tế bào cực nhỏ, cực kỳ mềm mại, đàn hồi vô cùng tốt và CÓ NHIỀU NHẤT Ở LÀN DA EM BÉ! Baby Collagen là nghiên cứu được LG đăng ký độc quyền Toàn cầu, có khả năng tự nhân bản gia tăng các sợi collagen và tái sinh làn da vượt trội hơn hẳn các loại collagen khác! Làn da tỏa sáng rạng rỡ không nếp nhăn không tì vết? Nếp da căng mịn bóng mượt và trẻ trung? Bí quyết để sở hữu vẻ đẹp thanh xuân đó của làn da đã không còn là bí mật của riêng ai từ khi OHUI cho ra đời sản phẩm Baby Collagen cô đặc dạng tinh chất! Tinh chất cô đặc Baby Collagen – OHUI Super Anti-aging Essence ĐỘT PHÁ về thành phần: – TĂNG GẤP 3 LẦN Baby Collagen và Amino Acid tự nhiên, không chỉ bổ sung Collagen từ bên ngoài mà còn giúp da tự tổng hợp Collagen từ bên trong, phục hồi và tái tạo cấu trúc da bị phá vỡ bởi sự lão hóa. – BỔ SUNG THÀNH PHẦN Bảo vệ Baby Collagen giúp giữ chặt và bảo vệ cho lớp Baby Collagen được duy trì trên da lâu dài. Sản phẩm này thật sự mang đến làn da trẻ trung như da em bé đúng theo mong đợi của bạn!',
       N'SKU:OH483HBAA3IRWMVNAMZ-6221062;Mẫu mã:Baby collagen;Trọng lượng (KG):0.5;Sản xuất tại:Republic of Korea;Lợi ích:Whitening;Thời gian bảo hành :1 Month;Loại hình bảo hành:Local supplier warranty',1,4,0.05,'2018-1-10','DGDS',2)
Insert into Products
Values(N'Bộ dưỡng da chống lão hoá',500,'https://vn-live-02.slatic.net/p/5/bo-duong-da-chong-lao-hoa-1504841870-68187721-8a4d234a27e4505dab564b3587432d90-zoom.jpg;https://vn-live-02.slatic.net/p/5/bo-duong-da-chong-lao-hoa-1504841870-68187721-e054d56ac74a6b9d85a330dd5be49a09-zoom.jpg;https://vn-live-02.slatic.net/p/5/bo-duong-da-chong-lao-hoa-1504841870-68187721-7f39f07cf12924baad00e09cb1f3d0a1-zoom.jpg',
       N' Bộ dưỡng da chống lão hóa mini 5 món Su:m 37 Dòng sản phẩm Secret Repair với thành phần lên men cô đặc mang đến khả năng ngăn ngừa lão hóa, cải thiện độ đàn hồi hiệu quả cho làn da. Bộ sản phẩm Secret Repair kết hợp thêm tinh chất Secret Essence với dưỡng chất dồi dào giúp cải thiện sức khỏe từng tế bào, cung cấp độ ẩm và tăng cường tính hiệu quả của các bước dưỡng khác. Chỉ sau một đêm, làn da sẽ được đánh thức và trở nên căng mịn đến bất ngờ. ',
       N'SKU:OH483HBAA7LVPMVNAMZ-14150056;Nguồn gốc xuất xứ:Hình dạng sản phẩm:Cream|EmulsionKorea;Mẫu mã:Dưỡng da;Sản xuất tại:Republic of Korea;Lợi ích:Anti-aging|Firming/Lifting;Loại da:All types;Kích cỡ:Travel size;Thể tích (ml):70.00;Thời gian bảo hành:1 Month;Loại hình bảo hành:Invoice',1,5,0.1,'2017-11-12','DGDS',2)
Insert into Products
Values(N'Máy hấp thực phẩm Magic Korea A64',500,'https://vn-live-02.slatic.net/p/10/may-hap-thuc-pham-magic-korea-a64-1513180841-3835185-40930dae350cff8800918e507bbb5101-zoom.jpg;https://vn-live-03.slatic.net/p/10/may-hap-thuc-pham-magic-korea-a64-1505586616-3835185-48a6648a8df27e604fcad77104c6f658-zoom.jpg;https://vn-live-02.slatic.net/p/10/may-hap-thuc-pham-magic-korea-a64-1505586616-3835185-bf41d71c3617335b5e852bd580827cf0-zoom.jpg;https://vn-live-02.slatic.net/p/10/may-hap-thuc-pham-magic-korea-a64-1507026620-3835185-90c6ab7997e0a05072cf7b6f5e1a1208-zoom.jpg;https://vn-live-01.slatic.net/p/10/may-hap-thuc-pham-magic-korea-a64-1507026620-3835185-4f074a1ac395b3a748925b1d9e1cb315-zoom.jpg',
       N'Hấp thực phẩm nhanh Giữ lại chất dinh dưỡng trong thực phẩm Công suất 500W Sản xuất theo công nghệ Hàn Quốc Bảo hành 12 tháng',
       N'SKU:MA700HAAA3GN6FVNAMZ-6093439;Nguồn gốc xuất xứ:Việt Nam;Capacity:5;Mẫu mã:Máy hấp thực phẩm Magic Korea A64;Kích cỡ:20 x 23 x 31;Trọng lượng (KG):1.3;Thời gian bảo hành:1 Month;Loại hình bảo hành:Invoice',1,5,0.11,'2017-10-10','DGDS',4)
Insert into Products
Values(N'Chảo chiên Công Nghiệp đơn',300,'https://vn-live-02.slatic.net/p/10/chao-chien-cong-nghiep-don-1482911839-6876243-02a32f7fd81bf33780ab3f21d7b8e591-zoom.jpg;https://vn-live-01.slatic.net/p/10/chao-chien-cong-nghiep-don-1482911839-6876243-7da09c5dbef3f4c33873e23a0c256bfc-zoom.jpg;https://vn-live-03.slatic.net/p/10/chao-chien-cong-nghiep-don-1482911839-6876243-abede954b44800037a063dc834bfb047-zoom.jpg',
       N'Chảo chiên chuyên dụng công nghệ cao Sức chứa lớn Chiên dễ dàng, tiện dụng Sử dụng điện an toàn Thích hợp với bếp công nghiệp',
       N'SKU:EO902HAAA21G4IVNAMZ-3475051;Nguồn gốc xuất xứ:Việt Nam;Capacity:5;Mẫu mã:Chảo chiên chuyên dụng công nghệ cao Sức chứa lớn Chiên dễ dàng, tiện dụng Sử dụng điện an toàn Thíc hợp với bếp công nghiệp;Kích cỡ:20 x 23 x 31;Trọng lượng (KG):1.3;Thời gian bảo hành:2 Month;Loại hình bảo hành:Invoice',1,5,0.2,'2017-8-26','DGDS',2)
Insert into Products
Values(N'Tượng ông Địa Thần Tài 15x14cm  ',50,'https://vn-live-02.slatic.net/p/3/tuong-ong-dia-than-tai-15x14cm-1469602884-5240552-8713eb49814e76b4a6b31d3eecc13cbb-zoom.jpg;https://vn-live-03.slatic.net/p/3/tuong-ong-dia-than-tai-15x14cm-1469602884-5240552-c98ab1af7b43d37fce8c3ec5c81856fc-zoom.jpg;https://vn-live-01.slatic.net/p/3/tuong-ong-dia-than-tai-15x14cm-1469602884-5240552-b972eaafec33b556c20600ab498bee23-zoom.jpg',
       N'Thần Đất là vị thần hộ mệnh của xóm làng, cai quản vùng trời, đất đai, phù hộ con người và gia súc trong xóm làng, mùa màng bội thu. Thần Đất mang dấu ấn của thời kinh tế nông nghiệp. Thần Tài là vị thần trông coi tiền tài, vàng bạc, là dấu ấn của thời kỳ kinh tế thương nghiệp. Vì vậy, người ta thường lập bàn thờ chung để cúng hai vị thần này suốt năm nhưng vào ngày tết thì việc cúng lễ được coi trọng hơn.
         Thần Tài – Ông Địa là một cặp 2 ông thần được thờ trong một cái tủ thờ, đặt ở dưới đất.
         Thần Tài – Ông Địa là một cặp thờ tuy về hình chỉ có 1 ông Địa và 1 Thần tài, nhưng Mỗi một vị như vậy là đại diện cho 5 người. Về Thần Tài có : Hắc Thần Tài, Thanh Thần Tài, Bạch Thần Tài , Xích Thần Tài Và Hoàng Thần tài là vị chủ chốt. Còn ông Địa cũng có 5 ông : Đông phương Thanh Đế, Tây phương Bạch Đế, Nam phương Xích Đế, Bắc phương Hắc Đế và Trung ương Huỳnh Đế. Về hình thức bên ngoài thì Ông Địa thường bụng phệ, người trắng nõn, để ngực trần, đầu quấn khăn, tay cầm quạt và hay có con cọp đi theo. Thần Tài thường tay cầm cục vàng (kim ngân lượng) hoặc bạc, đội mũ mão, trang phục nghiêm chỉnh hơn Ông Địa.',
       N'SKU:NO007HLAA1INX5VNAMZ-2461365;Nguồn gốc xuất xứ:Việt Nam;Capacity:5;Mẫu mã:TƯỢNG NGHỆ THUẬT YẾN NHI-7T15x14;Kích cỡ:14 x 11 x 15;Trọng lượng (KG):1.6;Thời gian bảo hành:10 Years;Loại hình bảo hành:Invoice',1,5,0.1,'2017-10-29','DGDS',2)
Insert into Products
Values(N'Bộ vòi sen nóng lạnh Inox (Trắng vàng)',700,'https://vn-live-03.slatic.net/p/3/bo-voi-sen-nong-lanh-inox-sus-304-eurolife-el-1201-trang-vang-1513179805-1750631-9745b631f83feb69aff2e3db6b564b8e-zoom.jpg;https://vn-live-01.slatic.net/p/3/bo-voi-sen-nong-lanh-inox-sus-304-eurolife-el-1201-trang-vang-1500870655-1750631-e0df739998fae47c05f86d8f296dd531-zoom.jpg;https://vn-live-02.slatic.net/p/3/bo-voi-sen-nong-lanh-inox-sus-304-eurolife-el-1201-trang-vang-1500870655-1750631-ffae12b4dab633fbba3e78bd6f93b94f-zoom.jpg',
       N'Chất liệu Inox SUS 304 tinh khiết, không Chì (Pb) an toàn cho sức khỏe người sử dụng, thân thiện với môi trường.',
       N'SKU:EU864HLAA0T5TNVNAMZ-1010517;Nguồn gốc xuất xứ:Việt Nam;Capacity:5;Mẫu mã:Sen vòi - Thiết bị phòng tắm - Nhà bếp EUROLIFE (Tp.HCM)-EL-1201;Kích cỡ:21x17x14;Trọng lượng (KG):2.2;Thời gian bảo hành:4 Years;Loại hình bảo hành:Invoice',1,5,0.1,'2017-11-25','DGDS',4)
Insert into Products
Values(N'Bếp hồng ngoại đơn Philips HR-2015 (Đen)',530,'https://vn-live-01.slatic.net/p/10/bep-hong-ngoai-don-philips-hr-2015-den-1514344509-67061382-0b1cdf55d405e46be767047638799c6a-zoom.jpg;https://vn-live-02.slatic.net/p/10/bep-hong-ngoai-don-philips-hr-2015-den-1514344509-67061382-43bf6249e641c8ca53d1f87b9a47b7f2-zoom.jpg;https://vn-live-03.slatic.net/p/10/bep-hong-ngoai-don-philips-hr-2015-den-1514344509-67061382-e8d00c31481d5924499aca7f9d7fb410-zoom.jpg;https://vn-live-01.slatic.net/p/10/bep-hong-ngoai-don-philips-hr-2015-den-1514344509-67061382-d7d20672ec357e613db76a4b8372d12d-zoom.jpg',
       N'Bếp hồng ngoại đơn Philips HR-2015 (Đen) – Sản Xuất Tại Thái Lan Model: HR-2015 Chế độ : Nấu lẩu , nướng , nấu súp, cháo … Kích thước sản phẩm (D x R x C cm): 43.5 x 32.5 x 8.5 Trọng lượng (KG): 3.5 Sản xuất tại: Thái Lan Wattage: 2200W .',
       N'SKU:PH814HAAAGUWTOVNAMZ-35076198;Nguồn gốc xuất xứ:Thái Lan;Capacity:5;Mẫu mã:HR-2015;Kích cỡ:21x17x14;Trọng lượng (KG):2.2;Thời gian bảo hành:4 Years;Loại hình bảo hành:Invoice',1,5,0.15,'2018-1-15','DGDS',4)
Insert into Products
Values(N'Bếp hồng ngoại cảm ứng Sunhouse SHD6016 (Đen)',500,'https://vn-live-01.slatic.net/p/10/bep-hong-ngoai-cam-ung-sunhouse-shd6016-den-1507275025-3495228-b853e22c8157655cdfaea0a0473480ad-zoom.jpg;https://vn-live-02.slatic.net/p/10/bep-hong-ngoai-cam-ung-sunhouse-shd6016-den-1507275025-3495228-3c516f8894255ecea59a95baa941e9e0-zoom.jpg;https://vn-live-03.slatic.net/p/10/bep-hong-ngoai-cam-ung-sunhouse-shd6016-den-1507275025-3495228-aed0988fdfc21c781a798c261fd1c545-zoom.jpg;',
       N'Bếp hồng ngoại cảm ứng Sunhouse SHD6016 nóng nhanh, có chức năng hẹn giờ thông minh cùng với phím khóa an toàn bạn có thể yên tâm sử dụng khi có trẻ nhỏ chơi đùa bên cạnh. Bếp sử dụng mặt kính siêu bền chịu nhiệt tốt cùng phím cảm ứng dễ sử dụng, an toàn. Với công suất 2000W nấu thức ăn nhanh hơn và có thể nấu được tất cả các loại nồi. Bếp hồng ngoại cảm ứng Sunhouse SHD6016 không bức xạ nhiệt, điều khiểm bằng chíp điện tử an toàn với người dùng. Bếp hồng ngoại cảm ứng Sunhouse SHD6016 sẽ là sự lựa chọn hoàn hảo nhất của bạn cho gia đình thân yêu.',
       N'SKU: 	SU023HAAA17GVUVNAMZ-1795678;Nguồn gốc xuất xứ:Việt Nam;Capacity:5;Mẫu mã:Sunhouse Shop Online (Hà Nội)-SHD6016;Kích cỡ:45 x 20 x 32;Trọng lượng (KG):2.38;Thời gian bảo hành:12 Months;Loại hình bảo hành:Invoice',1,5,0.25,'2018-2-2','DGDS',4)
Insert into Products
Values(N'Bếp hồng ngoại cơ Sunhouse SHD6011 (Đen)',500,'https://vn-live-03.slatic.net/p/10/bep-hong-ngoai-co-sunhouse-shd6011-den-1490768616-1139431-a4b3cad1a971ed546aab137f187a8118-zoom.jpg;https://vn-live-03.slatic.net/p/10/bep-hong-ngoai-co-sunhouse-shd6011-den-1476258981-1139431-a7f349700c5653104d36d89d18746f53-zoom.jpg;https://vn-live-01.slatic.net/p/10/bep-hong-ngoai-co-sunhouse-shd6011-den-1476258981-1139431-f00c4ee0bb704fdad1fc376b0f0cacae-zoom.jpg;https://vn-live-01.slatic.net/p/10/bep-hong-ngoai-co-sunhouse-shd6011-den-1476258981-1139431-f00c4ee0bb704fdad1fc376b0f0cacae-zoom.jpg',
       N'Bếp hồng ngoại cảm ứng Sunhouse SHD6016 nóng nhanh, có chức năng hẹn giờ thông minh cùng với phím khóa an toàn bạn có thể yên tâm sử dụng khi có trẻ nhỏ chơi đùa bên cạnh. Bếp sử dụng mặt kính siêu bền chịu nhiệt tốt cùng phím cảm ứng dễ sử dụng, an toàn. Với công suất 2000W nấu thức ăn nhanh hơn và có thể nấu được tất cả các loại nồi. Bếp hồng ngoại cảm ứng Sunhouse SHD6016 không bức xạ nhiệt, điều khiểm bằng chíp điện tử an toàn với người dùng. Bếp hồng ngoại cảm ứng Sunhouse SHD6016 sẽ là sự lựa chọn hoàn hảo nhất của bạn cho gia đình thân yêu.',
       N'SKU:SU023HAAA0SX4VVNAMZ-994955;Nguồn gốc xuất xứ:Việt Nam;Capacity:5;Mẫu mã:Sunhouse Shop Online (Hà Nội)-SHD6016;Kích cỡ:45 x 20 x 32;Trọng lượng (KG):2.38;Thời gian bảo hành:12 Months;Loại hình bảo hành:Invoice;Power Consumption (Watts):2000W',1,5,0.2,'2017-1-2','DGDS',4)

