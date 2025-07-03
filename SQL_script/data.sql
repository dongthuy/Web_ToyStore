USE web_code
GO


-- Thêm người dùng
INSERT INTO user_tb (user_name, password, admin, buyer, seller, date_created)
VALUES 
    ('user2', 'pass2', 0, 1, 0, '2025-05-01'),
    ('user3', 'pass3', 0, 1, 0, '2025-04-30'),
    ('user4', 'pass4', 0, 1, 0, '2025-04-29');



GO
-- Thêm chi tiết người dùng
INSERT INTO user_tb2 (user_id, name, birthday, phone_number, address, email)
VALUES 
    (1, N'User 2', '1990-01-01', '090000002', N'Address 2', 'user2@example.com'),
    (2, N'User 3', '1990-01-01', '090000003', N'Address 3', 'user3@example.com'),
    (3, N'User 4', '1990-01-01', '090000004', N'Address 4', 'user4@example.com');
Go
-- Thêm danh mục
INSERT INTO category (category_id, category_name)
VALUES ('cate01', N'Danh mục 1');

-- Thêm nhóm sản phẩm
INSERT INTO group_tb (group_tb_id, group_tb_name, type)
VALUES ('grp01', N'Nhóm 1', 1);

Go

INSERT INTO brand (brand_id, brand_name, brand_name2, description, status)
VALUES
    ('br001', N'Brand A', N'Thương Hiệu A', N'Description of Brand A', 1),
    ('br002', N'Brand B', N'Thương Hiệu B', N'Description of Brand B', 1),
    ('br003', N'Brand C', N'Thương Hiệu C', N'Description of Brand C', 0);

-- Thêm sản phẩm
INSERT INTO product (product_id, name, brand_id, category_id, group_tb_1, uom, price1, date_apply1)
VALUES 
    ('prd02', N'Product 2','br001', 'cate01', 'grp01', N'Cái', 4764067, '2025-05-03'),
    ('prd03', N'Product 3','br002' ,'cate01', 'grp01', N'Cái', 2910113, '2025-05-03'),
    ('prd04', N'Product 4','br003', 'cate01', 'grp01', N'Cái', 1516373, '2025-05-03');
----
	INSERT INTO product_in (pi_id, product_id, date_created, name, quantity, cost)
VALUES 
    ('pi01', 'prd02', '2025-05-01', N'Nhập hàng đợt 1', 50, 4000000),
	('pi03', 'prd04', '2025-05-01', N'Nhập hàng đợt 1', 70, 1000000),
    ('pi02', 'prd03', '2025-05-02', N'Nhập hàng đợt 2', 100, 2500000);

-- Thêm thuế
INSERT INTO tax (tax_id, tax_name, tax_name2, rate, date_start)
VALUES ('tax01', N'Thuế GTGT', N'VAT', 10, '2025-01-01');

-- Thêm đơn hàng
INSERT INTO order_tb (order_id, date_created, buyer, seller)
VALUES 
    ('ord02', '2025-05-01', 3,1),
    ('ord03', '2025-04-30', 1,2),
    ('ord04', '2025-04-29', 3,1);

-- Thêm chi tiết đơn hàng
INSERT INTO order_d (order_id, product_id,pi_id, quantity, cost, price, tax)
VALUES 
    ('ord02', 'prd04','pi03', 2, 1697199, 1969338, 'tax01'),
    ('ord02', 'prd03','pi02', 3, 1412665, 1626053, 'tax01'),
    ('ord03', 'prd03','pi02', 2, 1113107, 1371328, 'tax01');

-- Thêm tồn kho sản phẩm

-- Thêm phương thức thanh toán
INSERT INTO payment_method (method_id, name, type, date_created)
VALUES ('pm01', N'Thanh toán chuyển khoản', 1, '2025-05-01');

-- Thêm hóa đơn
INSERT INTO invoice (invoice_id, order_id, date_created, method, amount, amount_payable, payment, balanced)
VALUES 
    ('inv01', 'ord02', '2025-05-01', 'pm01', 5000000, 5000000, 5000000, 0);

