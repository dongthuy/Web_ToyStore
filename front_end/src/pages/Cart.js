import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Cart.css';
import { FaShoppingCart } from 'react-icons/fa';

const Cart = () => {
  const [items, setItems] = useState([]);
  const [total, setTotal] = useState(0);
  const [totalOriginal, setTotalOriginal] = useState(0);
  const navigate = useNavigate();

  useEffect(() => {
  const user = JSON.parse(localStorage.getItem('user'));
  if (!user) {
    navigate('/login');
    return;
  }

  loadCart();
  window.addEventListener("focus", loadCart);
  return () => window.removeEventListener("focus", loadCart);
}, []);

  const loadCart = async () => {
    let user = null;
    try {
      user = JSON.parse(localStorage.getItem('user'));
    } catch (e) {
      console.error("Lỗi đọc user:", e);
    }

    if (user?.userId) {
      try {
        const res = await axios.get(`http://localhost:5166/api/Cart?userId=${user.userId}`);
        setItems(res.data);

        const original = res.data.reduce((sum, i) => i.price1 * i.quantity + sum, 0);
        const actual = res.data.reduce((sum, i) => i.price * i.quantity + sum, 0);

        setTotalOriginal(original);
        setTotal(actual);
      } catch (err) {
        console.error("Lỗi tải giỏ hàng:", err);
      }
    } else {
      const stored = JSON.parse(localStorage.getItem('cartItems')) || [];
      setItems(stored);
      const original = stored.reduce((sum, i) => (i.price1 || i.price) * i.quantity + sum, 0);
      const actual = stored.reduce((sum, i) => i.price * i.quantity + sum, 0);
      setTotalOriginal(original);
      setTotal(actual);
    }
  };

  const handleQtyChange = async (productId, delta) => {
    const updated = items.map(i =>
      i.productId === productId
        ? { ...i, quantity: Math.max(1, i.quantity + delta) }
        : i
    );
    setItems(updated);
    setTotalOriginal(updated.reduce((s, i) => (i.price1 || i.price) * i.quantity + s, 0));
    setTotal(updated.reduce((s, i) => i.price * i.quantity + s, 0));

    const user = JSON.parse(localStorage.getItem('user'));
    if (user?.userId) {
      const target = updated.find(i => i.productId === productId);
      await axios.patch("http://localhost:5166/api/Cart/update", {
        userId: user.userId,
        productId,
        quantity: target.quantity
      });
    } else {
      localStorage.setItem('cartItems', JSON.stringify(updated));
    }
  };

  const handleRemove = async (productId) => {
    const updated = items.filter(i => i.productId !== productId);
    setItems(updated);
    setTotalOriginal(updated.reduce((s, i) => (i.price1 || i.price) * i.quantity + s, 0));
    setTotal(updated.reduce((s, i) => i.price * i.quantity + s, 0));

    const user = JSON.parse(localStorage.getItem('user'));
    if (user?.userId) {
      await axios.delete("http://localhost:5166/api/Cart/remove", {
        params: { userId: user.userId, productId }
      });
    } else {
      localStorage.setItem('cartItems', JSON.stringify(updated));
    }
  };

  const handleCheckout = () => {
    const user = JSON.parse(localStorage.getItem('user'));
    if (!user) {
      localStorage.setItem('redirectAfterLogin', '/checkout');
      navigate('/login');
    } else {
      navigate('/checkout');
    }
  };

  return (
    <div className="cart-page">
      <h2>Giỏ hàng của bạn</h2>
      {items.length === 0 ? (
        <div className="empty-order1">
          <FaShoppingCart className="empty-icon1" />
          <h3>Chưa có sản phẩm nào</h3>
          <p>Thêm sản phẩm để bắt đầu mua sắm</p>
        </div>
      ) : (
        <>
          <table className="cart-table">
            <thead>
              <tr>
                <th>Ảnh</th>
                <th>Sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {items.map(item => (
                <tr key={item.productId}>
                  <td><img src={item.urlImage} alt={item.productName} /></td>
                  <td>{item.productName}</td>
                  <td>
                    {item.price2 && item.price2 < item.price1 ? (
                      <>
                        <span style={{ color: '#e53935', fontWeight: 'bold' }}>
                          {item.price.toLocaleString('vi-VN')} ₫
                        </span><br />
                        <span style={{ textDecoration: 'line-through', color: '#888' }}>
                          {item.price1.toLocaleString('vi-VN')} ₫
                        </span>
                      </>
                    ) : (
                      <>{item.price.toLocaleString('vi-VN')} ₫</>
                    )}
                  </td>
                  <td>
                    <button onClick={() => handleQtyChange(item.productId, -1)}>-</button>
                    <span className="qty">{item.quantity}</span>
                    <button onClick={() => handleQtyChange(item.productId, 1)}>+</button>
                  </td>
                  <td>{(item.price * item.quantity).toLocaleString('vi-VN')} ₫</td>
                  <td><button onClick={() => handleRemove(item.productId)}>🗑</button></td>
                </tr>
              ))}
            </tbody>
          </table>

          <div style={{ marginTop: 30, textAlign: 'right' }}>
            <p style={{ fontSize: 16 }}>
              <strong>Tổng tiền gốc:</strong> {totalOriginal.toLocaleString('vi-VN')} ₫
            </p>
            <p style={{ fontSize: 16, color: '#2e7d32' }}>
              <strong>Tiết kiệm:</strong> {(totalOriginal - total).toLocaleString('vi-VN')} ₫
            </p>
            <h3 className="total-price">
              Tổng cộng: {total.toLocaleString('vi-VN')} ₫
            </h3>
          </div>

          <div className="cart-actions1">
            <button className="continue1-btn" onClick={() => navigate('/products')}>
              Tiếp tục mua sắm
            </button>
            <button className="checkout-btn" onClick={handleCheckout}>
              Thanh toán ngay
            </button>
          </div>
        </>
      )}
    </div>
  );
};

export default Cart;
