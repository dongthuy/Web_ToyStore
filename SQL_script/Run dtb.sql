CREATE DATABASE web_code
GO
USE web_code

-- User table
CREATE TABLE user_tb(
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name VARCHAR(25) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    admin BIT DEFAULT 0,
    buyer BIT DEFAULT 1,
    seller BIT DEFAULT 0,
    rank INT DEFAULT 0,
    ban BIT DEFAULT 0,
    freeze BIT DEFAULT 0,
    notify BIT DEFAULT 0,
    date_created DATE,
    status BIT DEFAULT 1
);

-- User details table
CREATE TABLE user_tb2(
    user_id INT PRIMARY KEY,
    name NVARCHAR(50),
    name2 NVARCHAR(50),
    birthday DATE,
    phone_number CHAR(10),
    address NVARCHAR(200),
    email NVARCHAR(50),
    social_url1 NVARCHAR(300) ,
    social_url2 NVARCHAR(300) ,
    social_url3 NVARCHAR(300) ,
    logo_url NVARCHAR(MAX),
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id)
);

-- Category table
CREATE TABLE category(
    category_id VARCHAR(25) PRIMARY KEY,
    category_name NVARCHAR(75) NOT NULL,
    category_name2 NVARCHAR(75),
    description NVARCHAR(1000),
    status BIT DEFAULT 1
);
-- Group table
CREATE TABLE group_tb(
    group_tb_id VARCHAR(25) PRIMARY KEY,
    group_tb_name NVARCHAR(75) NOT NULL,
    group_tb_name2 NVARCHAR(75),
    type INT,
    description NVARCHAR(1000),
    status BIT DEFAULT 1
);

CREATE TABLE brand(
    brand_id VARCHAR(25) PRIMARY KEY,
    brand_name NVARCHAR(75) NOT NULL,
    brand_name2 NVARCHAR(75),
    description NVARCHAR(1000),
    status BIT DEFAULT 1,

);