-- Thêm wishlist
INSERT INTO wishlist (user_id, product_id, product_name, product_description)
VALUES (2, 'prd02', 'Product 2', N'Mô tả sản phẩm 2');
GO
-- Thêm đánh giá
INSERT INTO rating (product_id, user_id, date_created, rate, description)
VALUES ('prd02', 2, '2025-05-02', 5, N'Hài lòng');

-- Thêm lịch sử đăng nhập
INSERT INTO log_hisory (user_id, date_log, IP, status)
VALUES (2, '2025-05-02 10:00:00', '192.168.1.1', 1);


-- Thêm địa chỉ


INSERT INTO address (address_id, name, phone, description, country, city, district, ward, street, detail, user_id, status)
VALUES 
('addr01', N'user2', '0901238888', N'Nhà riêng', N'Việt Nam', N'TP. Hồ Chí Minh', N'Quận 3', N'Phường Võ Thị Sáu', N'Đường Võ Thị Sáu', N'Số 123, Tầng 2', '1', 1)
-- Thêm đơn giao hàng
INSERT INTO shipment (shipment_id, date_created, order_id, address_id, name_receive, phone_receive)
VALUES ('ship01', '2025-05-02', 'ord02', 'addr01', N'Người nhận 1', '090000002');

-- Thêm chi tiết giao hàng
INSERT INTO shipment_d (shipment_id, product_id, order_id, quantity)
VALUES ('ship01', 'prd04', 'ord02', 2);

-- Thêm hỗ trợ
INSERT INTO support (support_id, user_ask, ask, date_ask, product_id, order_id)
VALUES ('sup01', 2, N'Làm sao theo dõi đơn hàng?', '2025-05-03', 'prd04', 'ord02');

-- Thêm chat
INSERT INTO chat_tab (chat_id, date_created, name)
VALUES ('chat01', '2025-05-03', N'Hỗ trợ đơn hàng');

-- Thêm thành viên chat
INSERT INTO chat_member ( member_name, user_id, chat_id, date_joined)
VALUES ( N'User 2', 2, 'chat01', '2025-05-03');

-- Thêm tin nhắn chat
INSERT INTO chat_detail (member_send, name_send, msg_txt, date_created, isRead, pin)
VALUES (1, 2, N'Xin chào, tôi cần hỗ trợ đơn hàng.', '2025-05-03 10:00:00', 0, 0);

-- Thêm lượt click sản phẩm
INSERT INTO click_product (product_id, user_id)
VALUES ('prd02', 2);

-- Insert data into the promotion table
INSERT INTO promotion (
    promotion_id,
    promotion_name,
    promotion_name2,
    type,
    calculate,
    date_created,
    date_start,
    date_end,
    value,
    quantity,
    description,
    quan_cond,
    val_cond,
    oder_tb_cond,
    group_tb_cond,
    rank_cond
) VALUES
    ('promo001', N'Giảm giá đặc biệt', N'Khuyến mãi đặc biệt', 1, 1, '2025-05-01', '2025-05-05', '2025-05-10', 0.1, 100, N'Giảm 10% cho đơn hàng trên 100 sản phẩm', 100, 0, 0, NULL, 0),
    ('promo002', N'Mua 1 tặng 1', N'Mua một tặng một', 2, 0, '2025-05-02', '2025-05-07', '2025-05-15', NULL, NULL, N'Mua một sản phẩm tặng một sản phẩm cùng loại', 0, 100000, 1, 'grp01', 0),
    ('promo003', N'Giảm giá theo hạng', N'Giảm giá theo cấp độ thành viên', 3, 1, '2025-05-03', '2025-05-10', '2025-05-20', 0.05, NULL, N'Giảm 5% cho thành viên hạng VIP', 0, 500000, 0, NULL, 2);

-- Insert data into the promotion_product table
INSERT INTO promotion_product (
    promotion_id,
    product_id
) VALUES
    ('promo001', 'prd02'),
    ('promo001', 'prd03'),
    ('promo002', 'prd04'),
    ('promo003', 'prd02');
GO

