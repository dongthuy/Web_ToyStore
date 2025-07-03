using System;
using System.Collections.Generic;
using back_end.Models.Entity;
using Microsoft.EntityFrameworkCore;

namespace back_end.Models;

    public partial class WebCodeContext : DbContext
{
    public WebCodeContext()
    {
    }

    public WebCodeContext(DbContextOptions<WebCodeContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Address> Addresses { get; set; }
    public virtual DbSet<Brand> Brands { get; set; }
    public virtual DbSet<Cart> Carts { get; set; }
    public virtual DbSet<Category> Categories { get; set; }
    public virtual DbSet<ChangeHistory> ChangeHistories { get; set; }
    public virtual DbSet<ChatDetail> ChatDetails { get; set; }
    public virtual DbSet<ChatMember> ChatMembers { get; set; }
    public virtual DbSet<ChatTab> ChatTabs { get; set; }
    public virtual DbSet<ClickProduct> ClickProducts { get; set; }
   // public virtual DbSet<GroupTb> GroupTbs { get; set; }
    public virtual DbSet<Invoice> Invoices { get; set; }
    public virtual DbSet<LogHisory> LogHisories { get; set; }
    public virtual DbSet<OrderD> OrderDs { get; set; }
    public virtual DbSet<OrderTb> OrderTbs { get; set; }
    public virtual DbSet<PaymentMethod> PaymentMethods { get; set; }
    public virtual DbSet<Product> Products { get; set; }
    public virtual DbSet<ProductIn> ProductIns { get; set; }
    public virtual DbSet<Promotion> Promotions { get; set; }
    public virtual DbSet<PromotionProduct> PromotionProducts { get; set; }
    public virtual DbSet<Rating> Ratings { get; set; }
    public virtual DbSet<Shipment> Shipments { get; set; }
    public virtual DbSet<ShipmentD> ShipmentDs { get; set; }
    public virtual DbSet<Support> Supports { get; set; }
    public virtual DbSet<Tax> Taxes { get; set; }
    public virtual DbSet<User> Users { get; set; }
    public virtual DbSet<UserDetails> UserDetails { get; set; }
    public virtual DbSet<Wishlist> Wishlists { get; set; }
    public DbSet<OrderTb> OrderTb { get; set; }       // Entity Order header

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Address>(entity =>
        {
            modelBuilder.Entity<User>().ToTable("user_tb");
            modelBuilder.Entity<UserDetails>().ToTable("user_tb2");

            entity.HasKey(e => e.AddressId).HasName("PK__address__CAA247C843DE5976");

            entity.ToTable("address");

            entity.Property(e => e.AddressId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("address_id");
            entity.Property(e => e.City)
                .HasMaxLength(75)
                .HasColumnName("city");
            entity.Property(e => e.Country)
                .HasMaxLength(75)
                .HasColumnName("country");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.Detail)
                .HasMaxLength(75)
                .HasColumnName("detail");
            entity.Property(e => e.District)
                .HasMaxLength(75)
                .HasColumnName("district");
            entity.Property(e => e.Name)
                .HasMaxLength(75)
                .HasColumnName("name");
            entity.Property(e => e.Phone)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
            entity.Property(e => e.Street)
                .HasMaxLength(75)
                .HasColumnName("street");
            entity.Property(e => e.UserId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("user_id");
            entity.Property(e => e.Ward)
                .HasMaxLength(75)
                .HasColumnName("ward");
        });

        // Cho biết bảng order_tb có trigger tên trg_OrderTb_Audit (ví dụ)
    modelBuilder.Entity<OrderTb>(entity =>
    {
        entity.ToTable("order_tb", tb => tb.HasTrigger("trg_OrderTb_Audit"));
        
        // Các cấu hình cột/khóa khác nếu có...
        entity.HasKey(e => e.OrderId);
        entity.Property(e => e.OrderId)
              .HasMaxLength(25)
              .IsUnicode(false)
              .HasColumnName("order_id");
        // … 
    });

    // Cho biết bảng order_d có trigger tên trg_OrderD_UpdateLog (ví dụ)
    modelBuilder.Entity<OrderD>(entity =>
    {
        entity.ToTable("order_d", tb => tb.HasTrigger("trg_OrderD_UpdateLog"));

        entity.HasKey(e => new { e.OrderId, e.ProductId, e.PiId });
        entity.Property(e => e.OrderId)
              .HasMaxLength(25)
              .IsUnicode(false)
              .HasColumnName("order_id");
        entity.Property(e => e.ProductId)
              .HasMaxLength(25)
              .IsUnicode(false)
              .HasColumnName("product_id");
        entity.Property(e => e.PiId)
              .HasMaxLength(25)
              .IsUnicode(false)
              .HasColumnName("pi_id");
        // …
    });

        modelBuilder.Entity<Brand>(entity =>
        {
            entity.HasKey(e => e.BrandId).HasName("PK__brand__5E5A8E27E925AC1C");

            entity.ToTable("brand");

            entity.Property(e => e.BrandId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("brand_id");
            entity.Property(e => e.BrandName)
                .HasMaxLength(75)
                .HasColumnName("brand_name");
            entity.Property(e => e.BrandName2)
                .HasMaxLength(75)
                .HasColumnName("brand_name2");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
        });

        // modelBuilder.Entity<OrderD>().HasKey(od => new { od.OrderId, od.ProductId, od.ProductInventoryId });

        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => new { e.UserId, e.ProductId }).HasName("PK__cart__FDCE10D0532C105C");

            entity.ToTable("cart");

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.Price)
                .HasColumnType("money")
                .HasColumnName("price");
            entity.Property(e => e.ProductName)
                .HasMaxLength(75)
                .HasColumnName("product_name");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.Product).WithMany(p => p.Carts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__cart__product_id__00200768");

            entity.HasOne(d => d.User).WithMany(p => p.Carts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__cart__user_id__7F2BE32F");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.CategoryId).HasName("PK__category__D54EE9B4A80B65C7");

            entity.ToTable("category");

            entity.Property(e => e.CategoryId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("category_id");
            entity.Property(e => e.CategoryName)
                .HasMaxLength(75)
                .HasColumnName("category_name");
            entity.Property(e => e.CategoryName2)
                .HasMaxLength(75)
                .HasColumnName("category_name2");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
        });

        modelBuilder.Entity<ChangeHistory>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("change_history");

            entity.Property(e => e.DateAct)
                .HasColumnType("datetime")
                .HasColumnName("date_act");
            entity.Property(e => e.NewVal).HasColumnName("new_val");
            entity.Property(e => e.OldVal).HasColumnName("old_val");
            entity.Property(e => e.Status).HasColumnName("status");
            entity.Property(e => e.TableChange)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("table_change");
            entity.Property(e => e.Type)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("type");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany()
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__change_hi__user___18EBB532");
        });

        modelBuilder.Entity<ChatDetail>(entity =>
        {
            entity.HasKey(e => e.ChatRec).HasName("PK__chat_det__F8FF4C8A35CC9C2F");

            entity.ToTable("chat_detail");

            entity.Property(e => e.ChatRec).HasColumnName("chat_rec");
            entity.Property(e => e.ChatReply).HasColumnName("chat_reply");
            entity.Property(e => e.DateCreated)
                .HasColumnType("datetime")
                .HasColumnName("date_created");
            entity.Property(e => e.IsRead).HasColumnName("isRead");
            entity.Property(e => e.MemberReply).HasColumnName("member_reply");
            entity.Property(e => e.MemberSend).HasColumnName("member_send");
            entity.Property(e => e.MsgTxt).HasColumnName("msg_txt");
            entity.Property(e => e.NameSend).HasColumnName("name_send");
            entity.Property(e => e.Pin).HasColumnName("pin");
        });

        modelBuilder.Entity<ChatMember>(entity =>
        {
            entity.HasKey(e => e.MemberId).HasName("PK__chat_mem__B29B853487EB43C7");

            entity.ToTable("chat_member");

            entity.Property(e => e.MemberId).HasColumnName("member_id");
            entity.Property(e => e.ChatId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("chat_id");
            entity.Property(e => e.DateJoined)
                .HasColumnType("datetime")
                .HasColumnName("date_joined");
            entity.Property(e => e.MemberName)
                .HasMaxLength(75)
                .HasColumnName("member_name");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Chat).WithMany(p => p.ChatMembers)
                .HasForeignKey(d => d.ChatId)
                .HasConstraintName("FK__chat_memb__chat___30C33EC3");

            entity.HasOne(d => d.User).WithMany(p => p.ChatMembers)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__chat_memb__user___2FCF1A8A");
        });

        modelBuilder.Entity<ChatTab>(entity =>
        {
            entity.HasKey(e => e.ChatId).HasName("PK__chat_tab__FD040B17FC05CB84");

            entity.ToTable("chat_tab");

            entity.Property(e => e.ChatId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("chat_id");
            entity.Property(e => e.DateCreated)
                .HasColumnType("datetime")
                .HasColumnName("date_created");
            entity.Property(e => e.Name)
                .HasMaxLength(75)
                .HasColumnName("name");
        });

        modelBuilder.Entity<ClickProduct>(entity =>
        {
            entity.HasKey(e => e.ClickRec).HasName("PK__click_pr__B01F5C9D55D53CC8");

            entity.ToTable("click_product");

            entity.Property(e => e.ClickRec).HasColumnName("click_rec");
            entity.Property(e => e.DateClick)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("date_click");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Product).WithMany(p => p.ClickProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__click_pro__produ__367C1819");

            entity.HasOne(d => d.User).WithMany(p => p.ClickProducts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__click_pro__user___37703C52");
        });

        //modelBuilder.Entity<GroupTb>(entity =>
        //{
        //    entity.HasKey(e => e.GroupTbId).HasName("PK__group_tb__81C6A4036BC0E1D2");

        //    entity.ToTable("group_tb");

        //    entity.Property(e => e.GroupTbId)
        //        .HasMaxLength(25)
        //        .IsUnicode(false)
        //        .HasColumnName("group_tb_id");
        //    entity.Property(e => e.Description)
        //        .HasMaxLength(1000)
        //        .HasColumnName("description");
        //    entity.Property(e => e.GroupTbName)
        //        .HasMaxLength(75)
        //        .HasColumnName("group_tb_name");
        //    entity.Property(e => e.GroupTbName2)
        //        .HasMaxLength(75)
        //        .HasColumnName("group_tb_name2");
        //    entity.Property(e => e.Status)
        //        .HasDefaultValue(true)
        //        .HasColumnName("status");
        //    entity.Property(e => e.Type).HasColumnName("type");
        //});

        modelBuilder.Entity<Invoice>(entity =>
        {
            entity.HasKey(e => e.InvoiceId).HasName("PK__invoice__F58DFD4936FDAED8");

            entity.ToTable("invoice");

            entity.Property(e => e.InvoiceId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("invoice_id");
            entity.Property(e => e.Amount)
                .HasColumnType("money")
                .HasColumnName("amount");
            entity.Property(e => e.AmountPayable)
                .HasColumnType("money")
                .HasColumnName("amount_payable");
            entity.Property(e => e.Balanced)
                .HasColumnType("money")
                .HasColumnName("balanced");
            entity.Property(e => e.Cost)
                .HasColumnType("money")
                .HasColumnName("cost");
            entity.Property(e => e.DateCreated).HasColumnName("date_created");
            entity.Property(e => e.DatePayment).HasColumnName("date_payment");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.Method)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("method");
            entity.Property(e => e.OrderId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("order_id");
            entity.Property(e => e.Payment)
                .HasColumnType("money")
                .HasColumnName("payment");
            entity.Property(e => e.Promotion)
                .HasColumnType("money")
                .HasColumnName("promotion");
            entity.Property(e => e.ShipAmount)
                .HasColumnType("money")
                .HasColumnName("ship_amount");
            entity.Property(e => e.Status)
                .HasDefaultValue(1)
                .HasColumnName("status");
            entity.Property(e => e.TaxAmount)
                .HasColumnType("money")
                .HasColumnName("tax_amount");

            entity.HasOne(d => d.MethodNavigation).WithMany(p => p.Invoices)
                .HasForeignKey(d => d.Method)
                .HasConstraintName("FK__invoice__method__0D7A0286");

            entity.HasOne(d => d.Order).WithMany(p => p.Invoices)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__invoice__order_i__0C85DE4D");
        });

        modelBuilder.Entity<LogHisory>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("log_hisory");

            entity.Property(e => e.DateLog)
                .HasColumnType("datetime")
                .HasColumnName("date_log");
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("IP");
            entity.Property(e => e.Status).HasColumnName("status");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany()
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__log_hisor__user___17036CC0");
        });

        modelBuilder.Entity<OrderD>(entity =>
        {
            entity.HasKey(e => new { e.OrderId, e.ProductId, e.PiId }).HasName("PK__order_d__932A3F77A9D137E7");

            entity.ToTable("order_d");

            entity.Property(e => e.OrderId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("order_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.PiId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("pi_id");
            entity.Property(e => e.Cost)
                .HasColumnType("money")
                .HasColumnName("cost");
            entity.Property(e => e.Price)
                .HasColumnType("money")
                .HasColumnName("price");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.Tax)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("tax");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDs)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__order_d__order_i__02FC7413");

            entity.HasOne(d => d.Pi).WithMany(p => p.OrderDs)
                .HasForeignKey(d => d.PiId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__order_d__pi_id__05D8E0BE");

            entity.HasOne(d => d.Product).WithMany(p => p.OrderDs)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__order_d__product__03F0984C");

            entity.HasOne(d => d.TaxNavigation).WithMany(p => p.OrderDs)
                .HasForeignKey(d => d.Tax)
                .HasConstraintName("FK__order_d__tax__04E4BC85");
        });

        modelBuilder.Entity<OrderTb>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__order_tb__465962293B200504");

            entity.ToTable("order_tb");

            entity.Property(e => e.OrderId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("order_id");
            entity.Property(e => e.Buyer).HasColumnName("buyer");
            entity.Property(e => e.DateCreated).HasColumnName("date_created");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.ProDiscount)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("pro_discount");
            entity.Property(e => e.ProNew)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("pro_new");
            entity.Property(e => e.ProSaleoff)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("pro_saleoff");
            entity.Property(e => e.ProShip)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("pro_ship");
            entity.Property(e => e.Seller).HasColumnName("seller");
            entity.Property(e => e.Status)
                .HasDefaultValue(0)
                .HasColumnName("status");

            entity.HasOne(d => d.ProDiscountNavigation).WithMany(p => p.OrderTbProDiscountNavigations)
                .HasForeignKey(d => d.ProDiscount)
                .HasConstraintName("FK__order_tb__pro_di__7C4F7684");

            entity.HasOne(d => d.ProNewNavigation).WithMany(p => p.OrderTbProNewNavigations)
                .HasForeignKey(d => d.ProNew)
                .HasConstraintName("FK__order_tb__pro_ne__7A672E12");

            entity.HasOne(d => d.ProSaleoffNavigation).WithMany(p => p.OrderTbProSaleoffNavigations)
                .HasForeignKey(d => d.ProSaleoff)
                .HasConstraintName("FK__order_tb__pro_sa__7B5B524B");

            entity.HasOne(d => d.ProShipNavigation).WithMany(p => p.OrderTbProShipNavigations)
                .HasForeignKey(d => d.ProShip)
                .HasConstraintName("FK__order_tb__pro_sh__797309D9");
        });

        modelBuilder.Entity<PaymentMethod>(entity =>
        {
            entity.HasKey(e => e.MethodId).HasName("PK__payment___747727B69274D484");

            entity.ToTable("payment_method");

            entity.Property(e => e.MethodId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("method_id");
            entity.Property(e => e.Bank)
                .HasMaxLength(100)
                .HasColumnName("bank");
            entity.Property(e => e.DateCreated)
                .HasColumnType("datetime")
                .HasColumnName("date_created");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.FeeRate).HasColumnName("fee_rate");
            entity.Property(e => e.LogoUrl)
                .HasMaxLength(200)
                .HasColumnName("logo_url");
            entity.Property(e => e.Name)
                .HasMaxLength(75)
                .HasColumnName("name");
            entity.Property(e => e.NameAccount)
                .HasMaxLength(75)
                .HasColumnName("name_account");
            entity.Property(e => e.NumAccount).HasColumnName("num_account");
            entity.Property(e => e.Refund).HasColumnName("refund");
            entity.Property(e => e.Sort).HasColumnName("sort");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
            entity.Property(e => e.Type).HasColumnName("type");
            entity.Property(e => e.Url)
                .HasMaxLength(200)
                .HasColumnName("url");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__product__47027DF54E73B668");

            entity.ToTable("product");

            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.BrandId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("brand_id");
            entity.Property(e => e.CategoryId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("category_id");
            entity.Property(e => e.DateApply1)
                .HasColumnType("datetime")
                .HasColumnName("date_apply1");
            entity.Property(e => e.DateApply2)
                .HasColumnType("datetime")
                .HasColumnName("date_apply2");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            //entity.Property(e => e.GroupTb1)
            //    .HasMaxLength(25)
            //    .IsUnicode(false)
            //    .HasColumnName("group_tb_1");
            //entity.Property(e => e.GroupTb2)
            //    .HasMaxLength(25)
            //    .IsUnicode(false)
            //    .HasColumnName("group_tb_2");
            //entity.Property(e => e.GroupTb3)
            //    .HasMaxLength(25)
            //    .IsUnicode(false)
            //    .HasColumnName("group_tb_3");
            //entity.Property(e => e.GroupTb4)
            //    .HasMaxLength(25)
            //    .IsUnicode(false)
            //    .HasColumnName("group_tb_4");
            entity.Property(e => e.Name)
                .HasMaxLength(75)
                .HasColumnName("name");
            entity.Property(e => e.Name2)
                .HasMaxLength(75)
                .HasColumnName("name2");
            entity.Property(e => e.Price1)
                .HasColumnType("money")
                .HasColumnName("price1");
            entity.Property(e => e.Price2)
                .HasColumnType("money")
                .HasColumnName("price2");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
            entity.Property(e => e.Uom)
                .HasMaxLength(20)
                .HasColumnName("uom");
            entity.Property(e => e.UrlImage1)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("url_image1");
            entity.Property(e => e.UrlImage2)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("url_image2");
            entity.Property(e => e.UrlImage3)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("url_image3");
            entity.Property(e => e.UserId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("user_id");

            entity.HasOne(d => d.Brand).WithMany(p => p.Products)
                .HasForeignKey(d => d.BrandId)
                .HasConstraintName("FK__product__brand_i__6754599E");

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__product__categor__628FA481");

            //entity.HasOne(d => d.GroupTb1Navigation).WithMany(p => p.ProductGroupTb1Navigations)
            //    .HasForeignKey(d => d.GroupTb1)
            //    .HasConstraintName("FK__product__group_t__6383C8BA");

            //entity.HasOne(d => d.GroupTb2Navigation).WithMany(p => p.ProductGroupTb2Navigations)
            //    .HasForeignKey(d => d.GroupTb2)
            //    .HasConstraintName("FK__product__group_t__6477ECF3");

            //entity.HasOne(d => d.GroupTb3Navigation).WithMany(p => p.ProductGroupTb3Navigations)
            //    .HasForeignKey(d => d.GroupTb3)
            //    .HasConstraintName("FK__product__group_t__656C112C");

            //entity.HasOne(d => d.GroupTb4Navigation).WithMany(p => p.ProductGroupTb4Navigations)
            //    .HasForeignKey(d => d.GroupTb4)
            //    .HasConstraintName("FK__product__group_t__66603565");
        });

        modelBuilder.Entity<ProductIn>(entity =>
        {
            entity.HasKey(e => e.PiId).HasName("PK__product___037A8190ED8EF4B7");

            entity.ToTable("product_in");

            entity.Property(e => e.PiId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("pi_id");
            entity.Property(e => e.Cost)
                .HasColumnType("money")
                .HasColumnName("cost");
            entity.Property(e => e.DateCreated)
                .HasColumnType("datetime")
                .HasColumnName("date_created");
            entity.Property(e => e.DateEnd)
                .HasColumnType("datetime")
                .HasColumnName("date_end");
            entity.Property(e => e.DateStart)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("date_start");
            entity.Property(e => e.Name)
                .HasMaxLength(75)
                .HasColumnName("name");
            entity.Property(e => e.Name2)
                .HasMaxLength(75)
                .HasColumnName("name2");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductIns)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__product_i__produ__6B24EA82");
        });

        modelBuilder.Entity<Promotion>(entity =>
        {
            entity.HasKey(e => e.PromotionId).HasName("PK__promotio__2CB9556BFB9340B1");

            entity.ToTable("promotion");

            entity.Property(e => e.PromotionId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("promotion_id");
            entity.Property(e => e.Calculate).HasColumnName("calculate");
            entity.Property(e => e.DateCreated).HasColumnName("date_created");
            entity.Property(e => e.DateEnd).HasColumnName("date_end");
            entity.Property(e => e.DateStart).HasColumnName("date_start");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.GroupTbCond)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("group_tb_cond");
            entity.Property(e => e.OderTbCond).HasColumnName("oder_tb_cond");
            entity.Property(e => e.PromotionName)
                .HasMaxLength(75)
                .HasColumnName("promotion_name");
            entity.Property(e => e.PromotionName2)
                .HasMaxLength(75)
                .HasColumnName("promotion_name2");
            entity.Property(e => e.QuanCond).HasColumnName("quan_cond");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.RankCond).HasColumnName("rank_cond");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
            entity.Property(e => e.Type).HasColumnName("type");
            entity.Property(e => e.ValCond)
                .HasColumnType("money")
                .HasColumnName("val_cond");
            entity.Property(e => e.Value)
                .HasColumnType("numeric(18, 0)")
                .HasColumnName("value");
        });

        modelBuilder.Entity<PromotionProduct>(entity =>
        {
            entity.HasKey(e => new { e.PromotionId, e.ProductId }).HasName("PK__promotio__68C972B471C15ACA");

            entity.ToTable("promotion_product");

            entity.Property(e => e.PromotionId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("promotion_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");

            entity.HasOne(d => d.Product).WithMany(p => p.PromotionProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__promotion__produ__72C60C4A");

            entity.HasOne(d => d.Promotion).WithMany(p => p.PromotionProducts)
                .HasForeignKey(d => d.PromotionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__promotion__promo__71D1E811");
        });
        modelBuilder.Entity<ShipmentD>().HasKey(sd => new { sd.ShipmentId, sd.ProductId, sd.OrderId });
        
        modelBuilder.Entity<Rating>(entity =>
        {
            entity.HasKey(e => new { e.ProductId, e.UserId }).HasName("PK__rating__AC999E85313AA859");

            entity.ToTable("rating");

            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.DateCreated).HasColumnName("date_created");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.Rate).HasColumnName("rate");

            entity.HasOne(d => d.Product).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__rating__product___14270015");

            entity.HasOne(d => d.User).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__rating__user_id__151B244E");
        });

        modelBuilder.Entity<Shipment>(entity =>
        {
            entity.HasKey(e => e.ShipmentId).HasName("PK__shipment__41466E59A21D7763");

            entity.ToTable("shipment");

            entity.Property(e => e.ShipmentId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("shipment_id");
            entity.Property(e => e.AddressId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("address_id");
            entity.Property(e => e.DateActualDeli)
                .HasColumnType("datetime")
                .HasColumnName("date_actual_deli");
            entity.Property(e => e.DateCreated)
                .HasColumnType("datetime")
                .HasColumnName("date_created");
            entity.Property(e => e.DateEstDeli)
                .HasColumnType("datetime")
                .HasColumnName("date_est_deli");
            entity.Property(e => e.DateReceipt)
                .HasColumnType("datetime")
                .HasColumnName("date_receipt");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.NameReceive)
                .HasMaxLength(75)
                .HasColumnName("name_receive");
            entity.Property(e => e.OrderId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("order_id");
            entity.Property(e => e.Phone1)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone1");
            entity.Property(e => e.Phone2)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone2");
            entity.Property(e => e.PhoneReceive)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone_receive");
            entity.Property(e => e.Shipper1Id)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("shipper1_id");
            entity.Property(e => e.Shipper1Name)
                .HasMaxLength(75)
                .HasColumnName("shipper1_name");
            entity.Property(e => e.Shipper2Id)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("shipper2_id");
            entity.Property(e => e.Shipper2Name)
                .HasMaxLength(75)
                .HasColumnName("shipper2_name");
            entity.Property(e => e.Status)
                .HasDefaultValue(0)
                .HasColumnName("status");

            entity.HasOne(d => d.Address).WithMany(p => p.Shipments)
                .HasForeignKey(d => d.AddressId)
                .HasConstraintName("FK__shipment__addres__208CD6FA");

            entity.HasOne(d => d.Order).WithMany(p => p.Shipments)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__shipment__order___1F98B2C1");
        });

        modelBuilder.Entity<ShipmentD>(entity =>
        {
            entity.HasKey(e => new { e.ShipmentId, e.ProductId, e.OrderId }).HasName("PK__shipment__2D7010E4057E0A06");

            entity.ToTable("shipment_d");

            entity.Property(e => e.ShipmentId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("shipment_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.OrderId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("order_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.Order).WithMany(p => p.ShipmentDs)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__shipment___order__25518C17");

            entity.HasOne(d => d.Product).WithMany(p => p.ShipmentDs)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__shipment___produ__245D67DE");

            entity.HasOne(d => d.Shipment).WithMany(p => p.ShipmentDs)
                .HasForeignKey(d => d.ShipmentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__shipment___shipm__236943A5");
        });

        modelBuilder.Entity<Support>(entity =>
        {
            entity.HasKey(e => e.SupportId).HasName("PK__support__2FBE20903940B77F");

            entity.ToTable("support");

            entity.Property(e => e.SupportId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("support_id");
            entity.Property(e => e.Answer)
                .HasMaxLength(1000)
                .HasColumnName("answer");
            entity.Property(e => e.Ask)
                .HasMaxLength(1000)
                .HasColumnName("ask");
            entity.Property(e => e.DateAnswer)
                .HasColumnType("datetime")
                .HasColumnName("date_answer");
            entity.Property(e => e.DateAsk)
                .HasColumnType("datetime")
                .HasColumnName("date_ask");
            entity.Property(e => e.OrderId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("order_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.SupportIn)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("support_in");
            entity.Property(e => e.UserAnswer).HasColumnName("user_answer");
            entity.Property(e => e.UserAsk).HasColumnName("user_ask");

            entity.HasOne(d => d.Order).WithMany(p => p.Supports)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__support__order_i__2A164134");

            entity.HasOne(d => d.Product).WithMany(p => p.Supports)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__support__product__29221CFB");

            entity.HasOne(d => d.UserAnswerNavigation).WithMany(p => p.SupportUserAnswerNavigations)
                .HasForeignKey(d => d.UserAnswer)
                .HasConstraintName("FK__support__user_an__2B0A656D");

            entity.HasOne(d => d.UserAskNavigation).WithMany(p => p.SupportUserAskNavigations)
                .HasForeignKey(d => d.UserAsk)
                .HasConstraintName("FK__support__user_as__282DF8C2");
        });

        modelBuilder.Entity<Tax>(entity =>
        {
            entity.HasKey(e => e.TaxId).HasName("PK__tax__129B86703D89F723");

            entity.ToTable("tax");

            entity.Property(e => e.TaxId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("tax_id");
            entity.Property(e => e.DateCreated).HasColumnName("date_created");
            entity.Property(e => e.DateEnd).HasColumnName("date_end");
            entity.Property(e => e.DateStart).HasColumnName("date_start");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .HasColumnName("description");
            entity.Property(e => e.GroupTbCond)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("group_tb_cond");
            entity.Property(e => e.QuanCond).HasColumnName("quan_cond");
            entity.Property(e => e.RankCond).HasColumnName("rank_cond");
            entity.Property(e => e.Rate)
                .HasColumnType("numeric(18, 0)")
                .HasColumnName("rate");
            entity.Property(e => e.SeqNum).HasColumnName("seq_num");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
            entity.Property(e => e.TaxName)
                .HasMaxLength(75)
                .HasColumnName("tax_name");
            entity.Property(e => e.TaxName2)
                .HasMaxLength(75)
                .HasColumnName("tax_name2");
            entity.Property(e => e.ValCond)
                .HasColumnType("money")
                .HasColumnName("val_cond");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__user_tb__B9BE370F98FAC416");

            entity.ToTable("user_tb");

            entity.HasIndex(e => e.UserName, "UQ__user_tb__7C9273C41DB7A602").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.IsAdmin)
                .HasDefaultValue(false)
                .HasColumnName("admin");
            entity.Property(e => e.IsBanned)
                .HasDefaultValue(false)
                .HasColumnName("ban");
            entity.Property(e => e.IsBuyer)
                .HasDefaultValue(true)
                .HasColumnName("buyer");
            entity.Property(e => e.DateCreated)
                .HasDefaultValueSql("(getdate())")
                .HasColumnName("date_created");
            entity.Property(e => e.IsFrozen)
                .HasDefaultValue(false)
                .HasColumnName("freeze");
            entity.Property(e => e.IsNotify)
                .HasDefaultValue(false)
                .HasColumnName("notify");
            //entity.Property(e => e.
            //)
            //    .HasMaxLength(50)
            //    .IsUnicode(false)
             //   .HasColumnName("phong_ban");
            entity.Property(e => e.Password)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("password");
            entity.Property(e => e.Rank)
                .HasDefaultValue(0)
                .HasColumnName("rank");
            entity.Property(e => e.IsSeller)
                .HasDefaultValue(false)
                .HasColumnName("seller");
            entity.Property(e => e.Status)
                .HasDefaultValue(true)
                .HasColumnName("status");
            entity.Property(e => e.UserName)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("user_name");
        });

        modelBuilder.Entity<UserDetails>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__user_tb2__B9BE370F5A37FF4E");

            entity.ToTable("user_tb2");

            entity.Property(e => e.UserId)
                .ValueGeneratedNever()
                .HasColumnName("user_id");
            entity.Property(e => e.Address)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.Birthday).HasColumnName("birthday");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .HasColumnName("email");
            entity.Property(e => e.LogoUrl).HasColumnName("logo_url");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .HasColumnName("name");
            entity.Property(e => e.Name2)
                .HasMaxLength(50)
                .HasColumnName("name2");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone_number");
            entity.Property(e => e.SocialUrl1)
                .HasMaxLength(300)
                .HasColumnName("social_url1");
            entity.Property(e => e.SocialUrl2)
                .HasMaxLength(300)
                .HasColumnName("social_url2");
            entity.Property(e => e.SocialUrl3)
                .HasMaxLength(300)
                .HasColumnName("social_url3");

            entity.HasOne(d => d.User).WithOne(p => p.UserDetails)
                .HasForeignKey<UserDetails>(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__user_tb2__user_i__5629CD9C");
        });

        modelBuilder.Entity<Wishlist>(entity =>
        {
            entity.HasKey(e => new { e.UserId, e.ProductId }).HasName("PK__wishlist__FDCE10D00774EBD8");

            entity.ToTable("wishlist");

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.ProductId)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_id");
            entity.Property(e => e.ProductDescription)
                .HasMaxLength(1000)
                .HasColumnName("product_description");
            entity.Property(e => e.ProductName)
                .HasMaxLength(25)
                .IsUnicode(false)
                .HasColumnName("product_name");

            entity.HasOne(d => d.Product).WithMany(p => p.Wishlists)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__wishlist__produc__114A936A");

            entity.HasOne(d => d.User).WithMany(p => p.Wishlists)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__wishlist__user_i__10566F31");
        });

        OnModelCreatingPartial(modelBuilder);
    }
    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

