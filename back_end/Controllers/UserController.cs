using System.ComponentModel.DataAnnotations;
using back_end.DataTransferObject;
using back_end.Models;
using back_end.Models.Entity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace back_end.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly WebCodeContext _context;

        public UserController(WebCodeContext context)
        {
            _context = context;
        }
        //USER
        [HttpPost("register")]
        public IActionResult Register([FromBody] RegisterDto dto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                if (_context.Users.Any(u => u.UserName == dto.Name))
                    return BadRequest(new { message = "Tên đăng nhập đã tồn tại." });

                if (_context.UserDetails.Any(d => d.Email == dto.Email))
                    return BadRequest(new { message = "Email đã tồn tại." });

                var user = new User
                {
                    UserName = dto.Name,
                    Password = dto.Password,
                    IsBuyer = true,   
                    IsSeller = false,
                    IsAdmin = false,
                    DateCreated = DateOnly.FromDateTime(DateTime.Now)
                };
                _context.Users.Add(user);
                _context.SaveChanges();

                var address = new Address
                {
                    AddressId = $"addr{user.UserId}_1",
                    City = dto.City,
                    District = dto.District,
                    Ward = dto.Ward,
                    Street = dto.Street,
                    Detail = dto.Detail,
                    UserId = user.UserId,
                    Status = true
                };
                _context.Addresses.Add(address);
                string formattedAddress = $"{dto.Detail}, {dto.Street}, {dto.Ward}, {dto.District}, {dto.City}";


                var details = new UserDetails
                {
                    UserId = user.UserId,
                    Name = dto.Name,
                    Birthday = dto.Birthday.HasValue ? DateOnly.FromDateTime(dto.Birthday.Value) : null,
                    PhoneNumber = dto.PhoneNumber,
                    Address = dto.Address,
                    Email = dto.Email
                };
                _context.UserDetails.Add(details);
                _context.SaveChanges();

                return Ok(new { message = "Đăng ký thành công", userId = user.UserId });
            }
            catch (DbUpdateException dbEx)
            {
                return StatusCode(500, new { message = "Lỗi database: " + dbEx.InnerException?.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi không xác định: " + ex.Message });
            }
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginDto dto)
        {
            try
            {
                var user = _context.Users
                    .Include(u => u.UserDetails)
                    .FirstOrDefault(u => u.UserDetails.Email == dto.Email && u.Password == dto.Password);

                if (user == null)
                    return Unauthorized("Email hoặc mật khẩu không chính xác.");

                return Ok(new
                {
                    message = "Đăng nhập thành công",
                    user.UserId,
                    user.UserDetails.Name,
                    user.UserDetails.Email,
                    isAdmin = user.IsAdmin
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }
        //Get của user

        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserById(int id)
        {
            var user = await _context.Users
                .Include(u => u.UserDetails)         // navigation property trên User
                .FirstOrDefaultAsync(u => u.UserId == id);

            if (user == null)
                return NotFound(new { message = $"Không tìm thấy user với ID = {id}" });

            // 2) Trả về các trường từ UserDetails và Buyer/Seller flags
            return Ok(new
            {
                name     = user.UserDetails.Name,
                email    = user.UserDetails.Email,
                phone    = user.UserDetails.PhoneNumber,
                birthday = user.UserDetails.Birthday.HasValue 
                            ? user.UserDetails.Birthday.Value.ToString("yyyy-MM-dd") 
                            : null,
                address  = user.UserDetails.Address,

                buyer    = user.IsBuyer,   // flag Buyer
                seller   = user.IsSeller   // flag Seller
            });
        }

        [HttpPut("{id}")]
        public IActionResult UpdateUser(int id, [FromBody] UpdateInfoDto dto)
        {
            var user = _context.Users
                .Include(u => u.UserDetails)
                .FirstOrDefault(u => u.UserId == id);
            if (user == null) return NotFound();

            user.UserDetails.Name = dto.Name;
            user.UserDetails.Birthday = dto.Birthday.HasValue ? DateOnly.FromDateTime(dto.Birthday.Value) : null;
            user.UserDetails.PhoneNumber = dto.PhoneNumber;
            user.UserDetails.Address = dto.Address;
            _context.SaveChanges();

            return Ok(new { message = "Cập nhật thành công" });
        }


        //CỦA ADMIN????
        [HttpGet("get/{userId}")]
        public IActionResult GetUser(int userId)
        {
            var user = _context.Users.Find(userId);
            if (user == null) return NotFound();

            var userDetails = _context.UserDetails.FirstOrDefault(u => u.UserId == userId);
            var userDto = new UserDto
            {
                UserName = user.UserName,
                Password = user.Password,
                IsAdmin = user.IsAdmin,
                IsBuyer = user.IsBuyer,
                IsSeller = user.IsSeller,

                Name = userDetails?.Name ?? string.Empty,
                Birthday = userDetails?.Birthday?.ToDateTime(TimeOnly.MinValue),
                Email = userDetails?.Email ?? string.Empty,
                PhoneNumber = userDetails?.PhoneNumber ?? string.Empty,
                Address = userDetails?.Address ?? string.Empty,
            };
            return Ok(userDto);
        }

        [HttpPost("search")]
        public IActionResult SearchUsers([FromBody] UserQuery query)
        {
            var queryResult = _context.Users.Include(u => u.UserDetails).OrderByDescending(u => u.UserId).AsQueryable();
            if (query.Status != null)
            {
                queryResult = queryResult.Where(u => u.Status == query.Status);
            }
            if (!string.IsNullOrWhiteSpace(query.SearchContent))
            {
                queryResult = queryResult.Where(u => u.UserName.ToLower().Contains(query.SearchContent.ToLower()));
            }
            var result = queryResult.ToList().Select(u => new UserDto
            {
                UserId = u.UserId,
                UserName = u.UserName,
                Password = u.Password,
                IsAdmin = u.IsAdmin,
                IsBuyer = u.IsBuyer,
                IsSeller = u.IsSeller,
                //Department = u.Department,
                Name = u.UserDetails?.Name ?? string.Empty,
                Birthday = u.UserDetails?.Birthday?.ToDateTime(TimeOnly.MinValue),
                Email = u.UserDetails?.Email ?? string.Empty,
                PhoneNumber = u.UserDetails?.PhoneNumber ?? string.Empty,
                Address = u.UserDetails?.Address ?? string.Empty
            }).ToList();

            return Ok(result);
        }

        // Cập nhật hoặc tạo mới người dùng
        [HttpPost("upsert")]
        public IActionResult UpsertUser([FromBody] UserDto dto)
        {
            try
            {
                if (dto == null || string.IsNullOrEmpty(dto.UserName) || string.IsNullOrEmpty(dto.Password))
                    return BadRequest("Invalid user data.");
                // Kiểm tra email trùng lặp
                if (!string.IsNullOrEmpty(dto.Email))
                {
                    var existingUserWithEmail = _context.UserDetails
                        .Where(ud => ud.Email == dto.Email && ud.UserId != dto.UserId)
                        .FirstOrDefault();

                    if (existingUserWithEmail != null)
                        return BadRequest("Email đã được sử dụng bởi user khác.");
                }

                if (dto.UserId == 0)
                {
                    var newUser = new User
                    {
                        UserName = dto.UserName,
                        Password = dto.Password,
                        IsAdmin = dto.IsAdmin,
                        IsBuyer = dto.IsBuyer,
                        IsSeller = dto.IsSeller,
                        DateCreated = DateOnly.FromDateTime(DateTime.Now)
                    };
                    _context.Users.Add(newUser);
                    _context.SaveChanges();

                    var userDetails = new UserDetails
                    {
                        UserId = newUser.UserId,
                        Name = dto.Name,
                        Birthday = dto.Birthday.HasValue? DateOnly.FromDateTime(dto.Birthday.Value) : (DateOnly?)null,
                        PhoneNumber = dto.PhoneNumber,
                        Address = dto.Address,
                        Email = dto.Email
                    };
                    _context.UserDetails.Add(userDetails);
                    _context.SaveChanges();
                    return Ok($"Tạo user thành công {newUser.UserId}");
                }

                var user = _context.Users.Find(dto.UserId);
                user.UserName = dto.UserName;
                user.Password = dto.Password;
                user.IsAdmin = dto.IsAdmin;
                user.IsBuyer = dto.IsBuyer;
                user.IsSeller = dto.IsSeller;
                _context.Users.Update(user);
                _context.SaveChanges();

                var userDetail = _context.UserDetails.FirstOrDefault(u => u.UserId == dto.UserId);
                if (userDetail != null)
                {
                    userDetail.Address = dto.Address;
                    userDetail.Birthday = dto.Birthday.HasValue? DateOnly.FromDateTime(dto.Birthday.Value) : (DateOnly?)null;
                    userDetail.Email = dto.Email;
                    userDetail.Name = dto.Name;
                    userDetail.PhoneNumber = dto.PhoneNumber;
                    _context.UserDetails.Update(userDetail);
                    _context.SaveChanges();
                }

                return Ok($"Update user thành công {user.UserId}");
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, $"Lỗi khi cập nhật user: {ex.Message}");
            }
        }


        // Xóa người dùng
        [HttpDelete("delete/{userId}")]
        public IActionResult DeleteUser(string userId)
        {
            try
            {
                if (!int.TryParse(userId, out int parseId))
                    return BadRequest("UserId không hợp lệ.");

                // Lấy tất cả address của user
                var addresses = _context.Addresses.Where(a => a.UserId == parseId).ToList();
                var addressIds = addresses.Select(a => a.AddressId).ToList();

                // Kiểm tra xem có đơn hàng (shipment) nào liên quan đến các địa chỉ này không
                bool hasShipments = _context.Shipments.Any(s => addressIds.Contains(s.AddressId));
                if (hasShipments)
                {
                    return BadRequest("Không thể xóa user vì còn đơn hàng liên quan đến địa chỉ của user này.");
                }

                // Nếu không có đơn hàng, xóa các địa chỉ
                if (addresses.Any())
                    _context.Addresses.RemoveRange(addresses);

                // Xóa UserDetails nếu có
                var userDetails = _context.UserDetails.FirstOrDefault(u => u.UserId == parseId);
                if (userDetails != null)
                    _context.UserDetails.Remove(userDetails);

                // Xóa User
                var user = _context.Users.Find(parseId);
                if (user == null)
                    return NotFound($"User với ID {userId} không tồn tại.");

                _context.Users.Remove(user);

                _context.SaveChanges();

                return Ok($"User với ID {userId} đã được xóa thành công.");
            }
            catch (DbUpdateException dbEx)
            {
                var inner = dbEx.InnerException;
                var innerMessage = inner != null ? inner.Message : dbEx.Message;
                Console.WriteLine("Inner exception: " + innerMessage);
                return StatusCode(StatusCodes.Status500InternalServerError,
                    $"Lỗi khi xóa user: {innerMessage}");
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    $"Lỗi không xác định khi xóa user: {ex.Message}");
            }
        }




    }
}