-- Insert data into user_tb (user_id sẽ tự động tăng từ 1)
INSERT INTO user_tb (user_name, password, admin, buyer, seller, rank, ban, freeze, notify, date_created, status)
VALUES 
('user401', 'password123', 0, 1, 0, 1, 0, 0, 1, '2024-01-15', 1),
('admin402', 'adminpass456', 1, 1, 1, 5, 0, 0, 1, '2024-01-16', 1),
('seller403', 'sellerpwd789', 0, 1, 1, 3, 0, 0, 1, '2024-01-17', 1),
('buyer404', 'buyerpwd321', 0, 1, 0, 2, 0, 0, 0, '2024-01-18', 1);

-- Insert data into user_tb2 (sử dụng user_id từ bảng user_tb)
INSERT INTO user_tb2 (user_id, name, name2, birthday, phone_number, address, email, social_url1, social_url2, social_url3, logo_url)
VALUES 
(4, N'Nguyễn Văn A', N'Nguyen Van A', '1990-05-15', '0901234567', N'123 Đường ABC, Quận 1, TP.HCM', 'nguyenvana@email.com', 'https://facebook.com/nguyenvana', 'https://instagram.com/nguyenvana', NULL, 'https://example.com/logo1.jpg'),
(5, N'Trần Thị B', N'Tran Thi B', '1985-08-22', '0902345678', N'456 Đường DEF, Quận 2, TP.HCM', 'tranthib@email.com', 'https://facebook.com/tranthib', NULL, 'https://twitter.com/tranthib', 'https://example.com/logo2.jpg'),
(6, N'Lê Văn C', N'Le Van C', '1992-03-10', '0903456789', N'789 Đường GHI, Quận 3, TP.HCM', 'levanc@email.com', 'https://facebook.com/levanc', 'https://instagram.com/levanc', 'https://linkedin.com/levanc', 'https://example.com/logo3.jpg'),
(7, N'Phạm Thị D', N'Pham Thi D', '1988-12-05', '0904567890', N'321 Đường JKL, Quận 4, TP.HCM', 'phamthid@email.com', 'https://facebook.com/phamthid', NULL, NULL, 'https://example.com/logo4.jpg');

-- Insert data into category
INSERT INTO category (category_id, category_name, category_name2, description, status)
VALUES 
('4001', N'Đồ chơi giáo dục', 'Educational Toys', N'Đồ chơi phát triển trí tuệ và kỹ năng học tập', 1),
('4002', N'Đồ chơi vận động', 'Active Play Toys', N'Đồ chơi khuyến khích hoạt động thể chất', 1),
('4003', N'Đồ chơi sáng tạo', 'Creative Toys', N'Đồ chơi phát triển khả năng sáng tạo và nghệ thuật', 1),
('4004', N'Đồ chơi mô hình', 'Model Toys', N'Mô hình xe, máy bay, robot và các nhân vật', 1);

INSERT INTO group_tb (group_tb_id, group_tb_name, group_tb_name2, type, description, status)
VALUES 
('4101', N'Xếp hình - Lắp ráp', 'Building & Construction', 1, N'Lego, xếp hình, đồ chơi lắp ráp', 1),
('4102', N'Xe đạp - Xe trượt', 'Bikes & Scooters', 2, N'Xe đạp trẻ em, xe trượt, xe cân bằng', 1),
('4103', N'Đất nặn - Vẽ vời', 'Arts & Crafts', 3, N'Đất nặn, bút màu, dụng cụ vẽ', 1),
('4104', N'Robot - Transformer', 'Robots & Transformers', 4, N'Robot điều khiển, transformer, mô hình biến hình', 1),
('4105', N'Búp bê - Thú nhồi bông', 'Dolls & Plush Toys', 1, N'Búp bê, gấu bông, thú nhồi bông các loại', 1),
('4106', N'Đồ chơi âm nhạc', 'Musical Toys', 3, N'Piano, guitar, trống cho trẻ em', 1),
('4107', N'Đồ chơi bể bơi', 'Water & Pool Toys', 2, N'Phao bơi, đồ chơi nước, bể bơi mini', 1),
('4108', N'Đồ chơi khoa học', 'Science Toys', 1, N'Bộ thí nghiệm, kính hiển vi, đồ chơi STEM', 1),
('4109', N'Xe mô hình', 'Model Cars', 4, N'Xe ô tô mô hình, xe điều khiển từ xa', 1);