-- Product table
CREATE TABLE product(
    product_id VARCHAR(25) PRIMARY KEY,
    name NVARCHAR(75) NOT NULL,
    name2 NVARCHAR(75),
    description NVARCHAR(1000),
	brand_id varchar(25),
    category_id VARCHAR(25) NOT NULL,
    group_tb_1 VARCHAR(25),
    group_tb_2 VARCHAR(25),
    group_tb_3 VARCHAR(25),
    group_tb_4 VARCHAR(25),
    uom NVARCHAR(20),
    price1 MONEY,
    date_apply1 DATETIME,
    price2 MONEY,
    date_apply2 DATETIME,
	url_image1 varchar(300),
	url_image2 varchar(300),
	url_image3 varchar(300),
    user_id VARCHAR(25),
    status BIT DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (group_tb_1) REFERENCES group_tb(group_tb_id),
    FOREIGN KEY (group_tb_2) REFERENCES group_tb(group_tb_id),
    FOREIGN KEY (group_tb_3) REFERENCES group_tb(group_tb_id),
    FOREIGN KEY (group_tb_4) REFERENCES group_tb(group_tb_id),
	FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

-- Product inventory table
CREATE TABLE product_in (
    pi_id VARCHAR(25) PRIMARY KEY,
    product_id VARCHAR(25) NOT NULL,
    date_created DATETIME,
    date_start DATETIME DEFAULT GETDATE(),
    date_end DATETIME,
    name NVARCHAR(75) NOT NULL,
    name2 NVARCHAR(75),
    quantity int,
    cost MONEY,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Promotion table
CREATE TABLE promotion (
    promotion_id VARCHAR(25) PRIMARY KEY,
    promotion_name NVARCHAR(75) NOT NULL,
    promotion_name2 NVARCHAR(75),
    type INT NOT NULL,
    calculate INT NOT NULL,
    date_created DATE,
    date_start DATE NOT NULL,
    date_end DATE,
    value int,
    quantity INT,
    description NVARCHAR(1000),
    quan_cond INT,
    val_cond MONEY,
    oder_tb_cond INT,
    group_tb_cond VARCHAR(25),
    rank_cond INT,
    status BIT DEFAULT 1
);

-- Promotion product table
CREATE TABLE promotion_product (
    promotion_id VARCHAR(25),
    product_id VARCHAR(25),
    status BIT DEFAULT 1,
    PRIMARY KEY (promotion_id, product_id),
    FOREIGN KEY (promotion_id) REFERENCES promotion(promotion_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Brand table


-- Tax table
CREATE TABLE tax (
    tax_id VARCHAR(25) PRIMARY KEY,
    seq_num INT,
    tax_name NVARCHAR(75),
    tax_name2 NVARCHAR(75),
    date_created DATE,
    date_start DATE,
    date_end DATE,
    description NVARCHAR(1000),
    rate NUMERIC,
    quan_cond INT,
    val_cond MONEY,
    group_tb_cond VARCHAR(25),
    rank_cond INT,
    status BIT DEFAULT 1
);

-- Order table
CREATE TABLE order_tb (
    order_id VARCHAR(25) PRIMARY KEY,
    date_created DATE,
    buyer INT,
    seller INT,
    pro_ship VARCHAR(25),
    pro_new VARCHAR(25),
    pro_saleoff VARCHAR(25),
    pro_discount VARCHAR(25),
    description NVARCHAR(1000),
    status INT DEFAULT 0,
    FOREIGN KEY (pro_ship) REFERENCES promotion(promotion_id),
    FOREIGN KEY (pro_new) REFERENCES promotion(promotion_id),
    FOREIGN KEY (pro_saleoff) REFERENCES promotion(promotion_id),
    FOREIGN KEY (pro_discount) REFERENCES promotion(promotion_id)
);




-- Cart table
CREATE TABLE cart (
    user_id INT,
    product_id VARCHAR(25),
    product_name NVARCHAR(75),
    quantity INT,
    price MONEY,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Order detail table
CREATE TABLE order_d (
    order_id VARCHAR(25),
    product_id VARCHAR(25),
	pi_id VARCHAR(25),
    quantity INT,
    cost MONEY,
    price MONEY,
	tax VARCHAR(25),
    PRIMARY KEY (order_id, product_id, pi_id),
    FOREIGN KEY (order_id) REFERENCES order_tb(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (tax) REFERENCES tax(tax_id),
	FOREIGN KEY (pi_id) REFERENCES product_in(pi_id)
);

-- Payment method table
CREATE TABLE payment_method (
    method_id VARCHAR(25) PRIMARY KEY,
    name NVARCHAR(75),
    type INT,
    description NVARCHAR(1000),
    date_created DATETIME,
    fee_rate INT,
    url NVARCHAR(200),
    logo_url NVARCHAR(200),
    bank NVARCHAR(100),
    num_account INT,
	name_account nvarchar(75),
    refund BIT,
    sort INT,
    status BIT DEFAULT 1
);

-- Invoice table
CREATE TABLE invoice (
    invoice_id VARCHAR(25) PRIMARY KEY,
    order_id VARCHAR(25),
    date_created DATE,
    date_payment DATE,
    method VARCHAR(25),
    amount MONEY,
    ship_amount MONEY,
    tax_amount MONEY,
    promotion MONEY,
    cost MONEY,
    amount_payable MONEY,
    payment MONEY,
    balanced MONEY,
    description NVARCHAR(1000),
    status INT DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES order_tb(order_id),
    FOREIGN KEY (method) REFERENCES payment_method(method_id)
);

-- Wishlist table
CREATE TABLE wishlist (
    user_id INT,
    product_id VARCHAR(25),
    product_name VARCHAR(25),
    product_description NVARCHAR(1000),
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Rating table
CREATE TABLE rating (
    product_id VARCHAR(25),
    user_id INT,
    date_created DATE,
    rate INT,
    description NVARCHAR(1000),
    PRIMARY KEY (product_id, user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id)
);


-- Log history table
CREATE TABLE log_hisory (
    user_id INT,
    date_log DATETIME,
    IP VARCHAR(50),
    status INT,
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id)
);

-- Change history table
CREATE TABLE change_history (
    user_id INT,
    date_act DATETIME,
    type VARCHAR(25),
    table_change VARCHAR(25),
    old_val NVARCHAR(MAX),
    new_val NVARCHAR(MAX),
    status INT,
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id)
);

-- Address table
CREATE TABLE address (
    address_id VARCHAR(25) PRIMARY KEY,
    name NVARCHAR(75),
    phone CHAR(10),
    description NVARCHAR(1000),
    country NVARCHAR(75),
    city NVARCHAR(75),
    district NVARCHAR(75),
    ward NVARCHAR(75),
    street NVARCHAR(75),
    detail NVARCHAR(75),
    user_id VARCHAR(25),
    status BIT DEFAULT 1
);

-- Shipment table
CREATE TABLE shipment (
    shipment_id VARCHAR(25) PRIMARY KEY,
    date_created DATETIME,
    date_receipt DATETIME,
    date_est_deli DATETIME,
    date_actual_deli DATETIME,
    shipper1_id VARCHAR(25),
    shipper1_name NVARCHAR(75),
    phone1 CHAR(10),
    shipper2_id VARCHAR(25),
    shipper2_name NVARCHAR(75),
    phone2 CHAR(10),
    order_id VARCHAR(25),
    address_id VARCHAR(25),
    name_receive NVARCHAR(75),
    phone_receive CHAR(10),
    description NVARCHAR(1000),
    status INT DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES order_tb(order_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Shipment detail table
CREATE TABLE shipment_d (
    shipment_id VARCHAR(25),
    product_id VARCHAR(25),
    order_id VARCHAR(25),
    quantity INT,
    PRIMARY KEY (shipment_id, product_id, order_id),
    FOREIGN KEY (shipment_id) REFERENCES shipment(shipment_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (order_id) REFERENCES order_tb(order_id)
);

-- Support table
CREATE TABLE support (
    support_id VARCHAR(25) PRIMARY KEY,
    user_ask int,
    ask NVARCHAR(1000),
    date_ask DATETIME,
    product_id VARCHAR(25),
    order_id VARCHAR(25),
    user_answer int,
    answer NVARCHAR(1000),
    date_answer DATETIME,
    support_in VARCHAR(25),
    FOREIGN KEY (user_ask) REFERENCES user_tb(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (order_id) REFERENCES order_tb(order_id),
    FOREIGN KEY (user_answer) REFERENCES user_tb(user_id),
);

-- Chat table
CREATE TABLE chat_tab (
    chat_id VARCHAR(25) PRIMARY KEY,
    date_created DATETIME,
    name NVARCHAR(75)
); 

-- Chat member table
CREATE TABLE chat_member (
    member_id INT PRIMARY KEY IDENTITY(1,1),
    member_name NVARCHAR(75),
    user_id INT,
    chat_id VARCHAR(25),
    date_joined DATETIME,
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id),
    FOREIGN KEY (chat_id) REFERENCES chat_tab(chat_id)
);

-- Chat detail table
CREATE TABLE chat_detail (
    chat_rec INT identity(1,1),
    member_send INT not null,
    name_send INT,
    msg_txt NVARCHAR(MAX),
    date_created DATETIME,
    chat_reply INT,
    member_reply INT,
    isRead BIT,
    pin BIT,
    PRIMARY KEY (chat_rec)
);




---Click product
CREATE TABLE click_product (
    click_rec INT IDENTITY(1,1) PRIMARY KEY, -- Auto-increment click record
    product_id VARCHAR(25) NOT NULL,
    user_id INT NOT NULL,
    date_click DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id)
);

-- index cho việc truy vấn đơn hàng theo thời gian tạo gần nhất
CREATE NONCLUSTERED INDEX idx_order_user_date ON order_tb(buyer, date_created DESC);

-- Cho việc tính tổng tồn kho
CREATE NONCLUSTERED INDEX IX_product_in_product_id 
ON product_in(product_id)
INCLUDE (quantity);

CREATE NONCLUSTERED INDEX IX_product_filter 
ON product(category_id, group_tb_1, group_tb_2, group_tb_3, group_tb_4, status)
INCLUDE (product_id, name, description);

-- Cho việc tính tổng đã bán
CREATE NONCLUSTERED INDEX IX_order_d_product_id 
ON order_d(product_id)
INCLUDE (quantity);
-- Cho đăng nhập
CREATE NONCLUSTERED INDEX idx_login_username ON user_tb(user_name);

-- Truy vấn theo trạng thái đơn hàng
CREATE NONCLUSTERED INDEX idx_order_status ON order_tb(status);



go


------ Xóa sản phẩm trong giỏ hàng
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteCartItem') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteCartItem
go

CREATE PROCEDURE sp_DeleteCartItem
@user_id INT,
@product_id VARCHAR(25)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
    -- Kiểm tra xem sản phẩm có trong giỏ hàng của người dùng không
    IF EXISTS (
        SELECT 1
        FROM cart
        WHERE user_id = @user_id AND product_id = @product_id
    )
    BEGIN
        DELETE FROM cart
        WHERE user_id = @user_id AND product_id = @product_id;

        PRINT N'Đã xóa sản phẩm khỏi giỏ hàng.';
    END
    ELSE
    BEGIN
        RAISERROR(N'Sản phẩm không tồn tại trong giỏ hàng.', 16, 1);
    END
END TRY
BEGIN CATCH
    DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@Err, 16, 1);
END CATCH

END;

GO
----- Xóa toàn bộ giỏ hàng
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_ClearCart') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_ClearCart
GO

CREATE PROCEDURE sp_ClearCart
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Kiểm tra người dùng có giỏ hàng không
        IF EXISTS (SELECT 1 FROM cart WHERE user_id = @user_id)
        BEGIN
            DELETE FROM cart WHERE user_id = @user_id;
            PRINT N'Đã xóa toàn bộ giỏ hàng của người dùng.';
        END
        ELSE
        BEGIN
            RAISERROR(N'Giỏ hàng đã trống.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END;

go 

----- Xóa sản phẩm trong wishlist
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteFromWishlist') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteFromWishlist
GO

CREATE PROCEDURE sp_DeleteFromWishlist
@user_id INT,
@product_id VARCHAR(25)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
    IF EXISTS (SELECT 1 FROM wishlist WHERE user_id = @user_id AND product_id = @product_id)
    BEGIN
        DELETE FROM wishlist
        WHERE user_id = @user_id AND product_id = @product_id;

        PRINT N'Đã xóa sản phẩm khỏi danh sách yêu thích.';
    END
    ELSE
    BEGIN
        RAISERROR(N'Sản phẩm không tồn tại trong danh sách yêu thích.', 16, 1);
    END
END TRY
BEGIN CATCH
    DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrMsg, 16, 1);
END CATCH

END;

go
----Xóa toàn bộ wishlist
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_ClearWishlist') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_ClearWishlist
GO

CREATE PROCEDURE sp_ClearWishlist
@user_id INT
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
    IF EXISTS (SELECT 1 FROM wishlist WHERE user_id = @user_id)
    BEGIN
        DELETE FROM wishlist
        WHERE user_id = @user_id;

        PRINT N'Đã xóa toàn bộ sản phẩm trong danh sách yêu thích.';
    END
    ELSE
    BEGIN
        RAISERROR(N'Danh sách yêu thích trống.', 16, 1);
    END
END TRY
BEGIN CATCH
    DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrMsg, 16, 1);
END CATCH

END;
Go

------ Xóa rating theo sản phẩm hoặc người đánh giá phải truyền tham số
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteRating') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteRating
GO

CREATE PROCEDURE sp_DeleteRating
@product_id VARCHAR(25) = NULL,
@user_id INT = NULL
AS
BEGIN
SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM user_tb WHERE user_id = @user_id AND ( admin = 1 ))
	BEGIN
	BEGIN TRY  
    IF @product_id IS NULL AND @user_id IS NULL  
    BEGIN  
        RAISERROR(N'Phải cung cấp ít nhất một trong hai tham số: product_id hoặc user_id.', 16, 1);  
        RETURN;  
    END  

    DELETE FROM rating  
    WHERE (@product_id IS NULL OR product_id = @product_id)  
      AND (@user_id IS NULL OR user_id = @user_id);  

    PRINT N'Xóa đánh giá thành công.'  
END TRY  
BEGIN CATCH  
    DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();  
    RAISERROR(@ErrMsg, 16, 1);  
END CATCH  
END
	 BEGIN
        RAISERROR(N'Bạn không phải admin hoặc không phải người rate, không thể xóa', 16, 1);
    END
END;
GO

------ Loại bỏ sản phẩm áp dụng promotion
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeletePromotionProducts') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeletePromotionProducts
GO

CREATE PROCEDURE sp_DeletePromotionProducts
    @promotion_id VARCHAR(25) = '',
    @product_ids NVARCHAR(MAX) = ''  -- Chuỗi các product_id, phân tách bằng dấu phẩy
AS
BEGIN
    SET NOCOUNT ON;

    IF @promotion_id IS NULL OR LTRIM(RTRIM(@promotion_id)) = ''
    BEGIN
        RAISERROR(N'Mã khuyến mãi không được để trống.', 16, 1);
        RETURN;
    END

    IF @product_ids IS NULL OR LTRIM(RTRIM(@product_ids)) = ''
    BEGIN
        RAISERROR(N'Danh sách sản phẩm không được để trống.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        -- Tách chuỗi product_ids thành bảng tạm
        DECLARE @ProductList TABLE (product_id VARCHAR(25));

        INSERT INTO @ProductList (product_id)
        SELECT LTRIM(RTRIM(value))
        FROM STRING_SPLIT(@product_ids, ',')
        WHERE LTRIM(RTRIM(value)) <> '';

        DELETE FROM promotion_product
        WHERE promotion_id = @promotion_id
        AND product_id IN (SELECT product_id FROM @ProductList);

        PRINT N'Đã xóa sản phẩm khỏi khuyến mãi thành công.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END

GO

------ Xóa nhập hàng, có thể xóa theo danh sách nhập hàng
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteProductIn') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteProductIn
GO

CREATE PROCEDURE sp_DeleteProductIn
    @pi_ids NVARCHAR(MAX) = ''  -- Chuỗi các pi_id, phân tách bằng dấu phẩy
AS
BEGIN
    SET NOCOUNT ON;

    IF @pi_ids IS NULL OR LTRIM(RTRIM(@pi_ids)) = ''
    BEGIN
        RAISERROR(N'Danh sách mã nhập kho (pi_id) không được để trống.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        DECLARE @PIList TABLE (pi_id VARCHAR(25));

        -- Chuyển chuỗi phân tách thành bảng
        INSERT INTO @PIList (pi_id)
        SELECT LTRIM(RTRIM(value))
        FROM STRING_SPLIT(@pi_ids, ',')
        WHERE LTRIM(RTRIM(value)) <> '';

        DELETE FROM product_in
        WHERE pi_id IN (SELECT pi_id FROM @PIList);

        PRINT N'Xóa dòng nhập kho thành công.';
    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END
GO

---- Xóa tin nhắn
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteChatMessage') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteChatMessage
GO

CREATE PROCEDURE sp_DeleteChatMessage
    @chat_rec INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @chat_rec IS NULL
    BEGIN
        RAISERROR(N'Mã tin nhắn không được để trống.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        DELETE FROM chat_detail
        WHERE chat_rec = @chat_rec;

        PRINT N'Đã xóa tin nhắn thành công.';
    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END

GO
----- Xóa member chat
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteChatMember') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteChatMember
GO

CREATE PROCEDURE sp_DeleteChatMember
    @member_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra member_id có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM chat_member WHERE member_id = @member_id)
    BEGIN
        RAISERROR(N'Thành viên không tồn tại.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        DELETE FROM chat_member
        WHERE member_id = @member_id;

        PRINT N'Xóa thành viên thành công.';
    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END

GO
-----Xóa chat tab, xóa toàn bộ tin nhắn và thành viên liên quan
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteChatTab') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteChatTab
GO

CREATE PROCEDURE sp_DeleteChatTab
    @chat_id VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        
        -- Kiểm tra chat_id có tồn tại
        IF NOT EXISTS (SELECT 1 FROM chat_tab WHERE chat_id = @chat_id)
        BEGIN
            RAISERROR(N'Mã chat không tồn tại.', 16, 1);
            RETURN;
        END
		
        -- Xóa toàn bộ tin nhắn liên quan đến chat_id
        DELETE FROM chat_detail
        WHERE chat_rec IN (
            SELECT cd.chat_rec
            FROM chat_detail cd
            JOIN chat_member cm ON cd.member_send = cm.member_id OR cd.member_reply = cm.member_id
            WHERE cm.chat_id = @chat_id
        );

		DELETE FROM chat_member WHERE chat_id = @chat_id
        -- Xóa bản ghi chat_tab
        DELETE FROM chat_tab
        WHERE chat_id = @chat_id;

        PRINT N'Đã xóa thành công chat tab và các tin nhắn liên quan.';
    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END

Go
------Xóa hóa đơn
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteInvoice') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteInvoice
GO

CREATE PROCEDURE sp_DeleteInvoice
    @invoice_id VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM invoice WHERE invoice_id = @invoice_id)
        BEGIN
            DELETE FROM invoice WHERE invoice_id = @invoice_id;
            PRINT N'Đã xóa hóa đơn: ' + @invoice_id;
        END
        ELSE
        BEGIN
            RAISERROR(N'Hóa đơn không tồn tại: %s', 16, 1, @invoice_id);
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END

GO

----- Xóa địa chỉ
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteAddress') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteAddress
GO

CREATE PROCEDURE sp_DeleteAddress
@address_id VARCHAR(25)
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM address WHERE address_id = @address_id)
    BEGIN
        RAISERROR(N'Không tìm thấy địa chỉ với ID này.', 16, 1);
        RETURN;
    END

    DELETE FROM address WHERE address_id = @address_id;

    PRINT N'Địa chỉ đã được xóa thành công.';
END TRY
BEGIN CATCH
    DECLARE @ErrMsg NVARCHAR(1000) = ERROR_MESSAGE();
    DECLARE @ErrNum INT = ERROR_NUMBER();

    -- Kiểm tra lỗi do ràng buộc khóa ngoại
    IF @ErrNum = 547
    BEGIN
        RAISERROR(N'Không thể xóa địa chỉ vì đang được sử dụng trong các bảng khác', 16, 1);
    END
    ELSE
    BEGIN
        RAISERROR(@ErrMsg, 16, 1);
    END
END CATCH

END;
GO


----Xóa đơn giao hàng
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_DeleteShipment') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_DeleteShipment
GO

CREATE PROCEDURE sp_DeleteShipment
    @shipment_id VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM shipment WHERE shipment_id = @shipment_id)
        BEGIN
            DELETE FROM shipment_d WHERE shipment_id = @shipment_id;
			DELETE FROM shipment WHERE shipment_id = @shipment_id;
            PRINT N'Đã xóa đơn giao hàng: ' + @shipment_id;
        END
        ELSE
        BEGIN
            RAISERROR(N'Đơn giao hàng không tồn tại: %s', 16, 1, @shipment_id);
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO

USE web_code
go 
---Thêm từ đây
CREATE OR ALTER PROCEDURE sp_login_user
    @user_name VARCHAR(25),
    @password VARCHAR(100),
	@ip_address VARCHAR(50)
	---Thêm tới đây
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = NULL;
	-- Kiểm tra tồn tại user
    IF NOT EXISTS (
        SELECT 1 FROM user_tb WHERE user_name = @user_name
    )
    BEGIN
        EXEC sp_InsertLogHistory NULL, @ip_address, 0;
        SELECT N'Tài khoản không tồn tại' AS message, 0 AS success;
        RETURN;
    END
		-- Khai báo biến
    DECLARE 
        @ban BIT, 
        @freeze BIT, 
        @real_password VARCHAR(100);

    -- Lấy thông tin tài khoản
    SELECT 
        @ban = ban,
        @freeze = freeze,
        @real_password = password,
        @user_id = user_id
    FROM user_tb
    WHERE user_name = @user_name;

    -- Kiểm tra trạng thái
    IF @ban = 1 OR @freeze = 1
    BEGIN
        EXEC sp_InsertLogHistory @user_id, @ip_address, 0;

        SELECT 
            CASE 
                WHEN @ban = 1 THEN N'Tài khoản đã bị khóa'
                WHEN @freeze = 1 THEN N'Tài khoản đang bị tạm khóa'
            END AS message,
            0 AS success;
        RETURN;
    END

    -- Kiểm tra mật khẩu
    IF @real_password != @password
    BEGIN
        EXEC sp_InsertLogHistory @user_id, @ip_address, 0;
        SELECT N'Sai tên đăng nhập hoặc mật khẩu' AS message, 0 AS success;
        RETURN;
    END

    -- Đăng nhập thành công
    EXEC sp_set_session_context 'user_id', @user_id;
    EXEC sp_InsertLogHistory @user_id, @ip_address, 1;

    SELECT 
        N'Đăng nhập thành công' AS message,
        1 AS success,
        user_id,
        user_name,
        admin,
        buyer,
        seller,
        rank,
        status,
        notify,
        date_created
    FROM user_tb
    WHERE user_name = @user_name;
END

---- Store lọc sản phẩm và hiển thị số lượng, lượt voucher còn lại
go
CREATE OR ALTER PROCEDURE sp_filter_product_inventory
    @product_id VARCHAR(25) = '',
    @category_id VARCHAR(25) = '',
    @group VARCHAR(25) = '',
    @product_name NVARCHAR(75) = '',
    @price_from MONEY = NULL,
    @price_to MONEY = NULL,
    @order_by VARCHAR(50) = '',
    @type_order_by VARCHAR(10) = 'ASC'
AS
BEGIN
    SET NOCOUNT ON;

    -- Dữ liệu tạm từ view
    SELECT 
        v.*,
        -- Tính số lượng còn lại
        ISNULL(v.quantity_available, 0) AS quantity_remaining,
        -- Trạng thái hết hàng
        CASE WHEN ISNULL(v.quantity_available, 0) <= 0 THEN 1 ELSE 0 END AS out_of_stock_flag, ------- nếu hết hàng thì giá trị 1
        -- Mặc định chưa có giảm giá
        NULL AS promo_value,
        NULL AS discounted_price
    INTO #t
    FROM vw_product_inventory v
    WHERE 
        (@product_id = '' OR v.product_id LIKE '%' + @product_id + '%') AND
        (@category_id = '' OR v.category_id = @category_id) AND
        (@group = '' OR v.group_tb_1 = @group OR v.group_tb_2 = @group OR v.group_tb_3 = @group OR v.group_tb_4 = @group) AND
        v.pro_status = 1 AND v.brand_status = 1 AND
        (
            @product_name = '' 
            OR v.name LIKE '%' + @product_name + '%' 
            OR v.name2 LIKE '%' + @product_name + '%'
        ) AND
        (@price_from IS NULL OR v.price >= @price_from) AND
        (@price_to IS NULL OR v.price <= @price_to);

    -- Cập nhật giảm giá cho sản phẩm nếu có promotion loại 2 còn hiệu lực
    UPDATE t
    SET 
        promo_value = p.value,
        discounted_price = t.price1 - (t.price1 * p.value / 100.0)
    FROM #t t
    INNER JOIN (
        SELECT 
            pp.product_id, 
            MAX(p.value) AS value
        FROM promotion_product pp
        INNER JOIN promotion p ON pp.promotion_id = p.promotion_id
        WHERE 
            p.status = 1 AND pp.status = 1 AND
            p.type = 2 AND
            GETDATE() BETWEEN p.date_start AND ISNULL(p.date_end, GETDATE())
        GROUP BY pp.product_id
    ) p ON t.product_id = p.product_id;

    -- Output 1
    DECLARE @sql1 NVARCHAR(MAX) = N'SELECT * FROM #t';
    IF @order_by != ''
        SET @sql1 += N' ORDER BY ' + QUOTENAME(@order_by) + ' ' + 
                     CASE WHEN UPPER(@type_order_by) = 'DESC' THEN 'DESC' ELSE 'ASC' END;
    EXEC sp_executesql @sql1;

    -- Dữ liệu khuyến mãi còn hiệu lực
    SELECT * INTO #promotion
    FROM vw_promotion_used
    WHERE quantity_total = 0 OR (quantity_available > 0 AND quantity_total > 0);

    -- Output 2: chi tiết khuyến mãi
    DECLARE @sql2 NVARCHAR(MAX) = N'
        SELECT p1.product_id, p2.*, p3.quantity_available
        FROM #t t
        INNER JOIN promotion_product p1 ON t.product_id = p1.product_id
        LEFT JOIN promotion p2 ON p1.promotion_id = p2.promotion_id
        LEFT JOIN #promotion p3 ON p1.promotion_id = p3.promotion_id
        WHERE p1.status = 1 AND p2.status = 1';

    IF @order_by != ''
        SET @sql2 += N' ORDER BY ' + QUOTENAME(@order_by) + ' ' + 
                     CASE WHEN UPPER(@type_order_by) = 'DESC' THEN 'DESC' ELSE 'ASC' END;
    EXEC sp_executesql @sql2;

    DROP TABLE #t;
    DROP TABLE #promotion;
END
GO


GO



------- Store truy vấn đơn mua hàng

CREATE OR ALTER PROCEDURE sp_get_orders_by_buyer
    @buyer_id INT = -1,
    @from_date DATE = NULL,
    @to_date DATE = NULL,
    @order_id VARCHAR(25) = '',
	@status int = -1,
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON;
	IF @admin = 1
BEGIN
	-----out1: Kiểm tra quyền admin để truy vấn
	IF NOT EXISTS (
        SELECT 1 FROM user_tb WHERE user_id = @buyer_id AND admin = 1)
	BEGIN
 		SET @admin = 0
		SELECT (N'Người dùng không có quyền admin, tải đơn hàng theo người mua') as message, 0 As status_query;
	END
	ELSE SELECT (N'Truy vấn quyền admin, tải tất cả đơn hàng') as message, 1 As status_query;

END

    -- Tạo bảng tạm để lưu trữ danh sách đơn hàng
    CREATE TABLE #OrderList (
        order_id VARCHAR(25),
        date_created DATETIME,
        buyer INT,
        seller INT,
        status INT,
        pro_ship INT,
        pro_new INT,
        pro_saleoff INT,
        pro_discount INT,
        description VARCHAR(255)
    );

    -----
    INSERT INTO #OrderList (order_id, date_created, buyer, seller, status, pro_ship, pro_new, pro_saleoff, pro_discount, description)
    SELECT
        o.order_id,
        o.date_created,
        o.buyer,
        o.seller,
        o.status,
        o.pro_ship,
        o.pro_new,
        o.pro_saleoff,
        o.pro_discount,
        o.description
    FROM order_tb o
    WHERE (o.buyer = @buyer_id OR @buyer_id = -1 OR @admin = 1)
      AND (@from_date IS NULL OR o.date_created >= @from_date)
      AND (@to_date IS NULL OR o.date_created <= @to_date)
      AND (@order_id = '' OR @order_id = o.order_id)
	  AND (o.status = @status OR @status = -1)
    ORDER BY date_created DESC;
---- Output 2: Danh sách đơn hàng
    SELECT * FROM #OrderList;

    -- Output 3: Chi tiết sản phẩm trong đơn hàng
    SELECT
        od.order_id,
        od.product_id,
        p.name AS product_name,
		p.url_image1,
		p.url_image2,
		p.url_image3,
        p.description,
        od.quantity,
        od.cost,
        od.price,
        od.tax
    FROM #OrderList ol
    INNER JOIN order_d od ON ol.order_id = od.order_id
    INNER JOIN product p ON od.product_id = p.product_id
    ORDER BY ol.date_created DESC, od.order_id;

    -- Xóa bảng tạm
    DROP TABLE #OrderList;
END;

Go



------- Store truy vấn đơn bán hàng

Create OR ALTER PROCEDURE sp_get_orders_by_seller
    @seller_id INT = -1,
    @from_date DATE = NULL,
    @to_date DATE = NULL,
    @order_id VARCHAR(25) = '',
	@status int = -1
AS
BEGIN
    SET NOCOUNT ON;

    -- Tạo bảng tạm để lưu trữ danh sách đơn hàng
    CREATE TABLE #OrderList (
        order_id VARCHAR(25),
        date_created DATETIME,
        buyer INT,
        seller INT,
        status INT,
        pro_ship INT,
        pro_new INT,
        pro_saleoff INT,
        pro_discount INT,
        description VARCHAR(255)
    );

    -- Output 1: Danh sách đơn hàng
    INSERT INTO #OrderList (order_id, date_created, buyer, seller, status, pro_ship, pro_new, pro_saleoff, pro_discount, description)
    SELECT
        o.order_id,
        o.date_created,
        o.buyer,
        o.seller,
        o.status,
        o.pro_ship,
        o.pro_new,
        o.pro_saleoff,
        o.pro_discount,
        o.description
    FROM order_tb o
    WHERE (o.seller = @seller_id OR @seller_id = -1)
      AND (@from_date IS NULL OR o.date_created >= @from_date)
      AND (@to_date IS NULL OR o.date_created <= @to_date)
      AND (@order_id = '' OR @order_id = o.order_id)
	  AND (o.status = @status OR @status = -1)
    ORDER BY date_created DESC;

    SELECT * FROM #OrderList;

    -- Output 2: Chi tiết sản phẩm trong đơn hàng
    SELECT
        od.order_id,
        od.product_id,
        p.name AS product_name,
        p.description,
		p.url_image1,
		p.url_image2,
		p.url_image3,
        od.quantity,
        od.cost,
        od.price,
        od.tax
    FROM #OrderList ol
    INNER JOIN order_d od ON ol.order_id = od.order_id
    INNER JOIN product p ON od.product_id = p.product_id
    ORDER BY ol.date_created DESC, od.order_id;

    -- Xóa bảng tạm
    DROP TABLE #OrderList;
END;

Go





------- STORE truy vấn đơn hàng, hóa đơn, chi tiết đơn hàng

CREATE OR ALTER PROCEDURE sp_get_invoice_details
    @invoice_id VARCHAR(25) = '',
	@buyer_id int = -1,
	@seller_id int = -1,
	@order_id VARCHAR(25) = '',
    @date_invoice_from DATE = NULL,
    @date_invoice_to DATE = NULL,
    @date_order_from DATE = NULL,
    @date_order_to DATE = NULL,
    @method VARCHAR(25) = '',
    @status INT = -1
AS
BEGIN
    SET NOCOUNT ON;

	----Filter hóa đơn, đơn hàng theo điều kiện lọc
    SELECT 
        i.invoice_id,
        i.order_id,
        o.date_created AS order_date,
        i.date_created AS invoice_date,
        i.date_payment,
        i.method,
        pm.name AS payment_method,
        i.amount,
        i.tax_amount,
        i.promotion AS promotion_amount,
        i.amount_payable,
        i.payment,
        i.balanced,
        i.description AS invoice_description,
        o.description AS order_description,
        i.status AS invoice_status
	INTO #invoice_filtered
    FROM invoice i
    LEFT JOIN order_tb o ON i.order_id = o.order_id
    LEFT JOIN payment_method pm ON i.method = pm.method_id
    WHERE 
        (@invoice_id = '' OR i.invoice_id = @invoice_id) AND
	(@seller_id = -1 OR o.seller = @seller_id) AND
	(@buyer_id = -1 OR o.buyer = @buyer_id) AND
		(@order_id = '' OR o.order_id = @invoice_id) AND
        (@method = '' OR i.method = @method) AND
        (@status = -1 OR i.status = @status) AND
        (@date_invoice_from IS NULL OR i.date_created >= @date_invoice_from) AND
        (@date_invoice_to IS NULL OR i.date_created <= @date_invoice_to) AND
        (@date_order_from IS NULL OR o.date_created >= @date_order_from) AND
        (@date_order_to IS NULL OR o.date_created <= @date_order_to)
	ORDER BY invoice_date, order_date;
    ----------------------
    -- Output 1: Thông tin hóa đơn + đơn hàng
    ----------------------

	SELECT * FROM #invoice_filtered;
    ------------------------
    -- Bước 2: Output 2 – Chi tiết đơn hàng liên kết
    ------------------------
    SELECT 
        od.order_id,
        od.product_id,
        p.name AS product_name,
        od.quantity,
        od.price,
        od.cost,
        od.tax
    FROM order_d od
    INNER JOIN #invoice_filtered f ON od.order_id = f.order_id
    LEFT JOIN product p ON od.product_id = p.product_id;

    ------------------------
    -- Bước 3: Output 3 – Chi tiết khuyến mãi sử dụng
    ------------------------
    SELECT 
        p.promotion_id,
        p.promotion_name,
        p.promotion_name2,
        p.type,
        p.calculate,
        p.value,
        p.description,
        p.date_start,
        p.date_end,
        f.order_id
    FROM #invoice_filtered f
    INNER JOIN order_tb o ON f.order_id = o.order_id
    LEFT JOIN promotion p ON 
        p.promotion_id IN (
            o.pro_discount, o.pro_new, o.pro_saleoff, o.pro_ship
        )
    WHERE p.status = 1;

    ------------------------
    -- Clean up
    ------------------------
    DROP TABLE #invoice_filtered;
END;
GO





------- Store top sản phẩm bán chạy

CREATE OR ALTER PROCEDURE sp_get_top_selling_products
	@user_id int = -1,
    @date_from DATE = NULL,
    @date_to DATE = NULL,
	@category VARCHAR(25) = '',
	@brand_id VARCHAR(25) = '',
    @group VARCHAR(25) = '',
    @top_n INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@top_n)
        p.product_id,
        p.name,
        p.group_tb_1,
        p.group_tb_2,
        p.group_tb_3,
        p.group_tb_4,
        SUM(od.quantity) AS total_quantity_sold,
        SUM(od.price * od.quantity) AS total_revenue
    FROM order_d od
    INNER JOIN order_tb o ON od.order_id = o.order_id
    INNER JOIN product p ON od.product_id = p.product_id
    WHERE 
		(@user_id = -1 OR @user_id = o.seller) AND 
        (@date_from IS NULL OR o.date_created >= @date_from) AND
        (@date_to IS NULL OR o.date_created <= @date_to) AND
        (@group = '' OR p.group_tb_1 = @group) AND
        (@group = '' OR p.group_tb_2 = @group) AND
        (@group = '' OR p.group_tb_3 = @group) AND
        (@group = '' OR p.group_tb_4 = @group) AND
		(@category = '' OR p.category_id = @category) AND
        (@brand_id = '' OR p.brand_id = @brand_id) -- Nếu brand là group_tb_1
    GROUP BY 
        p.product_id, p.name, 
        p.group_tb_1, p.group_tb_2, p.group_tb_3, p.group_tb_4
    ORDER BY 
        total_quantity_sold DESC;
END;
GO






-------- Lọc tổng đơn hàng, daonh thu, chi phí, giá trị khuyến mãi
CREATE OR ALTER PROCEDURE sp_report_order_summary_by_seller
    @seller_id INT = -1,
    @date_from DATE = NULL,
    @date_to DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        o.seller,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ISNULL(SUM(i.amount), 0) AS total_revenue,
        ISNULL(SUM(i.cost), 0) AS total_cost,
        ISNULL(SUM(i.promotion), 0) AS total_promotion
    FROM order_tb o
    LEFT JOIN invoice i ON o.order_id = i.order_id
    WHERE 
        (@seller_id = -1 OR o.seller = @seller_id) AND
        (@date_from IS NULL OR o.date_created >= @date_from) AND
        (@date_to IS NULL OR o.date_created <= @date_to) AND
        o.status >= 1 -- Chỉ tính đơn hàng đã được xử lý
    GROUP BY o.seller;
END;
GO






------ Lọc đánh giá sản phẩm

CREATE OR ALTER PROCEDURE sp_report_product_rating_summary
    @product_id VARCHAR(25) = '',
    @date_from DATE = NULL,
    @date_to DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Tạm lưu danh sách sản phẩm phù hợp
    SELECT DISTINCT r.product_id
    INTO #filtered_products
    FROM rating r
    WHERE 
        (@product_id = '' OR r.product_id = @product_id) AND
        (@date_from IS NULL OR r.date_created >= @date_from) AND
        (@date_to IS NULL OR r.date_created <= @date_to);

    -- Output 1: Tổng hợp điểm đánh giá theo sản phẩm
    SELECT 
        p.product_id,
        p.name,
        COUNT(r.rate) AS total_reviews,
        AVG(CAST(r.rate AS FLOAT)) AS avg_rate,
        MAX(r.rate) AS max_rate,
        MIN(r.rate) AS min_rate
    FROM #filtered_products f
    JOIN product p ON f.product_id = p.product_id
    JOIN rating r ON p.product_id = r.product_id
    WHERE 
        (@date_from IS NULL OR r.date_created >= @date_from) AND
        (@date_to IS NULL OR r.date_created <= @date_to)
    GROUP BY p.product_id, p.name;
	
    -- Output 2: Chi tiết đánh giá theo danh sách sản phẩm đã lọc
    SELECT 
        r.product_id,
        u.user_name,
        r.rate,
        r.date_created,
        r.description
    FROM #filtered_products f
    JOIN rating r ON f.product_id = r.product_id
    JOIN user_tb u ON r.user_id = u.user_id
    WHERE 
        (@date_from IS NULL OR r.date_created >= @date_from) AND
        (@date_to IS NULL OR r.date_created <= @date_to)
    ORDER BY r.date_created DESC;

    DROP TABLE #filtered_products;
END;
GO




CREATE OR ALTER PROCEDURE sp_report_shipment_summary
	@buyer int = -1,
	@seller int = -1,
    @shipment_id VARCHAR(25) = '',
    @order_id VARCHAR(25) = '',
    @shipper_id VARCHAR(25) = '',
    @date_from DATETIME = NULL,
    @date_to DATETIME = NULL,
    @status INT = -1
AS
BEGIN
    SET NOCOUNT ON;

    -- Output 1: Tổng hợp thông tin giao hàng
    SELECT 
        s.shipment_id,
        s.order_id,
        s.date_created,
        s.date_est_deli,
        s.date_actual_deli,
        s.shipper1_id,
        s.shipper1_name,
        s.phone1,
        s.shipper2_id,
        s.shipper2_name,
        s.phone2,
        a.name AS address_name,
        a.phone,
        CONCAT_WS(', ', a.detail, a.street, a.ward, a.district, a.city, a.country) AS full_address,
        s.name_receive,
        s.phone_receive,
        s.status,
        s.description
    INTO #shipment_list
    FROM shipment s
    LEFT JOIN address a ON s.address_id = a.address_id
	LEFT Join order_tb o ON o.order_id = s.order_id
    WHERE
		(@buyer = -1 OR @buyer = o.buyer ) AND
		(@seller = -1 OR @seller = o.seller ) AND
        (@shipment_id = '' OR s.shipment_id = @shipment_id) AND
        (@order_id = '' OR s.order_id = @order_id) AND
        (@shipper_id = '' OR s.shipper1_id = @shipper_id OR s.shipper2_id = @shipper_id) AND
        (@date_from IS NULL OR s.date_created >= @date_from) AND
        (@date_to IS NULL OR s.date_created <= @date_to) AND
        (@status = -1 OR s.status = @status);

    -- Output kết quả tổng hợp
    SELECT * FROM #shipment_list;

    -- Output 2: Chi tiết sản phẩm được giao trong từng shipment
    SELECT 
        sd.shipment_id,
        sd.order_id,
        sd.product_id,
        p.name AS product_name,
        sd.quantity
    FROM #shipment_list sl
    JOIN shipment_d sd ON sl.shipment_id = sd.shipment_id
    JOIN product p ON sd.product_id = p.product_id
    ORDER BY sd.shipment_id, sd.product_id;

    DROP TABLE #shipment_list;
END;
GO




-------- Chi tiết Giỏ hàng kèm sale off


CREATE OR ALTER PROCEDURE sp_get_cart_by_user_with_promotion
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;
	SELECT *  INTO #inventory FROM vw_product_inventory

 -- Lưu kết quả vào bảng tạm
    SELECT 
        c.user_id,
        u.user_name,
        c.product_id,
        c.product_name,
        c.quantity,
        c.price AS original_price,
        ISNULL(pr.value, 0) AS promotion_value,
        CASE 
            WHEN pr.type = 2 AND pr.status = 1 
                 AND GETDATE() BETWEEN pr.date_start AND ISNULL(pr.date_end, GETDATE())
            THEN c.price * (1 - pr.value / 100.0)
            ELSE c.price
        END AS final_price,
        c.quantity * 
        CASE 
            WHEN pr.type = 2 AND pr.status = 1 
                 AND GETDATE() BETWEEN pr.date_start AND ISNULL(pr.date_end, GETDATE())
            THEN c.price * (1 - pr.value / 100.0)
            ELSE c.price
        END AS total_price,
        i.category_id,
        i.brand_id,
        i.group_tb_1,
        i.group_tb_2,
        i.url_image1,
        i.pro_status AS product_status,
		i.brand_status,
        i.quantity_available,
        CASE 
            WHEN i.pro_status = 1 AND i.brand_status = 1 AND  i.quantity_available > 0 THEN 1
            ELSE 0
        END AS product_status_flag ------ Kiểm tra sản phẩm còn bán, còn hàng không

    INTO #cart_temp
    FROM cart c
    JOIN user_tb u ON c.user_id = u.user_id
    LEFT JOIN #inventory i ON c.product_id = i.product_id
    LEFT JOIN promotion_product pp ON c.product_id = pp.product_id AND pp.status = 1
    LEFT JOIN promotion pr ON pp.promotion_id = pr.promotion_id 
                            AND pr.status = 1 
                            AND pr.type = 2
                            AND GETDATE() BETWEEN pr.date_start AND ISNULL(pr.date_end, GETDATE())
    WHERE c.user_id = @user_id;

    -- Output 1: Chi tiết giỏ hàng
    SELECT * FROM #cart_temp;

    -- Output 2: Tổng số lượng và giá trị
    SELECT 
        SUM(quantity) AS total_quantity,
        SUM(total_price) AS total_value
    FROM #cart_temp;


	DROP TABLE #inventory
    DROP TABLE #cart_temp
	
END;

GO




------ Store xử lý mở 1 sản phẩm
CREATE OR ALTER PROCEDURE sp_get_product_detail
    @product_id varchar(25) = ''
AS
BEGIN
    SET NOCOUNT ON;
	SELECT TOP 1 *  INTO #inventory FROM vw_product_inventory
	WHERE product_id = @product_id;

	SELECT p.*,
	CASE 
            WHEN pr.type = 2 AND pr.status = 1 
                 AND GETDATE() BETWEEN pr.date_start AND ISNULL(pr.date_end, GETDATE())
            THEN p.price1 * (1 - pr.value / 100.0)
            ELSE p.price1
        END AS final_price,
	i.brand_id,
	i.quantity_available,
	CASE WHEN i.quantity_available > 0 AND i.pro_status = 1 AND i.brand_id = 1 THEN 1
		ELSE 0  
		END AS status_flag ------ Trạng thái sản phẩm còn bán, hết hàng hay không
	FROM product p LEFT JOIN #inventory i ON p.product_id = i.product_id
		LEFT JOIN promotion_product p1 ON  p1.product_id = p.product_id
		LEFT JOIN promotion pr ON pr.promotion_id = p1.promotion_id

END;

GO
--Sửa từ đây
-----Store load danh sách người dùng
CREATE OR ALTER PROCEDURE sp_get_list_user_tb
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @is_admin BIT;
    SELECT @is_admin = admin FROM user_tb WHERE user_id = @user_id;

    SELECT * INTO #user FROM vw_user
    WHERE user_id = @user_id OR @is_admin = 1;

    SELECT * FROM #user;
END;
GO

-----Store laod thông tin chi tiết người dùng
-----Store load danh sách người dùng
CREATE OR ALTER PROCEDURE sp_get_detail_user_tb
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * INTO #user FROM vw_user
    WHERE user_id = @user_id;

    SELECT * FROM #user;
END;
GO
--Sửa tới đây

Go


------- Trigger ghi change_hitory bảng Product
CREATE OR ALTER TRIGGER trg_Log_Product
ON product
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'product',
        NULL,
        (SELECT * FROM inserted i WHERE i.product_id = p.product_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.product_id = p.product_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'product',
        (SELECT * FROM deleted d WHERE d.product_id = i.product_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.product_id = i.product_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.product_id = d.product_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'product',
        (SELECT * FROM deleted d2 WHERE d2.product_id = d.product_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.product_id = d.product_id);
END;
Go






--------Trigeer ghi change_log cho bảng order_tb
CREATE OR ALTER TRIGGER trg_Log_Order_tb
ON order_tb
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'order_tb',
        NULL,
        (SELECT * FROM inserted i WHERE i.order_id = p.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.order_id = p.order_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'order_tb',
        (SELECT * FROM deleted d WHERE d.order_id = i.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.order_id = i.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.order_id = d.order_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'order_tb',
        (SELECT * FROM deleted d2 WHERE d2.order_id = d.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.order_id = d.order_id);
END;



go




--------Trigger cho bảng order_d
CREATE OR ALTER TRIGGER trg_Log_order_d
ON order_d
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'order_d',
        NULL,
        (SELECT * FROM inserted i WHERE i.product_id = p.product_id AND i.order_id = p.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.product_id = p.product_id AND d.order_id = p.order_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'order_d',
        (SELECT * FROM deleted d WHERE d.product_id = i.product_id AND d.order_id = i.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.product_id = i.product_id AND i2.order_id = i.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.product_id = d.product_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'order_d',
        (SELECT * FROM deleted d2 WHERE d2.product_id = d.product_id AND d2.order_id = d.order_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.product_id = d.product_id);
END;
Go


--------Trigeer ghi change_log cho bảng invoice
CREATE OR ALTER TRIGGER trg_Log_Invoice
ON invoice
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'invoice',
        NULL,
        (SELECT * FROM inserted i WHERE i.invoice_id = p.invoice_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.invoice_id = p.invoice_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'product',
        (SELECT * FROM deleted d WHERE d.invoice_id = i.invoice_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.invoice_id = i.invoice_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.invoice_id = d.invoice_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'product',
        (SELECT * FROM deleted d2 WHERE d2.invoice_id = d.invoice_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.invoice_id = d.invoice_id);
END;

GO


------- Trigger bảng Product_in
CREATE OR ALTER TRIGGER trg_Log_Product_in
ON product_in
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'product_in',
        NULL,
        (SELECT * FROM inserted i WHERE i.pi_id = p.pi_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.pi_id = p.pi_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'product_in',
        (SELECT * FROM deleted d WHERE d.pi_id = i.pi_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.pi_id = i.pi_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.pi_id = d.pi_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'product_in',
        (SELECT * FROM deleted d2 WHERE d2.pi_id = d.pi_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.pi_id = d.pi_id);
END;


Go


--------Trigger cho bảng user_tb
CREATE OR ALTER TRIGGER trg_Log_User_tb
ON user_tb
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'user_tb',
        NULL,
        (SELECT * FROM inserted i WHERE i.user_id = p.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.user_id = p.user_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'user_tb',
        (SELECT * FROM deleted d WHERE d.user_id = i.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.user_id = i.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.user_id = d.user_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'user_tb',
        (SELECT * FROM deleted d2 WHERE d2.user_id = d.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.user_id = d.user_id);
END;
Go


--------Trigger cho bảng user_tb_2
CREATE OR ALTER TRIGGER trg_Log_User_tb_2
ON user_tb2
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'user_tb2',
        NULL,
        (SELECT * FROM inserted i WHERE i.user_id = p.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.user_id = p.user_id);

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'user_tb2',
        (SELECT * FROM deleted d WHERE d.user_id = i.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.user_id = i.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.user_id = d.user_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'user_tb2',
        (SELECT * FROM deleted d2 WHERE d2.user_id = d.user_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.user_id = d.user_id);
END;

Go



------Trigger cho shipment
--------Trigger cho bảng user_tb
CREATE OR ALTER TRIGGER trg_Log_Shipement
ON shipment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id INT = CAST(SESSION_CONTEXT(N'user_id') AS INT);

    -- INSERT log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'INSERT',
        'shipment',
        NULL,
        (SELECT * FROM inserted i WHERE i.shipment_id = p.shipment_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted p
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.shipment_id = p.shipment_id)

    -- UPDATE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'UPDATE',
        'shipement',
        (SELECT * FROM deleted d WHERE d.shipment_id = i.shipment_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted i2 WHERE i2.shipment_id = i.shipment_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        1
    FROM inserted i
    JOIN deleted d ON i.shipment_id = d.shipment_id;

    -- DELETE log
    INSERT INTO change_history(user_id, date_act, type, table_change, old_val, new_val, status)
    SELECT 
        @user_id,
        GETDATE(),
        'DELETE',
        'shipment',
        (SELECT * FROM deleted d2 WHERE d2.shipment_id = d.shipment_id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
        NULL,
        1
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.shipment_id = d.shipment_id);
END;
go


-- Kiểm tra tồn tại và drop nếu tồn tại cho các stored procedures

-- sp_upsert_user
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_upsert_user') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_upsert_user
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_promotion_and_assign') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_promotion_and_assign
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_UpdateUserStatus') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_UpdateUserStatus
GO
-- upsert_promotion
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_promotion') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_promotion
GO

-- upsert_product
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_product') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_product
GO

-- upsert_product_in
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_product_in') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_product_in
GO

-- add_to_cart
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'add_to_cart') AND type in (N'P', N'PC'))
    DROP PROCEDURE add_to_cart
GO

-- sp_UpdateCartQuantity
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_UpdateCartQuantity') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_UpdateCartQuantity
GO

-- add_to_wishlist
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'add_to_wishlist') AND type in (N'P', N'PC'))
    DROP PROCEDURE add_to_wishlist
GO

-- upsert_rating
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_rating') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_rating
GO

-- upsert_support
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_support') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_support
GO

-- upsert_chat_and_add_users_from_string
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_chat_and_add_users_from_string') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_chat_and_add_users_from_string
GO

-- upsert_chat_members_from_string
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_chat_members_from_string') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_chat_members_from_string
GO

-- upsert_chat_message
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'upsert_chat_message') AND type in (N'P', N'PC'))
    DROP PROCEDURE upsert_chat_message
GO

-- sp_update_chat_flag
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_update_chat_flag') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_update_chat_flag
GO

-- sp_CreateOrder_FIFO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_CreateOrder_FIFO') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_CreateOrder_FIFO
GO

-- sp_UpdateOrderStatus
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_UpdateOrderStatus') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_UpdateOrderStatus
GO

-- sp_CloneOrderWithFifo
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_CloneOrderWithFifo') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_CloneOrderWithFifo
GO

-- sp_CreateOrder_BuyNow
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_CreateOrder_BuyNow') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_CreateOrder_BuyNow
GO

-- sp_UpdateBrandStatus
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_UpdateBrandStatus') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_UpdateBrandStatus
GO

-- sp_Upsert_PaymentMethod
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_Upsert_PaymentMethod') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_Upsert_PaymentMethod
GO

-- sp_InsertLogHistory
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_InsertLogHistory') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_InsertLogHistory
GO

-- sp_InsertClickProduct
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_InsertClickProduct') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_InsertClickProduct
GO

-- sp_create_invoice_from_order
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_create_invoice_from_order') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_create_invoice_from_order
GO

-- sp_UpdateInvoice
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_UpdateInvoice') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_UpdateInvoice
GO

-- sp_UpsertAddress
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_UpsertAddress') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_UpsertAddress
GO

-- sp_CreateShipmentFromOrder
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_CreateShipmentFromOrder') AND type in (N'P', N'PC'))
    DROP PROCEDURE sp_CreateShipmentFromOrder
GO


CREATE PROCEDURE sp_upsert_user
@user_id INT = 0, -- Nếu = 0 thì insert, khác 0 thì update
@user_name VARCHAR(25),
@password VARCHAR(100),
@admin BIT = 0,
@buyer BIT = 1,
@seller BIT = 0,
@rank INT = 1,
@ban BIT = 0,
@freeze BIT = 0,
@notify BIT = 0,
@status BIT = 1,

-- Thông tin user_tb2
@name NVARCHAR(50) = NULL,
@name2 NVARCHAR(50) = NULL,
@birthday DATE = NULL,
@phone_number CHAR(10) = NULL,
@address NVARCHAR(200) = NULL,
@email NVARCHAR(50) = NULL,
@social_url1 NVARCHAR(300) = NULL,
@social_url2 NVARCHAR(300) = NULL,
@social_url3 NVARCHAR(300) = NULL,
@logo_url NVARCHAR(MAX) = NULL,

-- ID người thực hiện thao tác
@current_user_id INT,

-- Output
@result BIT OUTPUT,
@message NVARCHAR(200) OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

-- Kiểm tra quyền sửa
IF @user_id != 0 AND NOT EXISTS (
    SELECT 1 FROM user_tb 
    WHERE (user_id = @user_id OR admin = 1)
)
BEGIN
    SET @result = 0;
    SET @message = N'Không có quyền cập nhật người dùng.';
    RETURN;
END

-- Kiểm tra trùng user_name
IF EXISTS (
    SELECT 1 FROM user_tb 
    WHERE user_name = @user_name AND user_id != @user_id
)
BEGIN
    SET @result = 0;
    SET @message = N'Tên đăng nhập đã tồn tại.';
    RETURN;
END

-- Kiểm tra trùng số điện thoại
IF EXISTS (
    SELECT 1 FROM user_tb2 
    WHERE phone_number = @phone_number AND user_id != @user_id
)
BEGIN
    SET @result = 0;
    SET @message = N'Số điện thoại đã được sử dụng.';
    RETURN;
END

-- Kiểm tra trùng email
IF EXISTS (
    SELECT 1 FROM user_tb2 
    WHERE email = @email AND user_id != @user_id
)
BEGIN
    SET @result = 0;
    SET @message = N'Email đã được sử dụng.';
    RETURN;
END

-- Thêm mới
IF @user_id = 0
BEGIN
    INSERT INTO user_tb (
        user_name, password, admin, buyer, seller, rank, ban, freeze, notify, date_created, status
    )
    VALUES (
        @user_name, @password, @admin, @buyer, @seller, @rank, @ban, @freeze, @notify, GETDATE(), @status
    );

    SET @user_id = SCOPE_IDENTITY();

    INSERT INTO user_tb2 (
        user_id, name, name2, birthday, phone_number, address, email,
        social_url1, social_url2, social_url3, logo_url
    )
    VALUES (
        @user_id, @name, @name2, @birthday, @phone_number, @address, @email,
        @social_url1, @social_url2, @social_url3, @logo_url
    );

    SET @result = 1;
    SET @message = N'Thêm người dùng thành công.';
END
ELSE
BEGIN
    -- Cập nhật user_tb
    UPDATE user_tb
    SET
        password = CASE WHEN password != @password THEN @password ELSE password END,
        admin = CASE WHEN admin != @admin THEN @admin ELSE admin END,
        buyer = CASE WHEN buyer != @buyer THEN @buyer ELSE buyer END,
        seller = CASE WHEN seller != @seller THEN @seller ELSE seller END,
        rank = CASE WHEN rank != @rank THEN @rank ELSE rank END,
        ban = CASE WHEN ban != @ban THEN @ban ELSE ban END,
        freeze = CASE WHEN freeze != @freeze THEN @freeze ELSE freeze END,
        notify = CASE WHEN notify != @notify THEN @notify ELSE notify END,
        status = CASE WHEN status != @status THEN @status ELSE status END
    WHERE user_id = @user_id;

    -- Cập nhật user_tb2
    UPDATE user_tb2
    SET
        name = CASE WHEN name != @name THEN @name ELSE name END,
        name2 = CASE WHEN name2 != @name2 THEN @name2 ELSE name2 END,
        birthday = CASE WHEN birthday != @birthday THEN @birthday ELSE birthday END,
        phone_number = CASE WHEN phone_number != @phone_number THEN @phone_number ELSE phone_number END,
        address = CASE WHEN address != @address THEN @address ELSE address END,
        email = CASE WHEN email != @email THEN @email ELSE email END,
        social_url1 = CASE WHEN social_url1 != @social_url1 THEN @social_url1 ELSE social_url1 END,
        social_url2 = CASE WHEN social_url2 != @social_url2 THEN @social_url2 ELSE social_url2 END,
        social_url3 = CASE WHEN social_url3 != @social_url3 THEN @social_url3 ELSE social_url3 END,
        logo_url = CASE WHEN logo_url != @logo_url THEN @logo_url ELSE logo_url END
    WHERE user_id = @user_id;

    SET @result = 1;
    SET @message = N'Cập nhật người dùng thành công.';
END

END;

GO






----- Thêm, sửa sản phẩm
CREATE  PROCEDURE upsert_product
    @product_id VARCHAR(25),
    @name NVARCHAR(75),
    @name2 NVARCHAR(75) = NULL,
    @description NVARCHAR(1000) = NULL,
    @brand_id VARCHAR(25) = NULL,
    @category_id VARCHAR(25),
    @group_tb_1 VARCHAR(25) = NULL,
    @group_tb_2 VARCHAR(25) = NULL,
    @group_tb_3 VARCHAR(25) = NULL,
    @group_tb_4 VARCHAR(25) = NULL,
    @uom NVARCHAR(20) = NULL,
    @price1 MONEY = NULL,
    @date_apply1 DATETIME = NULL,
    @price2 MONEY = NULL,
    @date_apply2 DATETIME = NULL,
    @url_image1 VARCHAR(300) = NULL,
    @url_image2 VARCHAR(300) = NULL,
    @url_image3 VARCHAR(300) = NULL,
    @user_id VARCHAR(25),
    @status BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM user_tb WHERE user_id = @user_id AND (seller = 1 OR admin = 1 ))
	BEGIN
    -- Kiểm tra sản phẩm đã tồn tại
    IF EXISTS (SELECT 1 FROM product WHERE product_id = @product_id)
    BEGIN
        -- Chỉ cập nhật nếu có thay đổi
        IF EXISTS (
            SELECT 1 FROM product
            WHERE product_id = @product_id AND (
                name <> @name OR
                ISNULL(name2, '') <> ISNULL(@name2, '') OR
                ISNULL(description, '') <> ISNULL(@description, '') OR
                ISNULL(brand_id, '') <> ISNULL(@brand_id, '') OR
                category_id <> @category_id OR
                ISNULL(group_tb_1, '') <> ISNULL(@group_tb_1, '') OR
                ISNULL(group_tb_2, '') <> ISNULL(@group_tb_2, '') OR
                ISNULL(group_tb_3, '') <> ISNULL(@group_tb_3, '') OR
                ISNULL(group_tb_4, '') <> ISNULL(@group_tb_4, '') OR
                ISNULL(uom, '') <> ISNULL(@uom, '') OR
                ISNULL(price1, 0) <> ISNULL(@price1, 0) OR
                ISNULL(date_apply1, '') <> ISNULL(@date_apply1, '') OR
                ISNULL(price2, 0) <> ISNULL(@price2, 0) OR
                ISNULL(date_apply2, '') <> ISNULL(@date_apply2, '') OR
                ISNULL(url_image1, '') <> ISNULL(@url_image1, '') OR
                ISNULL(url_image2, '') <> ISNULL(@url_image2, '') OR
                ISNULL(url_image3, '') <> ISNULL(@url_image3, '') OR
                user_id <> @user_id OR
                status <> @status
            )
        )
        BEGIN
            UPDATE product
            SET 
                name = @name,
                name2 = @name2,
                description = @description,
                brand_id = @brand_id,
                category_id = @category_id,
                group_tb_1 = @group_tb_1,
                group_tb_2 = @group_tb_2,
                group_tb_3 = @group_tb_3,
                group_tb_4 = @group_tb_4,
                uom = @uom,
                price1 = @price1,
                date_apply1 = @date_apply1,
                price2 = @price2,
                date_apply2 = @date_apply2,
                url_image1 = @url_image1,
                url_image2 = @url_image2,
                url_image3 = @url_image3,
                user_id = @user_id,
                status = @status
            WHERE product_id = @product_id;
        END
    END
    ELSE
    BEGIN
        -- Thêm mới sản phẩm
        INSERT INTO product (
            product_id, name, name2, description, brand_id, category_id,
            group_tb_1, group_tb_2, group_tb_3, group_tb_4, uom,
            price1, date_apply1, price2, date_apply2,
            url_image1, url_image2, url_image3,
            user_id, status
        )
        VALUES (
            @product_id, @name, @name2, @description, @brand_id, @category_id,
            @group_tb_1, @group_tb_2, @group_tb_3, @group_tb_4, @uom,
            @price1, @date_apply1, @price2, @date_apply2,
            @url_image1, @url_image2, @url_image3,
            @user_id, @status
        );
    END
END
BEGIN
        RAISERROR(N'Bạn không phải người bán hoặc không đúng người bán của sản phẩm.', 16, 1);
    END
END
 GO

ALTER PROCEDURE upsert_product
    @product_id VARCHAR(25),
    @name NVARCHAR(75),
    @name2 NVARCHAR(75) = NULL,
    @description NVARCHAR(1000) = NULL,
    @brand_id VARCHAR(25) = NULL,
    @category_id VARCHAR(25),
    @group_tb_1 VARCHAR(25) = NULL,
    @group_tb_2 VARCHAR(25) = NULL,
    @group_tb_3 VARCHAR(25) = NULL,
    @group_tb_4 VARCHAR(25) = NULL,
    @uom NVARCHAR(20) = NULL,
    @price1 MONEY = NULL,
    @date_apply1 DATETIME = NULL,
    @price2 MONEY = NULL,
    @date_apply2 DATETIME = NULL,
    @url_image1 VARCHAR(300) = NULL,
    @url_image2 VARCHAR(300) = NULL,
    @url_image3 VARCHAR(300) = NULL,
    @user_id VARCHAR(25),
    @status BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Kiểm tra quyền user
    IF EXISTS (SELECT 1 FROM user_tb WHERE user_id = @user_id AND (seller = 1 OR admin = 1))
    BEGIN
        -- Kiểm tra sản phẩm đã tồn tại
        IF EXISTS (SELECT 1 FROM product WHERE product_id = @product_id)
        BEGIN
            -- Chỉ cập nhật nếu có thay đổi
            IF EXISTS (
                SELECT 1 FROM product
                WHERE product_id = @product_id AND (
                    name <> @name OR
                    ISNULL(name2, '') <> ISNULL(@name2, '') OR
                    ISNULL(description, '') <> ISNULL(@description, '') OR
                    ISNULL(brand_id, '') <> ISNULL(@brand_id, '') OR
                    category_id <> @category_id OR
                    ISNULL(group_tb_1, '') <> ISNULL(@group_tb_1, '') OR
                    ISNULL(group_tb_2, '') <> ISNULL(@group_tb_2, '') OR
                    ISNULL(group_tb_3, '') <> ISNULL(@group_tb_3, '') OR
                    ISNULL(group_tb_4, '') <> ISNULL(@group_tb_4, '') OR
                    ISNULL(uom, '') <> ISNULL(@uom, '') OR
                    ISNULL(price1, 0) <> ISNULL(@price1, 0) OR
                    ISNULL(date_apply1, '1900-01-01') <> ISNULL(@date_apply1, '1900-01-01') OR
                    ISNULL(price2, 0) <> ISNULL(@price2, 0) OR
                    ISNULL(date_apply2, '1900-01-01') <> ISNULL(@date_apply2, '1900-01-01') OR
                    ISNULL(url_image1, '') <> ISNULL(@url_image1, '') OR
                    ISNULL(url_image2, '') <> ISNULL(@url_image2, '') OR
                    ISNULL(url_image3, '') <> ISNULL(@url_image3, '') OR
                    user_id <> @user_id OR
                    status <> @status
                )
            )
            BEGIN
                UPDATE product
                SET 
                    name = @name,
                    name2 = @name2,
                    description = @description,
                    brand_id = @brand_id,
                    category_id = @category_id,
                    group_tb_1 = @group_tb_1,
                    group_tb_2 = @group_tb_2,
                    group_tb_3 = @group_tb_3,
                    group_tb_4 = @group_tb_4,
                    uom = @uom,
                    price1 = @price1,
                    date_apply1 = @date_apply1,
                    price2 = @price2,
                    date_apply2 = @date_apply2,
                    url_image1 = @url_image1,
                    url_image2 = @url_image2,
                    url_image3 = @url_image3,
                    user_id = @user_id,
                    status = @status
                WHERE product_id = @product_id;
            END
        END
        ELSE
        BEGIN
            -- Thêm mới sản phẩm
            INSERT INTO product (
                product_id, name, name2, description, brand_id, category_id,
                group_tb_1, group_tb_2, group_tb_3, group_tb_4, uom,
                price1, date_apply1, price2, date_apply2,
                url_image1, url_image2, url_image3,
                user_id, status
            )
            VALUES (
                @product_id, @name, @name2, @description, @brand_id, @category_id,
                @group_tb_1, @group_tb_2, @group_tb_3, @group_tb_4, @uom,
                @price1, @date_apply1, @price2, @date_apply2,
                @url_image1, @url_image2, @url_image3,
                @user_id, @status
            );
        END
    END
    ELSE
    BEGIN
        -- User không có quyền
        RAISERROR(N'Bạn không phải người bán hoặc không đúng người bán của sản phẩm.', 16, 1);
        RETURN;
    END
END
GO

--Xóa sản phẩm





---------Tao, sửa promotion và gán promotion theo nhiều sản phẩm, nhóm, category, brand (cách nhàu dấu ',')

CREATE PROCEDURE upsert_promotion_and_assign
    @promotion_id VARCHAR(25),
    @promotion_name NVARCHAR(75),
    @promotion_name2 NVARCHAR(75) = NULL,
    @type INT,
    @calculate INT,
    @date_start DATE,
    @date_end DATE = NULL,
    @value NUMERIC,
    @quantity INT,
    @description NVARCHAR(1000) = NULL,
    @quan_cond INT = NULL,
    @val_cond MONEY = NULL,
    @oder_tb_cond INT = NULL,
    @group_tb_cond VARCHAR(25) = NULL,
    @rank_cond INT = NULL,
    @status BIT = 1,
    @user_id int,
    @list_product_ids NVARCHAR(MAX) = '',
    @list_category_ids NVARCHAR(MAX) = '',
    @list_brand_ids NVARCHAR(MAX) = '',
    @list_group_ids NVARCHAR(MAX) = ''
AS
BEGIN
    SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM user_tb WHERE user_id = @user_id AND (seller = 1 OR admin = 1 ))
	BEGIN
    -- Kiểm tra tồn tại
    IF EXISTS (SELECT 1 FROM promotion WHERE promotion_id = @promotion_id)
    BEGIN
        -- Chỉ cập nhật khi có thay đổi
        IF EXISTS (
            SELECT 1 FROM promotion
            WHERE promotion_id = @promotion_id AND (
                promotion_name     <> @promotion_name OR
                ISNULL(promotion_name2, '') <> ISNULL(@promotion_name2, '') OR
                type           <> @type OR
                calculate         <> @calculate OR
                date_start        <> @date_start OR
                ISNULL(date_end, '') <> ISNULL(@date_end, '') OR
                value           <> @value OR
                quantity       <> @quantity OR
                ISNULL(description, '') <> ISNULL(@description, '') OR
                ISNULL(quan_cond, 0) <> ISNULL(@quan_cond, 0) OR
                ISNULL(val_cond, 0) <> ISNULL(@val_cond, 0) OR
                ISNULL(oder_tb_cond, 0) <> ISNULL(@oder_tb_cond, 0) OR
                ISNULL(group_tb_cond, '') <> ISNULL(@group_tb_cond, '') OR
                ISNULL(rank_cond, 0) <> ISNULL(@rank_cond, 0) OR
                status          <> @status
            )
        )
        BEGIN
            UPDATE promotion
            SET 
                promotion_name = @promotion_name,
                promotion_name2 = @promotion_name2,
                type = @type,
                calculate = @calculate,
                date_start = @date_start,
                date_end = @date_end,
                value = @value,
                quantity = @quantity,
                description = @description,
                quan_cond = @quan_cond,
                val_cond = @val_cond,
                oder_tb_cond = @oder_tb_cond,
                group_tb_cond = @group_tb_cond,
                rank_cond = @rank_cond,
                status = @status
            WHERE promotion_id = @promotion_id;
        END
    END
    ELSE
    BEGIN
        INSERT INTO promotion (
            promotion_id, promotion_name, promotion_name2, type, calculate, date_created, date_start, date_end,
           value, quantity, description, quan_cond, val_cond, oder_tb_cond, group_tb_cond, rank_cond, status
        )
        VALUES (
            @promotion_id, @promotion_name, @promotion_name2, @type, @calculate, GETDATE(), @date_start, @date_end,
            @value, @quantity, @description, @quan_cond, @val_cond, @oder_tb_cond, @group_tb_cond, @rank_cond, @status
        );
    END

    ---------------------------
    -- Xoá & Gán lại promotion_product
    ---------------------------
    DELETE FROM promotion_product WHERE promotion_id = @promotion_id;

    -- Gán theo sản phẩm
    INSERT INTO promotion_product (promotion_id, product_id)
    SELECT @promotion_id, TRIM(value)
    FROM STRING_SPLIT(@list_product_ids, ',')
    WHERE TRIM(value) <> '';

    -- Gán theo category
    INSERT INTO promotion_product (promotion_id, product_id)
    SELECT DISTINCT @promotion_id, p.product_id
    FROM product p
    JOIN STRING_SPLIT(@list_category_ids, ',') s ON p.category_id = TRIM(s.value)
    WHERE TRIM(s.value) <> '';

    -- Gán theo brand
    INSERT INTO promotion_product (promotion_id, product_id)
    SELECT DISTINCT @promotion_id, p.product_id
    FROM product p
    JOIN STRING_SPLIT(@list_brand_ids, ',') s ON p.brand_id = TRIM(s.value)
    WHERE TRIM(s.value) <> '';

    -- Gán theo group (bất kỳ group_tb_1 đến group_tb_4)
    INSERT INTO promotion_product (promotion_id, product_id)
    SELECT DISTINCT @promotion_id, p.product_id
    FROM product p
    JOIN STRING_SPLIT(@list_group_ids, ',') s 
        ON TRIM(s.value) IN (p.group_tb_1, p.group_tb_2, p.group_tb_3, p.group_tb_4)
    WHERE TRIM(s.value) <> '';
END
BEGIN
        RAISERROR(N'Bạn không phải admin, không có quyền thêm promotion.', 16, 1);
    END
END











GO
----Thêm/ sửa nhập sản phẩm
CREATE  PROCEDURE upsert_product_in
    @pi_id VARCHAR(25),
    @product_id VARCHAR(25),
    @date_created DATETIME,
    @date_start DATETIME = NULL,
    @date_end DATETIME = NULL,
    @name NVARCHAR(75),
    @name2 NVARCHAR(75) = NULL,
    @quantity INT,
    @cost MONEY,
	@user_id int
AS
BEGIN
    SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM user_tb WHERE user_id = @user_id AND (seller = 1 OR admin = 1 ))
	BEGIN
    -- Kiểm tra số lượng nhập > 0
    IF @quantity <= 0
    BEGIN
        RAISERROR(N'Số lượng nhập phải lớn hơn 0.', 16, 1);
        RETURN;
    END

    -- Kiểm tra sản phẩm còn hoạt động
    IF EXISTS (
        SELECT 1 FROM product p LEFT JOIN brand b ON p.brand_id = b.brand_id
        WHERE product_id = @product_id AND p.status = 1 AND b.status = 1
    )
    BEGIN
        -- Nếu tồn tại pi_id thì update khi có thay đổi
        IF EXISTS (SELECT 1 FROM product_in WHERE pi_id = @pi_id)
        BEGIN
            IF EXISTS (
                SELECT 1 FROM product_in
                WHERE pi_id = @pi_id AND (
                    product_id <> @product_id OR
                    date_created <> @date_created OR
                    ISNULL(date_start, '') <> ISNULL(@date_start, '') OR
                    ISNULL(date_end, '') <> ISNULL(@date_end, '') OR
                    name <> @name OR
                    ISNULL(name2, '') <> ISNULL(@name2, '') OR
                    quantity <> @quantity OR
                    cost <> @cost
                )
            )
            BEGIN
                UPDATE product_in
                SET 
                    product_id = @product_id,
                    date_created = @date_created,
                    date_start = @date_start,
                    date_end = @date_end,
                    name = @name,
                    name2 = @name2,
                    quantity = @quantity,
                    cost = @cost
                WHERE pi_id = @pi_id;
            END
        END
        ELSE
        BEGIN
            -- Thêm mới
		DECLARE @pi_seq int;
			 -- Sinh mã đơn hàng
        SELECT @pi_seq = ISNULL(MAX(CAST(RIGHT(@pi_id, 5) AS INT)), 0) + 1
        FROM product
        WHERE @pi_id LIKE 'ORD' + FORMAT(GETDATE(), 'yyyyMMdd') + '%';

        SET @pi_id = CONCAT('ORD', FORMAT(GETDATE(), 'yyyyMMdd'), RIGHT('00000' + CAST(@pi_seq AS VARCHAR), 5));

            INSERT INTO product_in (
                pi_id, product_id, date_created, date_start, date_end,
                name, name2, quantity, cost
            )
            VALUES (
                @pi_id, @product_id, @date_created, @date_start, @date_end,
                @name, @name2, @quantity, @cost
            );
        END
    END
    ELSE
    BEGIN
        RAISERROR(N'Sản phẩm không còn hoạt động hoặc không tồn tại.', 16, 1);
    END
END
BEGIN
        RAISERROR(N'Bạn không phải người bán hoặc không đúng người bán sản phẩm.', 16, 1);
    END
END
Go





------- Thêm, sản phẩm vào giỏ hàng
CREATE  PROCEDURE add_to_cart
    @user_id INT,
    @product_id VARCHAR(25),
    @product_name NVARCHAR(75),
    @quantity INT,
    @price MONEY
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra quantity hợp lệ
    IF @quantity <= 0
    BEGIN
        RAISERROR('Số lượng phải lớn hơn 0.', 16, 1);
        RETURN;
    END

    -- Nếu sản phẩm đã có trong giỏ → cộng số lượng và cập nhật giá
    IF EXISTS (
        SELECT 1 FROM cart 
        WHERE user_id = @user_id AND product_id = @product_id
    )
    BEGIN
        UPDATE cart
        SET 
            quantity = quantity + @quantity,
            price = @price,
            product_name = @product_name
        WHERE user_id = @user_id AND product_id = @product_id;
    END
    ELSE
    BEGIN
        -- Thêm mới vào giỏ
        INSERT INTO cart (
            user_id, product_id, product_name, quantity, price
        ) VALUES (
            @user_id, @product_id, @product_name, @quantity, @price
        );
    END
END

GO


----- Thêm wishlist

CREATE  PROCEDURE add_to_wishlist
    @user_id INT,
    @product_id VARCHAR(25),
    @product_name VARCHAR(25),
    @product_description NVARCHAR(1000)
AS
BEGIN
    SET NOCOUNT ON;

    -- Chỉ thêm nếu chưa tồn tại
    IF NOT EXISTS (
        SELECT 1 FROM wishlist
        WHERE user_id = @user_id AND product_id = @product_id
    )
    BEGIN
        INSERT INTO wishlist (
            user_id, product_id, product_name, product_description
        )
        VALUES (
            @user_id, @product_id, @product_name, @product_description
        );
    END
END


GO



------ Thêm, sửa rating kiểm tra theo người dùng đã mua hàng
CREATE  PROCEDURE upsert_rating
    @product_id VARCHAR(25),
    @user_id INT,
    @rate INT,
    @description NVARCHAR(1000)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem user đã từng mua sản phẩm hay chưa
    IF EXISTS (
        SELECT 1
        FROM order_tb o
        JOIN order_d od ON o.order_id = od.order_id
        WHERE o.buyer = @user_id
          AND od.product_id = @product_id
    )
    BEGIN
        -- Nếu đã tồn tại đánh giá thì cập nhật
        IF EXISTS (
            SELECT 1 FROM rating
            WHERE product_id = @product_id AND user_id = @user_id
        )
        BEGIN
            UPDATE rating
            SET rate = @rate,
                description = @description,
                date_created = GETDATE()
            WHERE product_id = @product_id AND user_id = @user_id;

            PRINT N'Cập nhật đánh giá thành công.';
        END
        ELSE
        BEGIN
            -- Nếu chưa có thì thêm mới
            INSERT INTO rating (
                product_id, user_id, date_created, rate, description
            )
            VALUES (
                @product_id, @user_id, GETDATE(), @rate, @description
            );

            PRINT N'Thêm đánh giá mới thành công.';
        END
    END
    ELSE
    BEGIN
        PRINT N'Bạn chưa từng mua sản phẩm này nên không thể đánh giá.';
    END
END





GO 
-----Thêm mới câu hỏi trợ giúp
CREATE PROCEDURE upsert_support
    @support_id VARCHAR(25),
    @user_ask INT,
    @ask NVARCHAR(1000) = NULL,
    @product_id VARCHAR(25) = NULL,
    @order_id VARCHAR(25) = NULL,
    @user_answer INT = NULL,
    @answer NVARCHAR(1000) = NULL,
    @support_in VARCHAR(25) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM support WHERE support_id = @support_id)
    BEGIN
        -- Cập nhật thông tin trả lời
        UPDATE support
        SET 
            user_answer = @user_answer,
            answer = @answer,
            date_answer = GETDATE()
        WHERE support_id = @support_id;

        PRINT N'Cập nhật trả lời hỗ trợ thành công.';
    END
    ELSE
    BEGIN
        -- Thêm mới câu hỏi
        INSERT INTO support (
            support_id, user_ask, ask, date_ask, 
            product_id, order_id, support_in
        )
        VALUES (
            @support_id, @user_ask, @ask, GETDATE(),
            @product_id, @order_id, @support_in
        );

        PRINT N'Thêm yêu cầu hỗ trợ mới thành công.';
    END
END

GO




------ Tạo/ sửa nhóm chat và thêm người
CREATE  PROCEDURE upsert_chat_and_add_users_from_string
    @chat_id VARCHAR(25),
    @chat_name NVARCHAR(75),
    @chat_date_created DATETIME,
    @user_id_string NVARCHAR(MAX) -- ví dụ: '1,2,3'
AS
BEGIN
    SET NOCOUNT ON;

    -- Tạo hoặc cập nhật chat_tab
    IF NOT EXISTS (SELECT 1 FROM chat_tab WHERE chat_id = @chat_id)
    BEGIN
        INSERT INTO chat_tab (chat_id, name, date_created)
        VALUES (@chat_id, @chat_name, @chat_date_created);
    END
    ELSE
    BEGIN
        UPDATE chat_tab
        SET name = @chat_name
        WHERE chat_id = @chat_id AND (name IS NULL OR name != @chat_name);
    END

    -- Tách user_id từ chuỗi
    ;WITH ParsedUsers AS (
        SELECT 
            TRY_CAST(value AS INT) AS user_id
        FROM STRING_SPLIT(@user_id_string, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL
    )
    INSERT INTO chat_member (member_name, user_id, chat_id, date_joined)
    SELECT 
        ISNULL(ut.name, ut.name2),
        pu.user_id,
        @chat_id,
        GETDATE()
    FROM ParsedUsers pu
    JOIN user_tb2 ut ON pu.user_id = ut.user_id
    WHERE NOT EXISTS (
        SELECT 1 
        FROM chat_member cm 
        WHERE cm.user_id = pu.user_id AND cm.chat_id = @chat_id
    );
END



GO
----Thêm/ sủa thành viên nhóm chat
CREATE  PROCEDURE upsert_chat_members_from_string
    @chat_id VARCHAR(25),
    @user_id_string NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu chat_id không tồn tại
    IF NOT EXISTS (SELECT 1 FROM chat_tab WHERE chat_id = @chat_id)
    BEGIN
        RAISERROR(N'Chat_id không tồn tại.', 16, 1);
        RETURN;
    END

    -- Tách user_id từ chuỗi
    ;WITH ParsedUserIds AS (
        SELECT TRY_CAST(value AS INT) AS user_id
        FROM STRING_SPLIT(@user_id_string, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL
    )

    -- Chèn thành viên mới nếu chưa có
    INSERT INTO chat_member ( member_name, user_id, chat_id, date_joined)
    SELECT 
        ISNULL(ut.name, ut.name2),
        u.user_id,
        @chat_id,
        GETDATE()
    FROM ParsedUserIds u
    JOIN user_tb2 ut ON u.user_id = ut.user_id
    WHERE NOT EXISTS (
        SELECT 1 FROM chat_member cm
        WHERE cm.user_id = u.user_id AND cm.chat_id = @chat_id
    );

    -- Cập nhật tên nếu thay đổi
    UPDATE cm
    SET 
        member_name = ISNULL(ut.name, ut.name2)
    FROM chat_member cm
    JOIN user_tb2 ut ON cm.user_id = ut.user_id
    WHERE 
        cm.chat_id = @chat_id
        AND cm.member_name != ISNULL(ut.name, ut.name2);

END

GO


-----Thêm sửa tin nhắn

CREATE PROCEDURE upsert_chat_message
    @chat_rec INT = NULL,              -- NULL: thêm mới | Có giá trị: cập nhật
    @member_send INT,                 -- Thành viên gửi
    @msg_txt NVARCHAR(MAX),          -- Nội dung tin nhắn
    @chat_reply INT = NULL,          -- ID tin nhắn được phản hồi
    @member_reply INT = NULL,        -- ID thành viên được phản hồi
    @pin BIT = 0,                    -- Có ghim hay không
    @isRead BIT = 0                  -- Đã đọc hay chưa
AS
BEGIN
    SET NOCOUNT ON;

    IF @chat_rec IS NULL
    BEGIN
        -- Thêm tin nhắn mới
        INSERT INTO chat_detail (
            member_send,
            name_send,
            msg_txt,
            date_created,
            chat_reply,
            member_reply,
            isRead,
            pin
        )
        VALUES (
            @member_send,
            @member_send, -- name_send tạm thời đặt là member_send (có thể thay đổi nếu có bảng mapping)
            @msg_txt,
            GETDATE(),
            @chat_reply,
            @member_reply,
            @isRead,
            @pin
        );
    END
    ELSE
    BEGIN
        -- Kiểm tra điều kiện hợp lệ và sự thay đổi dữ liệu
        IF EXISTS (
            SELECT 1
            FROM chat_detail
            WHERE 
                chat_rec = @chat_rec
                AND member_send = @member_send
                AND DATEDIFF(MINUTE, date_created, GETDATE()) <= 10
        )
        BEGIN
            UPDATE chat_detail
            SET 
                msg_txt = @msg_txt
            WHERE chat_rec = @chat_rec;
        END
        ELSE
        BEGIN
            RAISERROR(N'Không thể sửa: dữ liệu không thay đổi hoặc vượt quá thời gian 10 phút.', 16, 1);
        END
    END
END



Go




--- Cập nhật trạng thái đọc, pin
CREATE PROCEDURE sp_update_chat_flag
	@chat_rec INT, -- ID của tin nhắn cần cập nhật
	@new_isRead BIT = NULL, -- Trạng thái đã đọc mới (NULL nếu không cập nhật)
	@new_pin BIT = NULL -- Trạng thái ghim mới (NULL nếu không cập nhật)
AS
BEGIN
SET NOCOUNT ON;


    UPDATE chat_detail
    SET 
        isRead = CASE 
                    WHEN @new_isRead IS NOT NULL THEN @new_isRead 
                    ELSE isRead 
                END,
        pin = CASE 
                  WHEN @new_pin IS NOT NULL THEN @new_pin 
                  ELSE pin 
              END
    WHERE chat_rec = @chat_rec;

END
GO



------------ Tạo đơn hàng, tính giá theo FIFO nhập trước xuát trước, từ giỏ hàng

CREATE PROCEDURE sp_CreateOrder_FIFO
    @buyer INT,
    @seller INT,
    @description NVARCHAR(1000) = NULL,
    @pro_saleoff VARCHAR(25) = NULL,
    @pro_new VARCHAR(25) = NULL,
    @pro_discount VARCHAR(25) = NULL,
    @pro_ship VARCHAR(25) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @order_id VARCHAR(25), @order_seq INT;
    DECLARE @rank INT;

    BEGIN TRY
        BEGIN TRAN;

        IF NOT EXISTS (SELECT 1 FROM cart WHERE user_id = @buyer)
        BEGIN
            RAISERROR(N'Giỏ hàng trống. Không thể tạo đơn hàng.', 16, 1);
            ROLLBACK;
            RETURN;
        END;

        SELECT @rank = rank FROM user_tb WHERE user_id = @buyer;

        -- Dữ liệu tạm từ cart
        DECLARE @tbl_cart TABLE(product_id VARCHAR(25), quantity INT, price MONEY);
        INSERT INTO @tbl_cart(product_id, quantity, price)
        SELECT product_id, quantity, price FROM cart WHERE user_id = @buyer;

        -- Kiểm tra khuyến mãi
        DECLARE @pro_list TABLE(promotion_id VARCHAR(25));
        INSERT INTO @pro_list(promotion_id)
        SELECT val FROM (VALUES (@pro_saleoff), (@pro_new), (@pro_discount), (@pro_ship)) AS x(val)
        WHERE val IS NOT NULL;

        DECLARE @pid VARCHAR(25);
        DECLARE pro_cursor CURSOR FOR SELECT promotion_id FROM @pro_list;
        OPEN pro_cursor;
        FETCH NEXT FROM pro_cursor INTO @pid;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @quan_cond INT, @val_cond MONEY, @oder_tb_cond INT, @group_tb_cond VARCHAR(25), @rank_cond INT, @pro_qty INT;

            SELECT 
                @quan_cond = quan_cond, @val_cond = val_cond, @oder_tb_cond = oder_tb_cond,
                @group_tb_cond = group_tb_cond, @rank_cond = rank_cond,
                @pro_qty = quantity
            FROM promotion WHERE promotion_id = @pid;

            IF @pro_qty IS NOT NULL AND @pro_qty > 0
            BEGIN
                DECLARE @used_qty_promotion INT = (
                    SELECT COUNT(*) FROM order_tb
                    WHERE pro_saleoff = @pid OR pro_new = @pid OR pro_discount = @pid OR pro_ship = @pid
                );

                IF @used_qty_promotion >= @pro_qty
                BEGIN
                    RAISERROR(N'Mã khuyến mãi %s đã hết lượt sử dụng.', 16, 1, @pid);
                    CLOSE pro_cursor; DEALLOCATE pro_cursor;
                    ROLLBACK;
                    RETURN;
                END
            END

            DECLARE @total_qty INT = 0, @total_val MONEY = 0;

            SELECT 
                @total_qty = SUM(c.quantity),
                @total_val = SUM(c.quantity * c.price)
            FROM @tbl_cart c
            WHERE EXISTS (
                SELECT 1 FROM promotion_product pp WHERE pp.promotion_id = @pid AND pp.product_id = c.product_id
            )
            AND (
                @group_tb_cond IS NULL
                OR EXISTS (
                    SELECT 1 FROM product p
                    WHERE p.product_id = c.product_id
                    AND (@group_tb_cond = p.group_tb_1 OR @group_tb_cond = p.group_tb_2 OR @group_tb_cond = p.group_tb_3 OR @group_tb_cond = p.group_tb_4)
                )
            );

            DECLARE @order_count INT = (SELECT COUNT(*) FROM order_tb WHERE buyer = @buyer);

            IF (@quan_cond IS NOT NULL AND @total_qty < @quan_cond)
                OR (@val_cond IS NOT NULL AND @total_val < @val_cond)
                OR (@oder_tb_cond IS NOT NULL AND @order_count >= @oder_tb_cond)
                OR (@rank_cond IS NOT NULL AND @rank < @rank_cond)
            BEGIN
                RAISERROR(N'Không đủ điều kiện áp dụng mã khuyến mãi %s.', 16, 1, @pid);
                CLOSE pro_cursor; DEALLOCATE pro_cursor;
                ROLLBACK;
                RETURN;
            END

            FETCH NEXT FROM pro_cursor INTO @pid;
        END

        CLOSE pro_cursor; DEALLOCATE pro_cursor;

        -- Sinh mã đơn hàng
        SELECT @order_seq = ISNULL(MAX(CAST(RIGHT(order_id, 5) AS INT)), 0) + 1
        FROM order_tb WHERE order_id LIKE 'ORD' + FORMAT(GETDATE(), 'yyyyMMdd') + '%';

        SET @order_id = CONCAT('ORD', FORMAT(GETDATE(), 'yyyyMMdd'), RIGHT('00000' + CAST(@order_seq AS VARCHAR), 5));

        -- Ghi đơn hàng
        INSERT INTO order_tb(order_id, date_created, buyer, seller, description, pro_saleoff, pro_new, pro_discount, pro_ship)
        VALUES (@order_id, GETDATE(), @buyer, @seller, @description, @pro_saleoff, @pro_new, @pro_discount, @pro_ship);

        -- FIFO từng sản phẩm
        DECLARE cur CURSOR FOR SELECT product_id, quantity, price FROM @tbl_cart;
        DECLARE @product_id VARCHAR(25), @quantity INT, @price MONEY;
        OPEN cur;
        FETCH NEXT FROM cur INTO @product_id, @quantity, @price;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @pro_status BIT;
            SELECT @pro_status = status FROM product WHERE product_id = @product_id;
            IF @pro_status <> 1
            BEGIN
                CLOSE cur; DEALLOCATE cur;
                RAISERROR(N'Sản phẩm không còn bán: %s', 16, 1, @product_id);
                ROLLBACK;
                RETURN;
            END;

            DECLARE fifo_cur CURSOR FOR
            SELECT pi_id, quantity, cost FROM product_in
            WHERE product_id = @product_id
            ORDER BY date_start;

            DECLARE @pi_id VARCHAR(25), @pi_qty INT, @pi_cost MONEY;
            DECLARE @qty_need INT = @quantity, @qty_available INT;

            OPEN fifo_cur;
            FETCH NEXT FROM fifo_cur INTO @pi_id, @pi_qty, @pi_cost;

            WHILE @@FETCH_STATUS = 0 AND @qty_need > 0
            BEGIN
                SELECT @qty_available = @pi_qty - ISNULL((
                    SELECT SUM(od.quantity) FROM order_d od 
                    WHERE od.pi_id = @pi_id AND od.product_id = @product_id
                ), 0);

                IF @qty_available > 0
                BEGIN
                    DECLARE @take_qty INT = CASE WHEN @qty_available >= @qty_need THEN @qty_need ELSE @qty_available END;

                    INSERT INTO order_d(order_id, product_id, pi_id, quantity, cost, price)
                    VALUES (@order_id, @product_id, @pi_id, @take_qty, @pi_cost, @price);

                    SET @qty_need -= @take_qty;
                END;

                FETCH NEXT FROM fifo_cur INTO @pi_id, @pi_qty, @pi_cost;
            END;

            CLOSE fifo_cur; DEALLOCATE fifo_cur;

            IF @qty_need > 0
            BEGIN
                CLOSE cur; DEALLOCATE cur;
                RAISERROR(N'Lỗi: Sản phẩm %s không đủ tồn kho theo FIFO.', 16, 1, @product_id);
                ROLLBACK;
                RETURN;
            END

            DELETE FROM cart WHERE user_id = @buyer AND product_id = @product_id;
            FETCH NEXT FROM cur INTO @product_id, @quantity, @price;
        END

        CLOSE cur; DEALLOCATE cur;
        COMMIT;
        PRINT N'Đơn hàng đã được tạo thành công: ' + @order_id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        DECLARE @Err NVARCHAR(1000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END


go








------Cập nhật trạng thái đơn hàng, ghi chú
CREATE  PROCEDURE sp_UpdateOrderStatus
    @order_id VARCHAR(25),
    @new_status INT = NULL,
    @new_description NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Kiểm tra đơn hàng có tồn tại không
        IF NOT EXISTS (SELECT 1 FROM order_tb WHERE order_id = @order_id)
        BEGIN
            RAISERROR(N'Không tìm thấy đơn hàng với mã: %s', 16, 1, @order_id);
            RETURN;
        END;

        -- Lấy trạng thái và mô tả hiện tại
        DECLARE @current_status INT;
        DECLARE @current_description NVARCHAR(1000);

        SELECT 
            @current_status = status,
            @current_description = description
        FROM order_tb
        WHERE order_id = @order_id;

        -- Chỉ cập nhật nếu có thay đổi
        IF @new_status IS NOT NULL AND @new_status <> @current_status
        BEGIN
            UPDATE order_tb
            SET status = @new_status
            WHERE order_id = @order_id;

            PRINT N'Đã cập nhật trạng thái đơn hàng.';
        END;

        IF @new_description IS NOT NULL AND @new_description <> @current_description
        BEGIN
            UPDATE order_tb
            SET description = @new_description
            WHERE order_id = @order_id;

            PRINT N'Đã cập nhật mô tả đơn hàng.';
        END;

        IF (@new_status = @current_status OR @new_status IS NULL)
           AND (@new_description = @current_description OR @new_description IS NULL)
        BEGIN
            PRINT N'Không có thay đổi để cập nhật.';
        END;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END





GO


--------Tạo đơn hàng từ đơn hàng có sẵn

GO
CREATE PROCEDURE sp_CloneOrderWithFifo
    @source_order_id VARCHAR(25),
    @pro_saleoff VARCHAR(25) = NULL,
    @pro_new VARCHAR(25) = NULL,
    @pro_discount VARCHAR(25) = NULL,
    @pro_ship VARCHAR(25) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @new_order_id VARCHAR(25), @order_seq INT;
    DECLARE @buyer INT, @seller INT, @description NVARCHAR(1000), @rank INT;

    BEGIN TRY
        BEGIN TRAN;

        -- Lấy thông tin đơn hàng gốc
        SELECT @buyer = buyer, @seller = seller, @description = description
        FROM order_tb WHERE order_id = @source_order_id;

        IF @buyer IS NULL
        BEGIN
            RAISERROR(N'Không tìm thấy đơn hàng nguồn %s.', 16, 1, @source_order_id);
            ROLLBACK;
            RETURN;
        END

        SELECT @rank = rank FROM user_tb WHERE user_id = @buyer;

        -- Tạo mã đơn hàng mới
        SELECT @order_seq = ISNULL(MAX(CAST(RIGHT(order_id, 5) AS INT)), 0) + 1
        FROM order_tb WHERE order_id LIKE 'ORD' + FORMAT(GETDATE(), 'yyyyMMdd') + '%';

        SET @new_order_id = CONCAT('ORD', FORMAT(GETDATE(), 'yyyyMMdd'), RIGHT('00000' + CAST(@order_seq AS VARCHAR), 5));

        -- Clone chi tiết đơn hàng gốc và tính tổng quantity/price của sản phẩm áp khuyến mãi
        DECLARE @tbl_order_d TABLE(product_id VARCHAR(25), quantity INT, price MONEY);
        INSERT INTO @tbl_order_d(product_id, quantity, price)
        SELECT product_id, quantity, price FROM order_d WHERE order_id = @source_order_id;

        -- Hàm kiểm tra điều kiện khuyến mãi
        DECLARE @pro_list TABLE(promotion_id VARCHAR(25));
        INSERT INTO @pro_list(promotion_id)
        SELECT val FROM (VALUES (@pro_saleoff), (@pro_new), (@pro_discount), (@pro_ship)) AS x(val)
        WHERE val IS NOT NULL;

        DECLARE @pid VARCHAR(25);
        DECLARE pro_cursor CURSOR FOR SELECT promotion_id FROM @pro_list;
        OPEN pro_cursor;
        FETCH NEXT FROM pro_cursor INTO @pid;

               WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @quan_cond INT, @val_cond MONEY, @oder_tb_cond INT, @group_tb_cond VARCHAR(25), @rank_cond INT, @pro_qty INT;
            SELECT 
                @quan_cond = quan_cond, @val_cond = val_cond, @oder_tb_cond = oder_tb_cond,
                @group_tb_cond = group_tb_cond, @rank_cond = rank_cond,
                @pro_qty = quantity
            FROM promotion WHERE promotion_id = @pid;

            --  Kiểm tra tồn kho khuyến mãi (quantity = 0 là không giới hạn)
            IF @pro_qty IS NOT NULL AND @pro_qty > 0
            BEGIN
                DECLARE @used_qty_promotion INT = (
                    SELECT COUNT(*) FROM order_tb
                    WHERE pro_saleoff = @pid OR pro_new = @pid OR pro_discount = @pid OR pro_ship = @pid
                );

                IF  @used_qty_promotion >= @pro_qty
                BEGIN
                    RAISERROR(N'Mã khuyến mãi %s đã hết lượt sử dụng.', 16, 1, @pid);
                    CLOSE pro_cursor; DEALLOCATE pro_cursor;
                    ROLLBACK;
                    RETURN;
                END
            END


            -- Tính tổng số lượng và tổng giá trị sản phẩm thuộc khuyến mãi
            DECLARE @total_qty INT = 0, @total_val MONEY = 0;

            SELECT 
                @total_qty = SUM(d.quantity),
                @total_val = SUM(d.price * d.quantity)
            FROM @tbl_order_d d
            WHERE EXISTS (
                SELECT 1 FROM promotion_product pp 
                WHERE pp.promotion_id = @pid AND pp.product_id = d.product_id
            )
            AND (
                @group_tb_cond IS NULL
                OR EXISTS (
                    SELECT 1 FROM group_tb g INNER JOIN product p ON g.group_tb_id = p.group_tb_1 OR g.group_tb_id = p.group_tb_2 OR g.group_tb_id = p.group_tb_3 OR g.group_tb_id = p.group_tb_4
                    WHERE d.product_id = d.product_id AND @group_tb_cond = g.group_tb_id
                )
            );

            -- Kiểm tra số đơn hàng của người mua
            DECLARE @order_count INT = (
                SELECT COUNT(*) FROM order_tb WHERE buyer = @buyer
            );

            IF (@quan_cond IS NOT NULL AND @total_qty < @quan_cond)
                OR (@val_cond IS NOT NULL AND @total_val < @val_cond)
                OR (@oder_tb_cond IS NOT NULL AND @order_count >= @oder_tb_cond)
                OR (@rank_cond IS NOT NULL AND @rank < @rank_cond)
            BEGIN
                RAISERROR(N'Không đủ điều kiện áp dụng mã khuyến mãi %s.', 16, 1, @pid);
                CLOSE pro_cursor; DEALLOCATE pro_cursor;
                ROLLBACK;
                RETURN;
            END

            FETCH NEXT FROM pro_cursor INTO @pid;
        END

        CLOSE pro_cursor; DEALLOCATE pro_cursor;

        -- Thêm đơn hàng mới
        INSERT INTO order_tb(order_id, date_created, buyer, seller, pro_saleoff, pro_new, pro_discount, pro_ship, description)
        VALUES (@new_order_id, GETDATE(), @buyer, @seller, @pro_saleoff, @pro_new, @pro_discount, @pro_ship, @description);

        -- Clone theo FIFO từng sản phẩm
        DECLARE cur CURSOR FOR SELECT product_id, quantity, price FROM @tbl_order_d;
        DECLARE @product_id VARCHAR(25), @quantity INT, @price MONEY;
        OPEN cur;
        FETCH NEXT FROM cur INTO @product_id, @quantity, @price;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @qty_needed INT = @quantity;
            DECLARE @pi_id VARCHAR(25), @available_qty INT, @cost MONEY;

            DECLARE fifo CURSOR FOR
            SELECT pi.pi_id, (pi.quantity - ISNULL(od.qty_used, 0)) AS available_qty, pi.cost
            FROM product_in pi
            LEFT JOIN (
                SELECT pi_id, SUM(quantity) AS qty_used
                FROM order_d
                WHERE product_id = @product_id
                GROUP BY pi_id
            ) od ON pi.pi_id = od.pi_id
            WHERE pi.product_id = @product_id
                AND (pi.quantity - ISNULL(od.qty_used, 0)) > 0
            ORDER BY pi.date_start;

            OPEN fifo;
            FETCH NEXT FROM fifo INTO @pi_id, @available_qty, @cost;

            WHILE @@FETCH_STATUS = 0 AND @qty_needed > 0
            BEGIN
                DECLARE @used_qty INT = CASE WHEN @qty_needed > @available_qty THEN @available_qty ELSE @qty_needed END;

                INSERT INTO order_d(order_id, product_id, pi_id, quantity, cost, price)
                VALUES (@new_order_id, @product_id, @pi_id, @used_qty, @cost, @price);

                SET @qty_needed -= @used_qty;

                FETCH NEXT FROM fifo INTO @pi_id, @available_qty, @cost;
            END

            CLOSE fifo;
            DEALLOCATE fifo;

            IF @qty_needed > 0
            BEGIN
                CLOSE cur;
                DEALLOCATE cur;
                RAISERROR(N'Tồn kho không đủ cho sản phẩm %s.', 16, 1, @product_id);
                ROLLBACK;
                RETURN;
            END

            FETCH NEXT FROM cur INTO @product_id, @quantity, @price;
        END

        CLOSE cur;
        DEALLOCATE cur;

        COMMIT;
        PRINT N'Đã tạo đơn hàng mới: ' + @new_order_id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH

END;



GO
----Tạo đơn hàng mua ngay

CREATE  PROCEDURE sp_CreateOrder_BuyNow
    @buyer INT,
    @seller INT,
    @product_id VARCHAR(25),
    @quantity INT,
    @price MONEY,
    @description NVARCHAR(1000) = NULL,
    @pro_saleoff VARCHAR(25) = NULL,
    @pro_new VARCHAR(25) = NULL,
    @pro_discount VARCHAR(25) = NULL,
    @pro_ship VARCHAR(25) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @order_id VARCHAR(25), @order_seq INT, @rank INT;

    BEGIN TRY
        BEGIN TRAN;

        -- 1. Kiểm tra trạng thái sản phẩm
        DECLARE @pro_status BIT;
        SELECT @pro_status = status FROM product WHERE product_id = @product_id;

        IF @pro_status <> 1
        BEGIN
            RAISERROR(N'Sản phẩm không còn được bán.', 16, 1);
            ROLLBACK;
            RETURN;
        END;

        -- 2. Lấy hạng người dùng
        SELECT @rank = rank FROM user_tb WHERE user_id = @buyer;

        -- 3. Kiểm tra khuyến mãi
        DECLARE @pro_list TABLE(promotion_id VARCHAR(25));
        INSERT INTO @pro_list(promotion_id)
        SELECT val FROM (VALUES (@pro_saleoff), (@pro_new), (@pro_discount), (@pro_ship)) AS x(val)
        WHERE val IS NOT NULL;

        DECLARE @pid VARCHAR(25);
        DECLARE cur CURSOR FOR SELECT promotion_id FROM @pro_list;
        OPEN cur;
        FETCH NEXT FROM cur INTO @pid;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @quan_cond INT, @val_cond MONEY, @oder_tb_cond INT, @group_tb_cond VARCHAR(25), @rank_cond INT, @pro_qty INT;

            SELECT 
                @quan_cond = quan_cond, @val_cond = val_cond,
                @oder_tb_cond = oder_tb_cond, @group_tb_cond = group_tb_cond,
                @rank_cond = rank_cond, @pro_qty = quantity
            FROM promotion WHERE promotion_id = @pid;

            -- Số lượt đã dùng
            IF @pro_qty IS NOT NULL AND @pro_qty > 0
            BEGIN
                DECLARE @used_qty_promotion INT = (
                    SELECT COUNT(*) FROM order_tb
                    WHERE pro_saleoff = @pid OR pro_new = @pid OR pro_discount = @pid OR pro_ship = @pid
                );
                IF @used_qty_promotion >= @pro_qty
                BEGIN
                    RAISERROR(N'Mã khuyến mãi %s đã hết lượt sử dụng.', 16, 1, @pid);
                    CLOSE cur; DEALLOCATE cur;
                    ROLLBACK;
                    RETURN;
                END
            END

            -- Kiểm tra điều kiện khuyến mãi
            DECLARE @total_qty INT = @quantity;
            DECLARE @total_val MONEY = @quantity * @price;

            IF NOT EXISTS (SELECT 1 FROM promotion_product WHERE promotion_id = @pid AND product_id = @product_id)
            BEGIN
                RAISERROR(N'Sản phẩm không nằm trong khuyến mãi %s.', 16, 1, @pid);
                CLOSE cur; DEALLOCATE cur;
                ROLLBACK;
                RETURN;
            END;

            IF @group_tb_cond IS NOT NULL
            BEGIN
                IF NOT EXISTS (
                    SELECT 1 FROM product 
                    WHERE product_id = @product_id
                    AND (@group_tb_cond = group_tb_1 OR @group_tb_cond = group_tb_2 OR @group_tb_cond = group_tb_3 OR @group_tb_cond = group_tb_4)
                )
                BEGIN
                    RAISERROR(N'Sản phẩm không thuộc nhóm khuyến mãi %s.', 16, 1, @pid);
                    CLOSE cur; DEALLOCATE cur;
                    ROLLBACK;
                    RETURN;
                END
            END

            IF (@quan_cond IS NOT NULL AND @total_qty < @quan_cond)
                OR (@val_cond IS NOT NULL AND @total_val < @val_cond)
                OR (@oder_tb_cond IS NOT NULL AND (
                        SELECT COUNT(*) FROM order_tb WHERE buyer = @buyer
                    ) >= @oder_tb_cond)
                OR (@rank_cond IS NOT NULL AND @rank < @rank_cond)
            BEGIN
                RAISERROR(N'Không đủ điều kiện khuyến mãi %s.', 16, 1, @pid);
                CLOSE cur; DEALLOCATE cur;
                ROLLBACK;
                RETURN;
            END

            FETCH NEXT FROM cur INTO @pid;
        END
        CLOSE cur; DEALLOCATE cur;

        -- 4. Tạo mã đơn hàng
        SELECT @order_seq = ISNULL(MAX(CAST(RIGHT(order_id, 5) AS INT)), 0) + 1
        FROM order_tb
        WHERE order_id LIKE 'ORD' + FORMAT(GETDATE(), 'yyyyMMdd') + '%';

        SET @order_id = CONCAT('ORD', FORMAT(GETDATE(), 'yyyyMMdd'), RIGHT('00000' + CAST(@order_seq AS VARCHAR), 5));

        -- 5. Ghi đơn hàng
        INSERT INTO order_tb(order_id, date_created, buyer, seller, description, pro_saleoff, pro_new, pro_discount, pro_ship)
        VALUES (@order_id, GETDATE(), @buyer, @seller, @description, @pro_saleoff, @pro_new, @pro_discount, @pro_ship);

        -- 6. FIFO nhập trước xuất trước
        DECLARE @qty_needed INT = @quantity;
        DECLARE @pi_id VARCHAR(25), @available_qty INT, @cost MONEY;

        DECLARE fifo CURSOR FOR
        SELECT pi.pi_id, (pi.quantity - ISNULL(od.qty_used, 0)) AS available_qty, pi.cost
        FROM product_in pi
        LEFT JOIN (
            SELECT pi_id, SUM(quantity) AS qty_used
            FROM order_d
            WHERE product_id = @product_id
            GROUP BY pi_id
        ) od ON pi.pi_id = od.pi_id
        WHERE pi.product_id = @product_id
          AND (pi.quantity - ISNULL(od.qty_used, 0)) > 0
        ORDER BY pi.date_start;

        OPEN fifo;
        FETCH NEXT FROM fifo INTO @pi_id, @available_qty, @cost;

        WHILE @@FETCH_STATUS = 0 AND @qty_needed > 0
        BEGIN
            DECLARE @used_qty INT = CASE WHEN @qty_needed > @available_qty THEN @available_qty ELSE @qty_needed END;

            INSERT INTO order_d(order_id, product_id, pi_id, quantity, cost, price)
            VALUES (@order_id, @product_id, @pi_id, @used_qty, @cost, @price);

            SET @qty_needed -= @used_qty;
            FETCH NEXT FROM fifo INTO @pi_id, @available_qty, @cost;
        END

        CLOSE fifo;
        DEALLOCATE fifo;

        IF @qty_needed > 0
        BEGIN
            RAISERROR(N'Tồn kho không đủ cho sản phẩm.', 16, 1);
            ROLLBACK;
            RETURN;
        END;

        COMMIT;
        PRINT N'Đã tạo đơn hàng mua ngay: ' + @order_id;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END

GO


------- Khi cập nhật brand.status = 0 thì cập nhật luôn product.status = 0
CREATE  PROCEDURE sp_UpdateBrandStatus
    @brand_id VARCHAR(25),
    @new_status BIT,
	@user_id int
AS
BEGIN
    SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM user_tb WHERE user_id = @user_id AND ( admin = 1 ))
	BEGIN
    BEGIN TRY
        BEGIN TRAN;

        -- 1. Cập nhật brand
        UPDATE brand
        SET status = @new_status
        WHERE brand_id = @brand_id;

        -- 2. Nếu tắt brand thì cập nhật luôn product
        IF @new_status = 0
        BEGIN
            UPDATE product
            SET status = 0
            WHERE brand_id = @brand_id AND status <> 0;
        END

        COMMIT;
        PRINT N'Đã cập nhật trạng thái thương hiệu và sản phẩm liên quan.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;

        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END
END
GO
go
---------Khi  đổi trạng thái người dùng status = 0 hoặc seller = 0 thì cập nhật product.status = 0
CREATE  PROCEDURE sp_UpdateUserStatus
@user_id INT,
@new_status BIT = NULL, -- NULL nghĩa là không thay đổi
@new_seller BIT = NULL -- NULL nghĩa là không thay đổi
AS
BEGIN
SET NOCOUNT ON;

BEGIN TRY
    BEGIN TRAN;

    -- Lấy trạng thái hiện tại
    DECLARE @cur_status BIT, @cur_seller BIT;
    SELECT @cur_status = status, @cur_seller = seller
    FROM user_tb WHERE user_id = @user_id;

    -- Cập nhật nếu có thay đổi
    UPDATE user_tb
    SET
        status = ISNULL(@new_status, status),
        seller = ISNULL(@new_seller, seller)
    WHERE user_id = @user_id;

    -- Nếu status = 0 hoặc seller = 0 thì cập nhật các sản phẩm về status = 0
    IF (ISNULL(@new_status, @cur_status) = 0 OR ISNULL(@new_seller, @cur_seller) = 0)
    BEGIN
        UPDATE product
        SET status = 0
        WHERE user_id = @user_id AND status <> 0;
    END

    COMMIT;
    PRINT N'Đã cập nhật trạng thái người dùng và sản phẩm liên quan (nếu cần).';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@Err, 16, 1);
END CATCH


END



Go
-----Store cập nhật số lượng sản phẩm trong giỏ hàng
CREATE  PROCEDURE sp_UpdateCartQuantity
@user_id INT,
@product_id VARCHAR(25),
@new_quantity INT
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
    -- Kiểm tra sản phẩm đã có trong giỏ hàng chưa
    IF EXISTS (
        SELECT 1
        FROM cart
        WHERE user_id = @user_id AND product_id = @product_id
    )
    BEGIN
        -- Nếu new_quantity <= 0 thì xóa khỏi giỏ hàng
        IF @new_quantity <= 0
        BEGIN
            DELETE FROM cart
            WHERE user_id = @user_id AND product_id = @product_id;

            PRINT N'Đã xóa sản phẩm khỏi giỏ hàng.';
        END
        ELSE
        BEGIN
            -- Cập nhật số lượng nếu thay đổi
            UPDATE cart
            SET quantity = @new_quantity
            WHERE user_id = @user_id AND product_id = @product_id;

            PRINT N'Đã cập nhật số lượng sản phẩm trong giỏ hàng.';
        END
    END
    ELSE
    BEGIN
        RAISERROR(N'Sản phẩm không tồn tại trong giỏ hàng.', 16, 1);
    END
END TRY
BEGIN CATCH
    DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@Err, 16, 1);
END CATCH

END


GO







--------- Tạo/ cập nahatj payment method
CREATE  PROCEDURE sp_Upsert_PaymentMethod
    @method_id VARCHAR(25),
    @name NVARCHAR(75),
    @type INT,
    @description NVARCHAR(1000),
    @date_created DATETIME,
    @fee_rate INT,
    @url NVARCHAR(200),
    @logo_url NVARCHAR(200),
    @bank NVARCHAR(100),
    @num_account INT,
    @name_account NVARCHAR(75),
    @refund BIT,
    @sort INT,
    @status BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM payment_method WHERE method_id = @method_id)
        BEGIN
            -- Chỉ cập nhật nếu có bất kỳ trường nào thay đổi
            IF EXISTS (
                SELECT 1
                FROM payment_method
                WHERE method_id = @method_id
                AND (
                    ISNULL(name, '') <> ISNULL(@name, '') OR
                    ISNULL(type, -1) <> ISNULL(@type, -1) OR
                    ISNULL(description, '') <> ISNULL(@description, '') OR
                    ISNULL(fee_rate, -1) <> ISNULL(@fee_rate, -1) OR
                    ISNULL(url, '') <> ISNULL(@url, '') OR
                    ISNULL(logo_url, '') <> ISNULL(@logo_url, '') OR
                    ISNULL(bank, '') <> ISNULL(@bank, '') OR
                    ISNULL(num_account, -1) <> ISNULL(@num_account, -1) OR
                    ISNULL(name_account, '') <> ISNULL(@name_account, '') OR
                    ISNULL(refund, -1) <> ISNULL(@refund, -1) OR
                    ISNULL(sort, -1) <> ISNULL(@sort, -1) OR
                    ISNULL(status, -1) <> ISNULL(@status, -1)
                )
            )
            BEGIN
                UPDATE payment_method
                SET
                    name = @name,
                    type = @type,
                    description = @description,
                    fee_rate = @fee_rate,
                    url = @url,
                    logo_url = @logo_url,
                    bank = @bank,
                    num_account = @num_account,
                    name_account = @name_account,
                    refund = @refund,
                    sort = @sort,
                    status = @status
                WHERE method_id = @method_id;

                PRINT N'Đã cập nhật phương thức thanh toán.';
            END
            ELSE
            BEGIN
                PRINT N'Không có thay đổi. Không cập nhật.';
            END
        END
        ELSE
        BEGIN
            -- Thêm mới
            INSERT INTO payment_method (
                method_id, name, type, description, date_created,
                fee_rate, url, logo_url, bank, num_account, name_account,
                refund, sort, status
            )
            VALUES (
                @method_id, @name, @type, @description, @date_created,
                @fee_rate, @url, @logo_url, @bank, @num_account, @name_account,
                @refund, @sort, @status
            );

            PRINT N'Đã thêm mới phương thức thanh toán.';
        END
    END TRY
    BEGIN CATCH
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END



Go 
------Ghi Login history
CREATE  PROCEDURE sp_InsertLogHistory
    @user_id INT,
    @IP VARCHAR(50),
    @status INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO log_hisory (user_id, date_log, IP, status)
        VALUES (@user_id, GETDATE(), @IP, @status);
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
Go



-------Ghi lượt click
CREATE  PROCEDURE sp_InsertClickProduct
    @product_id VARCHAR(25),
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;
	SET @user_id = ISNULL(@user_id,-1)
    BEGIN TRY
        INSERT INTO click_product (product_id, user_id, date_click)
        VALUES (@product_id, @user_id, GETDATE());
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END


GO

-------Tạo hóa đơn

CREATE  PROCEDURE sp_create_invoice_from_order
@order_id VARCHAR(25),
@method_id VARCHAR(25),
@invoice_id VARCHAR(25) OUTPUT,
@result BIT OUTPUT,
@ship_amount money = 30000,
@message NVARCHAR(200) OUTPUT
AS
BEGIN
SET NOCOUNT ON;
-- Kiểm tra đơn hàng tồn tại
IF NOT EXISTS (SELECT 1 FROM order_tb WHERE order_id = @order_id)
BEGIN
    SET @result = 0;
    SET @message = N'Không tồn tại đơn hàng.';
    RETURN;
END

DECLARE 
    @amount MONEY = 0,
    @promotion MONEY = 0,
    @tax_amount MONEY = 0,
    @cost MONEY = 0,
    @amount_payable MONEY = 0;

DECLARE 
    @pro_saleoff VARCHAR(25),
    @pro_new VARCHAR(25),
    @pro_discount VARCHAR(25);

SELECT 
    @pro_saleoff = pro_saleoff,
    @pro_new = pro_new,
    @pro_discount = pro_discount
FROM order_tb
WHERE order_id = @order_id;

DECLARE @tmp TABLE (
    product_id VARCHAR(25),
    quantity INT,
    price MONEY,
    cost MONEY,
    promo_saleoff MONEY,
    promo_new MONEY,
    promo_discount MONEY
);

INSERT INTO @tmp (product_id, quantity, price, cost, promo_saleoff, promo_new, promo_discount)
SELECT 
    od.product_id,
    od.quantity,
    od.price,
    od.cost,
    0, 0, 0
FROM order_d od
WHERE od.order_id = @order_id;

-- SALE OFF
IF @pro_saleoff IS NOT NULL
BEGIN
    UPDATE t
    SET promo_saleoff =
        CASE p.calculate
            WHEN 1 THEN t.price * t.quantity * p.value / 100
            WHEN 2 THEN p.value
            ELSE 0
        END
    FROM @tmp t
    JOIN promotion_product pp ON t.product_id = pp.product_id AND pp.promotion_id = @pro_saleoff
    JOIN promotion p ON p.promotion_id = @pro_saleoff
    WHERE p.status = 1 AND p.date_start <= GETDATE() AND (p.date_end IS NULL OR p.date_end >= GETDATE());
END

-- NEW
IF @pro_new IS NOT NULL
BEGIN
    UPDATE t
    SET promo_new =
        CASE p.calculate
            WHEN 1 THEN (t.price * t.quantity - t.promo_saleoff) * p.value / 100
            WHEN 2 THEN p.value
            ELSE 0
        END
    FROM @tmp t
    JOIN promotion_product pp ON t.product_id = pp.product_id AND pp.promotion_id = @pro_new
    JOIN promotion p ON p.promotion_id = @pro_new
    WHERE p.status = 1 AND p.date_start <= GETDATE() AND (p.date_end IS NULL OR p.date_end >= GETDATE());
END

-- DISCOUNT
IF @pro_discount IS NOT NULL
BEGIN
    UPDATE t
    SET promo_discount =
        CASE p.calculate
            WHEN 1 THEN (t.price * t.quantity - t.promo_saleoff - t.promo_new) * p.value / 100
            WHEN 2 THEN p.value
            ELSE 0
        END
    FROM @tmp t
    JOIN promotion_product pp ON t.product_id = pp.product_id AND pp.promotion_id = @pro_discount
    JOIN promotion p ON p.promotion_id = @pro_discount
    WHERE p.status = 1 AND p.date_start <= GETDATE() AND (p.date_end IS NULL OR p.date_end >= GETDATE());
END

-- Tổng tiền
SELECT 
    @amount = SUM(price * quantity),
    @cost = SUM(cost * quantity),
    @promotion = SUM(promo_saleoff + promo_new + promo_discount)
FROM @tmp;

-- Ship giảm nếu có pro_ship
SELECT TOP 1
    @ship_amount =
        CASE p.calculate
            WHEN 1 THEN @ship_amount - (@ship_amount * p.value / 100)
            WHEN 2 THEN CASE WHEN @ship_amount > p.value THEN @ship_amount - p.value ELSE 0 END
            ELSE @ship_amount
        END
FROM order_tb o
JOIN promotion p ON o.pro_ship = p.promotion_id
WHERE o.order_id = @order_id
  AND p.status = 1
  AND p.date_start <= GETDATE()
  AND (p.date_end IS NULL OR p.date_end >= GETDATE());

----SET @tax_amount = ROUND((@amount - @promotion) * 0.1, 0);
SET @amount_payable = @amount - @promotion + @tax_amount + @ship_amount;
SET @invoice_id = CONCAT('INV', FORMAT(GETDATE(), 'yyyyMMddHHmmss'), RIGHT(NEWID(), 5));

INSERT INTO invoice (
    invoice_id, order_id, date_created, date_payment,
    method, amount, ship_amount, tax_amount, promotion, 
    cost, amount_payable, payment, balanced, description, status
)
VALUES (
    @invoice_id, @order_id, GETDATE(), NULL,
    @method_id, @amount, @ship_amount, @tax_amount, @promotion,
    @cost, @amount_payable, 0, @amount_payable, N'Hóa đơn từ đơn hàng', 1
);

SET @result = 1;
SET @message = N'Tạo hóa đơn thành công.';
END;
GO



------Store cập nhật trạng thái, ngày thanh toán, chú thích hóa đơn
CREATE  PROCEDURE sp_UpdateInvoice
@invoice_id VARCHAR(25),
@date_payment DATE = NULL,
@description NVARCHAR(1000) = NULL,
@status INT = NULL
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM invoice WHERE invoice_id = @invoice_id)
    BEGIN
        RAISERROR(N'Hóa đơn không tồn tại.', 16, 1);
        RETURN;
    END;

    UPDATE invoice
    SET
        date_payment = ISNULL(@date_payment, date_payment),
        description   = ISNULL(@description, description),
        status        = ISNULL(@status, status)
    WHERE invoice_id = @invoice_id;

    PRINT N'Đã cập nhật hóa đơn thành công.';
END TRY
BEGIN CATCH
    DECLARE @Err NVARCHAR(1000) = ERROR_MESSAGE();
    RAISERROR(@Err, 16, 1);
END CATCH
END;
GO

------- Tạo đơn giao hàng từ đơn hàng 
CREATE PROCEDURE sp_CreateShipmentFromOrder
@order_id VARCHAR(25),
@address_id VARCHAR(25),
@date_est_deli DATETIME,
@shipper1_id VARCHAR(25) = NULL,
@shipper1_name NVARCHAR(75) = NULL,
@phone1 CHAR(10) = NULL,
@description NVARCHAR(1000) = NULL
AS
BEGIN
SET NOCOUNT ON;

DECLARE @shipment_id VARCHAR(25), @shipment_seq INT;
DECLARE @name_receive NVARCHAR(75), @phone_receive CHAR(10);
DECLARE @date_receipt DATE;

BEGIN TRY
    BEGIN TRAN;

    -- Kiểm tra đơn hàng
    SELECT @date_receipt = date_created
    FROM order_tb
    WHERE order_id = @order_id;

    IF @date_receipt IS NULL
    BEGIN
        RAISERROR(N'Không tìm thấy đơn hàng.', 16, 1);
        ROLLBACK;
        RETURN;
    END;

    -- Lấy thông tin địa chỉ người nhận
    SELECT @name_receive = name, @phone_receive = phone
    FROM address
    WHERE address_id = @address_id AND status = 1;

    IF @name_receive IS NULL
    BEGIN
        RAISERROR(N'Địa chỉ không hợp lệ hoặc đã bị vô hiệu.', 16, 1);
        ROLLBACK;
        RETURN;
    END;

    -- Sinh shipment_id
    SELECT @shipment_seq = ISNULL(MAX(CAST(RIGHT(shipment_id, 5) AS INT)), 0) + 1
    FROM shipment
    WHERE shipment_id LIKE 'SHIP' + FORMAT(GETDATE(), 'yyyyMMdd') + '%';

    SET @shipment_id = CONCAT('SHIP', FORMAT(GETDATE(), 'yyyyMMdd'), RIGHT('00000' + CAST(@shipment_seq AS VARCHAR), 5));

    -- Tạo bản ghi shipment
    INSERT INTO shipment (
        shipment_id, date_created, date_receipt, date_est_deli, date_actual_deli,
        shipper1_id, shipper1_name, phone1,
        order_id, address_id,
        name_receive, phone_receive,
        description, status
    )
    VALUES (
        @shipment_id, GETDATE(), @date_receipt, @date_est_deli, NULL,
        @shipper1_id, @shipper1_name, @phone1,
        @order_id, @address_id,
        @name_receive, @phone_receive,
        @description, 0
    );

    -- Thêm dữ liệu chi tiết từ order_d
    INSERT INTO shipment_d (shipment_id, product_id, order_id, quantity)
    SELECT @shipment_id, product_id, order_id, SUM(quantity)
    FROM order_d
    WHERE order_id = @order_id
    GROUP BY product_id, order_id;

    COMMIT;
    PRINT N'Đã tạo đơn giao hàng: ' + @shipment_id;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    DECLARE @Err NVARCHAR(1000) = ERROR_MESSAGE();
    RAISERROR(@Err, 16, 1);
END CATCH

END;
GO




------- tạo/ cập nhật địa chỉ
CREATE  PROCEDURE sp_UpsertAddress
@address_id VARCHAR(25),
@name NVARCHAR(75) = '',
@phone CHAR(10) = '',
@description NVARCHAR(1000) = '',
@country NVARCHAR(75) = '',
@city NVARCHAR(75) = '',
@district NVARCHAR(75) = '',
@ward NVARCHAR(75) = '',
@street NVARCHAR(75) = '',
@detail NVARCHAR(75) = '',
@user_id VARCHAR(25) = '',
@status BIT = null
AS
BEGIN
SET NOCOUNT ON;
IF NOT EXISTS (SELECT 1 FROM address WHERE address_id = @address_id)
BEGIN

    INSERT INTO address (
        address_id, name, phone, description,
        country, city, district, ward, street, detail,
        user_id, status
    )
    VALUES (
        @address_id, @name, @phone, @description,
        @country, @city, @district, @ward, @street, @detail,
        @user_id, 1
    );

    PRINT N'Đã thêm địa chỉ mới.';
END
ELSE
BEGIN
    UPDATE address
    SET
        name = CASE WHEN @name <> '' AND @name <> name THEN @name ELSE name END,
        phone = CASE WHEN @phone <> '' AND @phone <> phone THEN @phone ELSE phone END,
        description = CASE WHEN @description <> '' AND @description <> description THEN @description ELSE description END,
        country = CASE WHEN @country <> '' AND @country <> country THEN @country ELSE country END,
        city = CASE WHEN @city <> '' AND @city <> city THEN @city ELSE city END,
        district = CASE WHEN @district <> '' AND @district <> district THEN @district ELSE district END,
        ward = CASE WHEN @ward <> '' AND @ward <> ward THEN @ward ELSE ward END,
        street = CASE WHEN @street <> '' AND @street <> street THEN @street ELSE street END,
        detail = CASE WHEN @detail <> '' AND @detail <> detail THEN @detail ELSE detail END,
        user_id = CASE WHEN @user_id <> '' AND @user_id <> user_id THEN @user_id ELSE user_id END,
        status = CASE WHEN @status is not null AND @status <> status THEN @status ELSE status END
    WHERE address_id = @address_id;

    PRINT N'Đã cập nhật địa chỉ (nếu có thay đổi).';
END

END;
GO

----- View xem tồn kho sản phẩm


IF OBJECT_ID('vw_product_inventory', 'V') IS NOT NULL
    DROP VIEW vw_product_inventory;
GO

CREATE VIEW vw_product_inventory AS
WITH Inventory AS (
    SELECT 
        p.product_id,
        p.name,
        p.name2,
        p.description,
		p.brand_id,
        p.category_id,
        p.group_tb_1,
        p.group_tb_2,
        p.group_tb_3,
        p.group_tb_4,
		p.price1 as price,
		p.url_image1,
		p.url_image2,
		p.url_image3,
		p.uom,
        p.status as pro_status,
		b.status as brand_status,
        ISNULL(SUM(pi.quantity), 0) AS quantity_in,
        ISNULL(SUM(od.quantity), 0) AS quantity_sold,
        ISNULL(SUM(pi.quantity), 0) - ISNULL(SUM(od.quantity), 0) AS quantity_available
    FROM product p left join brand b on p.brand_id = b.brand_id 
    LEFT JOIN product_in pi ON p.product_id = pi.product_id
    LEFT JOIN order_d od ON p.product_id = od.product_id
    GROUP BY 
        p.product_id, p.name, p.name2, p.description, p.brand_id, 
        p.category_id, p.group_tb_1, p.group_tb_2, 
        p.group_tb_3, p.group_tb_4, p.price1, p.status, b.status, p.uom, p.url_image1, p.url_image2, p.url_image3
)
SELECT * FROM Inventory;

GO

----- View xem danh sách sản phẩm

IF OBJECT_ID('vw_product_seller', 'V') IS NOT NULL
    DROP VIEW vw_product_seller;
GO

CREATE VIEW vw_product_seller AS
WITH ProductList AS (
    SELECT 
        *
    FROM product p
)
SELECT * FROM ProductList;




GO




------- View xem danh sách brand
IF OBJECT_ID('vw_brand', 'V') IS NOT NULL
    DROP VIEW vw_brand;
GO

CREATE VIEW vw_brand AS
WITH BrandList AS (
    SELECT 
        *
    FROM brand
)
SELECT * FROM BrandList;

GO





---- VIEW danh sách người dùng
IF OBJECT_ID('vw_user', 'V') IS NOT NULL
    DROP VIEW vw_user;
GO

CREATE VIEW vw_user AS
WITH UserList AS (
    SELECT 
        a.*,
		name ,
		name2 ,
		birthday ,
		phone_number,
		address ,
		email,
		social_url1,
		social_url2,
		social_url3,
		logo_url
    FROM user_tb a left join user_tb2 b on a.user_id = b.user_id
)
SELECT * FROM UserList;

GO



-----VIEW xem promotion_detail
IF OBJECT_ID('vw_promotion_detail', 'V') IS NOT NULL
    DROP VIEW vw_promotion_detail;
GO

CREATE VIEW vw_promotion_detail AS
WITH Promotion_detail AS (
    SELECT 
		p1.product_id,
        p2.*,
		p1.status as detail_status
    FROM promotion_product p1 inner join promotion p2 on p1.promotion_id = p2.promotion_id
)
SELECT * FROM Promotion_detail;

GO



----- View lượt dùng promotion
IF OBJECT_ID('vw_promotion_used', 'V') IS NOT NULL
    DROP VIEW vw_promotion_used;
GO

CREATE VIEW vw_promotion_used AS
-------Gom mã giảm thành 1 trường để count
WITH AllPromotionUsage AS (
    SELECT pro_discount AS promotion_id FROM order_tb WHERE pro_discount IS NOT NULL
    UNION ALL
    SELECT pro_new FROM order_tb WHERE pro_new IS NOT NULL
    UNION ALL
    SELECT pro_saleoff FROM order_tb WHERE pro_saleoff IS NOT NULL
    UNION ALL
    SELECT pro_ship FROM order_tb WHERE pro_ship IS NOT NULL
),
------Đếm số lượng dùng
UsageSummary AS (
    SELECT 
        promotion_id,
        COUNT(*) AS quantity_used
    FROM AllPromotionUsage
    GROUP BY promotion_id
)
SELECT 
    d.*,
    ISNULL(p.quantity, 0) AS quantity_total,
    ISNULL(u.quantity_used, 0) AS quantity_used,
    ISNULL(p.quantity, 0) - ISNULL(u.quantity_used, 0) AS quantity_available
FROM promotion p
LEFT JOIN UsageSummary u ON p.promotion_id = u.promotion_id
LEFT JOIN vw_promotion_detail d ON d.product_id = p.promotion_id



GO

----- Truy vấn thông tin wishlist
IF OBJECT_ID('vw_wishlist_detail', 'V') IS NOT NULL
    DROP VIEW vw_wishlist_detail;
GO

CREATE OR ALTER VIEW vw_wishlist_detail AS
SELECT 
    w.user_id,
    u.user_name,
    w.product_id,
    w.product_name,
    w.product_description,
    p.brand_id,
    p.category_id,
    p.group_tb_1,
    p.group_tb_2,
    p.group_tb_3,
    p.group_tb_4,
    p.price1,
    p.url_image1,
    p.status
FROM wishlist w
JOIN user_tb u ON w.user_id = u.user_id
JOIN product p ON w.product_id = p.product_id;
GO




----- View thông tin giỏ hàng
IF OBJECT_ID('vw_cart_detail', 'V') IS NOT NULL
    DROP VIEW vw_cart_detail;
GO

CREATE OR ALTER VIEW vw_cart_detail AS
SELECT 
    c.user_id,
    u.user_name,
    c.product_id,
    c.product_name,
    p.description,
    c.quantity,
    c.price,
    (c.quantity * c.price) AS total_price,
    p.category_id,
    p.brand_id,
    p.group_tb_1,
    p.group_tb_2,
    p.url_image1,
    p.status
FROM cart c
JOIN user_tb u ON c.user_id = u.user_id
JOIN product p ON c.product_id = p.product_id;


GO






