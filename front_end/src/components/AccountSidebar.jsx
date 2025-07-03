// src/components/AccountSidebar.jsx
import React from 'react';
import { FaUser, FaMapMarkerAlt, FaClipboardList, FaSignOutAlt } from 'react-icons/fa';
import { NavLink, useNavigate } from 'react-router-dom';
import './AccountSidebar.css';

const AccountSidebar = () => {
  const navigate = useNavigate();

  const handleLogout = () => {
  localStorage.clear(); 
  navigate('/login', { replace: true });
};
  return (
    <div className="profile-sidebar">
      <h2>Tài khoản của tôi</h2>
      <ul>
        <li>
          <NavLink to="/account" className={({ isActive }) => isActive ? 'active' : ''}>
            <FaUser className="sidebar-icon" /> Thông tin cá nhân
          </NavLink>
        </li>
        <li>
          <NavLink 
          to="/address" 
          state={{
            name: JSON.parse(localStorage.getItem("user"))?.name || '',
            phone: JSON.parse(localStorage.getItem("user"))?.phone || ''
          }} 
          className={({ isActive }) => isActive ? 'active' : ''}
        >
          <FaMapMarkerAlt className="sidebar-icon" /> Địa chỉ 
        </NavLink>
        </li>
        <li>
          <NavLink to="/orderHistory" className={({ isActive }) => isActive ? 'active' : ''}>
            <FaClipboardList className="sidebar-icon" /> Lịch sử mua hàng
          </NavLink>
        </li>
        <li>
          <div onClick={handleLogout} className="logout-link">
          <FaSignOutAlt className="sidebar-icon" /> Đăng xuất
        </div>

        </li>
      </ul>
    </div>
  );
};

export default AccountSidebar;