-- Insert data into brand
INSERT INTO brand (brand_id, brand_name, brand_name2, description, status)
VALUES 
('4201', N'LEGO', 'LEGO', N'Thương hiệu đồ chơi xếp hình nổi tiếng', 1),
('4202', N'Fisher-Price', 'Fisher-Price', N'Thương hiệu đồ chơi trẻ em hàng đầu', 1),
('4203', N'Hasbro', 'Hasbro', N'Thương hiệu đồ chơi và trò chơi quốc tế', 1),
('4204', N'VTech', 'VTech', N'Thương hiệu đồ chơi công nghệ giáo dục', 1);

INSERT INTO product (product_id, name, name2, description, brand_id, category_id, group_tb_1, group_tb_2, uom, price1, date_apply1, price2, date_apply2, url_image1, url_image2, url_image3, user_id, status)
VALUES 
('4301', N'LEGO City Sở Cứu hỏa', 'LEGO City Fire Station', N'Bộ xếp hình sở cứu hỏa với 509 mảnh ghép', '4201', '4001', '4101', NULL, N'Bộ', 2890000, '2024-01-01', 2590000, '2024-02-01', 'https://www.mykingdom.com.vn/cdn/shop/files/60414_763af6ee-d9d7-401d-8959-bf8fd9720504.jpg?v=1725510450&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/products/60414_1-1.jpg?v=1725510463&width=1646', NULL, '3', 1),
('4302', N'Xe đạp trẻ em Fisher-Price 16 inch', 'Fisher-Price Kids Bike 16"', N'Xe đạp cho trẻ từ 4-7 tuổi có bánh phụ', '4202', '4002', '4102', NULL, N'Chiếc', 3200000, '2024-01-01', 2850000, '2024-02-15', 'https://www.mykingdom.com.vn/cdn/shop/files/5f1878c564cec3fd645e72380694fc6e.jpg?v=1706801340&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/files/eb0b23eb0c8ecc90bcd298dc030df4ad.jpg?v=1706801362&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/files/72b36012edefb68cf7c8bd6219ff8a66.jpg?v=1706801352&width=1646', '3', 1),
('4303', N'Bộ đất nặn Play-Doh 12 màu', 'Play-Doh 12 Color Pack', N'Bộ đất nặn an toàn với 12 màu cơ bản', '4203', '4003', '4103', NULL, N'Bộ', 450000, '2024-01-01', 390000, '2024-03-01', 'https://www.mykingdom.com.vn/cdn/shop/files/bot-nan-12-mau-mua-xuan-nam-2024-playdoh-e4831-2024_3.png?v=1727145674&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/files/bot-nan-12-mau-mua-xuan-nam-2024-playdoh-e4831-2024_1.png?v=1727145674&width=1646', NULL, '3', 1),
('4304', N'Robot Transformer Optimus Prime', 'Transformers Optimus Prime', N'Robot biến hình thành xe tải', '4203', '4004', '4104', NULL, N'Cái', 1890000, '2024-01-01', NULL, NULL, 'https://www.mykingdom.com.vn/cdn/shop/products/f7242_1.jpg?v=1718957708&width=1646','https://www.mykingdom.com.vn/cdn/shop/files/0cf9882d0afa6e4ebf01aae31c15bae9.jpg?v=1718956946&width=1646', NULL, '3', 1),
('4305', N'Búp bê Barbie Công chúa', 'Barbie Princess Doll', N'Búp bê Barbie với váy công chúa lộng lẫy', '4203', '4003', '4105', NULL, N'Cái', 890000, '2024-01-01', 790000, '2024-03-15', 'https://www.mykingdom.com.vn/cdn/shop/products/hpb18-hgp62_1.jpg?v=1718679070&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/products/hpb18-hgp62_3.jpg?v=1718679070&width=1646', NULL, '3', 1),
('4306', N'Piano điện tử VTech 32 phím', 'VTech Electronic Piano 32 Keys', N'Piano điện tử cho trẻ với 32 phím và nhiều âm thanh', '4204', '4001', '4106', NULL, N'Cái', 1250000, '2024-01-01', 1100000, '2024-02-20','https://www.mykingdom.com.vn/cdn/shop/files/dan-phim-dien-tu-cua-peppa-pig-1684242inf19.jpg?v=1721381974&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/products/618oag2nenl._ac_sl1500__1.jpg?v=1721382484&width=1646',null ,'3', 1),
('4307', N'Phao bơi hình Cá sấu', 'Crocodile Pool Float', N'Phao bơi hình kỳ lân cho trẻ em', '4202', '4002', '4107', NULL, N'Cái', 650000, '2024-01-01', 550000, '2024-04-01', 'https://www.mykingdom.com.vn/cdn/shop/files/DD08005.jpg?v=1727837483&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/products/dd08005_2_b86bd240-cc12-4af7-8d13-5404d84bddd2.jpg?v=1718679684&width=1646', NULL, '3', 1),
('4308', N'Bộ thí nghiệm khoa học mini', 'Mini Science Experiment Kit', N'Bộ dụng cụ thí nghiệm khoa học cho trẻ', '4204', '4001', '4108', NULL, N'Bộ', 980000, '2024-01-01', 850000, '2024-03-10', 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-ong-thi-nghiem-2-sinh-vat-mrbeast-lab-24772.jpg?v=1744949641&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-ong-thi-nghiem-2-sinh-vat-mrbeast-lab-24772_7.jpg?v=1744949641&width=1646', null, '3', 1),
('4309', N'Xe ô tô điều khiển từ xa', 'Remote Control Car', N'Xe ô tô mô hình điều khiển từ xa tỷ lệ 1:18', '4201', '4004', '4109', NULL, N'Cái', 1450000, '2024-01-01', 1250000, '2024-02-28', 'https://www.mykingdom.com.vn/cdn/shop/files/xe-r-c-1-24-pagani-zonda-r-mau-trang-r38010.jpg?v=1718266219&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/products/1_24_38010_05_2.jpg?v=1718266241&width=1646', 'https://www.mykingdom.com.vn/cdn/shop/products/img_0026.jpg?v=1718266241&width=1646', '3', 1);

INSERT INTO product_in (pi_id, product_id, date_created, date_start, date_end, name, name2, quantity, cost)
VALUES 
('4401', '4301', '2024-01-01 08:00:00', '2024-01-01 08:00:00', '2024-12-31 23:59:59', N'Nhập kho LEGO Fire Station - Lô 1', 'LEGO Fire Station Import Batch 1', 30, 2200000),
('4402', '4302', '2024-01-01 09:00:00', '2024-01-01 09:00:00', '2024-12-31 23:59:59', N'Nhập kho Xe đạp Fisher-Price - Lô 1', 'Fisher-Price Bike Import Batch 1', 15, 2400000),
('4403', '4303', '2024-01-01 10:00:00', '2024-01-01 10:00:00', '2024-12-31 23:59:59', N'Nhập kho Play-Doh 12 màu - Lô 1', 'Play-Doh 12 Colors Import Batch 1', 80, 320000),
('4404', '4304', '2024-01-01 11:00:00', '2024-01-01 11:00:00', '2024-12-31 23:59:59', N'Nhập kho Optimus Prime - Lô 1', 'Optimus Prime Import Batch 1', 25, 1400000),
('4405', '4305', '2024-01-02 08:30:00', '2024-01-02 08:30:00', '2024-12-31 23:59:59', N'Nhập kho Búp bê Barbie - Lô 1', 'Barbie Princess Doll Import Batch 1', 40, 650000),
('4406', '4306', '2024-01-02 09:15:00', '2024-01-02 09:15:00', '2024-12-31 23:59:59', N'Nhập kho Piano VTech - Lô 1', 'VTech Piano Import Batch 1', 20, 900000),
('4407', '4307', '2024-01-02 10:00:00', '2024-01-02 10:00:00', '2024-08-31 23:59:59', N'Nhập kho Phao bơi Unicorn - Lô mùa hè', 'Unicorn Float Summer Batch', 60, 450000),
('4408', '4308', '2024-01-02 11:30:00', '2024-01-02 11:30:00', '2024-12-31 23:59:59', N'Nhập kho Bộ thí nghiệm - Lô 1', 'Science Kit Import Batch 1', 35, 720000),
('4409', '4309', '2024-01-02 14:00:00', '2024-01-02 14:00:00', '2024-12-31 23:59:59', N'Nhập kho Xe điều khiển - Lô 1', 'RC Car Import Batch 1', 25, 1100000);

-- Insert data into promotion
INSERT INTO promotion (promotion_id, promotion_name, promotion_name2, type, calculate, date_created, date_start, date_end, value, quantity, description, quan_cond, val_cond, oder_tb_cond, group_tb_cond, rank_cond, status)
VALUES 
('4501', N'Khuyến mãi Tháng Thiếu nhi', 'Children Month Sale', 1, 1, '2024-05-01', '2024-05-15', '2024-06-15', 15, 500, N'Giảm giá 15% nhân dịp Tháng Thiếu nhi', 1, 500000, 1, '4101', 1, 1),
('4502', N'Flash Sale Đồ chơi vận động', 'Active Toys Flash Sale', 2, 2, '2024-02-01', '2024-02-10', '2024-02-12', 300000, 100, N'Giảm 300k cho đồ chơi vận động', 1, 2000000, 1, '4102', 2, 1),
('4503', N'Mua 2 tặng 1 - Đồ chơi sáng tạo', 'Buy 2 Get 1 Creative Toys', 3, 3, '2024-03-01', '2024-03-10', '2024-03-20', 1, 200, N'Mua 2 đồ chơi sáng tạo tặng 1', 2, 800000, 1, '4103', 1, 1),
('4504', N'Ưu đãi Robot - Transformer', 'Robot Transformer Sale', 1, 1, '2024-04-01', '2024-04-01', '2024-04-30', 20, 50, N'Giảm 20% cho robot và transformer', 1, 1500000, 2, '4104', 3, 1);

-- Insert data into promotion_product
INSERT INTO promotion_product (promotion_id, product_id, status)
VALUES 
('4501', '4301', 1),
('4501', '4302', 1),
('4502', '4301', 1),
('4502', '4302', 1),
('4503', '4303', 1),
('4504', '4301', 1),
('4504', '4302', 1),
('4504', '4304', 1);

GO

INSERT INTO payment_method (method_id, name, type, description, date_created, fee_rate, url, logo_url, bank, num_account, name_account, refund, sort, status)
VALUES 
('4601', N'Chuyển khoản ngân hàng', 1, N'Thanh toán qua chuyển khoản ngân hàng', '2024-01-01 08:00:00', 0, 'https://vietcombank.com.vn', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Vietcombank_logo_fixed.svg/1200px-Vietcombank_logo_fixed.svg.png', N'Vietcombank', 1234567890, N'Cửa hàng đồ chơi ABC', 1, 1, 1),
('4602', N'Ví điện tử MoMo', 2, N'Thanh toán qua ví MoMo', '2024-01-01 08:30:00', 1, 'https://momo.vn', 'https://play.google.com/store/apps/details?id=com.mservice.momotransfer', NULL, NULL, NULL, 1, 2, 1),
('4603', N'Thẻ tín dụng/ghi nợ', 3, N'Thanh toán bằng thẻ Visa/Mastercard', '2024-01-01 09:00:00', 2, null, null, NULL, NULL, NULL, 1, 3, 1),
('4604', N'Thanh toán khi nhận hàng (COD)', 4, N'Thanh toán tiền mặt khi nhận hàng', '2024-01-01 09:30:00', 0, NULL, null, NULL, NULL, NULL, 0, 4, 1);

-- Insert data into address
INSERT INTO address (address_id, name, phone, description, country, city, district, ward, street, detail, user_id, status)
VALUES 
('4701', N'Nguyễn Văn A', '0901234567', N'Địa chỉ giao hàng chính', N'Việt Nam', N'TP. Hồ Chí Minh', N'Quận 1', N'Phường Bến Nghé', N'Đường Lê Lợi', N'Số 123, Tầng 2', '4', 1),
('4702', N'Trần Thị B - Văn phòng', '0902345678', N'Địa chỉ văn phòng làm việc', N'Việt Nam', N'TP. Hồ Chí Minh', N'Quận 2', N'Phường Thảo Điền', N'Đường Xa lộ Hà Nội', N'Tòa nhà ABC, Tầng 15', '5', 1),
('4703', N'Lê Văn C - Nhà riêng', '0903456789', N'Địa chỉ nhà riêng cuối tuần', N'Việt Nam', N'TP. Hồ Chí Minh', N'Quận 3', N'Phường Võ Thị Sáu', N'Đường Cách Mạng Tháng 8', N'Số 789, Hẻm 25', '6', 1),
('4704', N'Phạm Thị D', '0904567890', N'Địa chỉ giao hàng cho con', N'Việt Nam', N'TP. Hồ Chí Minh', N'Quận 4', N'Phường 18', N'Đường Nguyễn Tất Thành', N'Chung cư XYZ, Căn 1205', '7', 1);

-- Insert data into rating
INSERT INTO rating (product_id, user_id, date_created, rate, description)
VALUES 
('4301', 1, '2024-02-15', 5, N'Bộ LEGO rất chất lượng, con tôi rất thích. Hướng dẫn lắp ráp dễ hiểu, sản phẩm đúng như mô tả.'),
('4301', 2, '2024-02-20', 4, N'Đồ chơi tốt, chỉ có điều giá hơi cao. Nhưng chất lượng xứng đáng với giá tiền.'),
('4302', 3, '2024-03-01', 5, N'Xe đạp rất chắc chắn, con tôi 5 tuổi đi rất vừa. Bánh phụ tháo lắp dễ dàng.'),
('4303', 4, '2024-03-10', 4, N'Đất nặn mềm, không độc hại. Màu sắc đẹp, con thích làm nhiều hình dạng khác nhau.');

-- Insert data into support (lưu ý: bảng order_tb chưa được định nghĩa nên để order_id = NULL)
INSERT INTO support (support_id, user_ask, ask, date_ask, product_id, order_id, user_answer, answer, date_answer, support_in)
VALUES 
('4801', 1, N'Xin hỏi bộ LEGO này có phù hợp với trẻ 6 tuổi không ạ?', '2024-01-20 10:30:00', '4301', NULL, 2, N'Chào bạn! Bộ LEGO City này phù hợp cho trẻ từ 5-12 tuổi. Trẻ 6 tuổi có thể chơi được với sự hỗ trợ của người lớn.', '2024-01-20 11:15:00', NULL),
('4802', 3, N'Xe đạp này có bảo hành bao lâu vậy ạ?', '2024-02-05 14:20:00', '4302', NULL, 2, N'Xe đạp Fisher-Price được bảo hành 12 tháng về lỗi kỹ thuật và 6 tháng về phụ kiện.', '2024-02-05 15:00:00', NULL),
('4803', 4, N'Đất nặn này có an toàn cho trẻ nhỏ không?', '2024-02-25 09:45:00', '4303', NULL, 2, N'Đất nặn Play-Doh hoàn toàn an toàn, không chứa chất độc hại. Tuy nhiên cần giám sát trẻ dưới 3 tuổi khi chơi.', '2024-02-25 10:20:00', NULL),
('4804', 1, N'Robot Optimus Prime này có pin kèm theo không ạ?', '2024-03-15 16:00:00', '4304', NULL, 2, N'Robot không kèm theo pin. Bạn cần mua thêm 3 pin AA để robot có thể phát âm thanh và ánh sáng.', '2024-03-15 16:30:00', NULL);

GO