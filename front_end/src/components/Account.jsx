import React, { useState, useEffect } from 'react';
import './Account.css';
import axios from 'axios';
import AccountSidebar from './AccountSidebar';




const Account = () => {
  const [user, setUser] = useState({
    userId: '',
    name: '',
    birthday: '',
    address: '',
    phoneNumber: '',
    email: ''
  });


  const [isEditing, setIsEditing] = useState(false);


  const userId = localStorage.getItem('userId');


  const [phoneError, setPhoneError] = useState('');


    useEffect(() => {
    if (userId) {
        axios.get(`http://localhost:5166/api/User/${userId}`)
        .then(res => {
        const data = res.data;
        setUser({
          userId: userId,                
          name: data.name || '',
          birthday: data.birthday || '',
          address: data.address || '',
          phoneNumber: data.phone || '',  
          email: data.email || ''
        });
         if(data.address) {
          localStorage.setItem('defaultAddress', data.address);
        }
      })
      .catch(err => console.error(err));
  }
}, [userId]);




  const handleChange = (e) => {
  const { name, value } = e.target;


  // Kiểm tra độ dài số điện thoại
 if (name === "phoneNumber") {
  const isOnlyDigits = /^\d*$/.test(value); // Regex: chỉ cho phép số hoặc rỗng


  if (!isOnlyDigits) {
      setPhoneError("Số điện thoại không hợp lệ");
    } else if (value.length > 10) {
      setPhoneError("Số điện thoại không được vượt quá 10 chữ số.");
    } else {
      setPhoneError("");
      }
  }


  setUser({ ...user, [name]: value });
};




  const handleSave = () => {


    if (phoneError) {
    alert("Vui lòng sửa lỗi trước khi lưu.");
    return;
  }


    axios.put(`http://localhost:5166/api/User/${userId}`, user)


      .then(() => {
        alert("Cập nhật thành công!");
        setIsEditing(false);
      })
      .catch(() => alert("Lỗi cập nhật!"));
  };


  return (
    <div style={{ background: '#f8f8f8', minHeight: '100vh' }}>
    <h1 className="order-title-large">Thông tin cá nhân</h1>
    <div className="profile-container">
      <AccountSidebar />


      <div className="profile-main">
        <h2>Thông tin cá nhân</h2>


        <div className="form-group">
          <label>Mã tài khoản</label>
          <input value={user.userId} readOnly />
        </div>


        <div className="form-group">
          <label>Họ và tên</label>
          <input name="name" value={user.name} onChange={handleChange} readOnly={!isEditing} />
        </div>


        <div className="form-group">
          <label>Ngày sinh</label>
          <input name="birthday" type="date" value={user.birthday?.substring(0, 10)} onChange={handleChange} readOnly={!isEditing} />
        </div>


       <div className="form-group">
          <label>Địa chỉ</label>
          <input name="address" value={user.address} readOnly />
          <div>
            <a href="/Address" className="link-button">+ Thêm/ Sửa địa chỉ</a>
          </div>
        </div>






        <div className="form-group">
          <label>Số điện thoại</label>
          <input
            name="phoneNumber"
            value={user.phoneNumber}
            onChange={handleChange}
            readOnly={!isEditing}
          />
          {phoneError && <p className="error-message">{phoneError}</p>}
        </div>




        <div className="form-group">
          <label>Email</label>
          <input name="email" value={user.email} readOnly />
        </div>


        <div className="form-buttons">
          {!isEditing ? (
            <button onClick={() => setIsEditing(true)}>Chỉnh sửa</button>
          ) : (
            <button onClick={handleSave}>Lưu</button>
          )}
        </div>
      </div>
    </div>
    </div>
  );
};


export default Account;



