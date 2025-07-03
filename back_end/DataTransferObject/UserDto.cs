using back_end.Models.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace back_end.DataTransferObject
{
    public class UserDto
    {
        // Thông tin lưu vào bảng user
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool IsAdmin { get; set; }
        public bool IsBuyer { get; set; }
        public bool IsSeller { get; set; }
        
        public bool Status { get; set; } = true;


        // Thông tin lưu vào bảng user_details
        public string Name { get; set; }
        public DateTime? Birthday { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
    }

    public class RegisterDto
    {
        // Thêm các phần tử địa chỉ

        public string City { get; set; }


        public string District { get; set; }


        public string Ward { get; set; }


        public string Street { get; set; }


        public string Detail { get; set; }

        [Required(ErrorMessage = "Họ và tên không được để trống.")]
        [StringLength(50, ErrorMessage = "Tên tối đa 50 ký tự.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Ngày sinh không được để trống.")]
        [DataType(DataType.Date)]
        [DateNotInFuture(ErrorMessage = "Ngày sinh không hợp lệ.")]
        public DateTime? Birthday { get; set; }

        [Required(ErrorMessage = "Số điện thoại không được để trống.")]
        [StringLength(10, MinimumLength = 10, ErrorMessage = "Số điện thoại phải đúng 10 số.")]
        [RegularExpression(@"^0\d{9}$", ErrorMessage = "Số điện thoại không hợp lệ.")]
        public string PhoneNumber { get; set; }

        [Required(ErrorMessage = "Địa chỉ không được để trống.")]
        [StringLength(200, ErrorMessage = "Địa chỉ tối đa 200 ký tự.")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Email không được để trống.")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Mật khẩu không được để trống.")]
        [StringLength(50, MinimumLength = 8, ErrorMessage = "Mật khẩu có ít nhất 8 ký tự.")]
        public string Password { get; set; }
    }

    public class LoginDto
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }

    public class UpdateInfoDto
    {
        public string Name { get; set; }
        public DateTime? Birthday { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
    }

}
