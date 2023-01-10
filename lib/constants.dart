import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xFF1876F2);
  static const Color greenColor = Color(0xFF42b72a);
  static const Color grayColor = Color(0xFF8D8D8D);
  static const Color secondaryColor = Color(0xFFE9EBEE);

  static const kPrimaryColor = Color(0xFF1979FF);
  static const kPrimaryLightColor = Color(0xFFE3F2FD);
  static const kPrimaryColorText = Color(0xFF1979FF);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const textColor = Color(0xFFFFFFFF);
  static const kColorTextNormal = Color(0xFF000000);
  static const kBlack = Color(0xFF000000);
  static const kColorButton = Color(0xFF757575);
  static const kBackgroundGrey = Color(0xFFe4e6eb);
  static const kGreenComment = Color(0xff00c853);
  static const kDanger = Color(0xffc62828);
}

const host = '192.168.110.254';
const baseUrl = "http://$host:5000/it4788";
const authUrl = '$baseUrl/auth';
const friendUrl = '$baseUrl/friend';
const postUrl = '$baseUrl/post';
const userUrl = '$baseUrl/user';
const sreachUrl = '$baseUrl/search';
const commentUrl = '$baseUrl/comment';
const likeUrl = '$baseUrl/like';
const settingUrl = '$baseUrl/setting';
const chatUrl = '$baseUrl/chat';

// ------ Error ------
const serviceError = 'Service Error';
const unauthorizedError = 'Unauthorized';
const somethingWentWrongError = 'Something went wrong';

const errorCode = {
  '9992': 'Bài viết không tồn tại',
  '9993': 'Mã xác thực không đúng',
  '9994': 'Không có dữ liệu hoặc không còn dữ liệu',
  '9995': 'Không có người dùng naỳ',
  '9996': 'Người dùng đã tồn tại',
  '9997': 'Phương thức không hợp lệ',
  '9998': 'Sai Token',
  '9999': 'Lỗi exception',
  '1001': 'Lỗi mất kết nối DB hoặc lỗi query',
  '1002': 'Số lượng tham số không đủ',
  '1003': 'Kiểu tham số không hợp lệ',
  '1004': 'Giá trị tham số không hợp lệ',
  '1005': 'Unknow error',
  '1006': 'Cỡ file vượt mức cho phép',
  '1007': 'Upload file thất bại',
  '1008': 'Số luợng image vượt mức cho phép',
  '1009': 'Không có quyền truy cập',
  '1010': 'Hành động đã được người dùng thực hiện trước đó',
  '1011': 'Bài đăng vi phạm tiêu chuẩn cộng đồng',
  '1012': 'Bài đăng bị giới hạn một số quốc gia',
};
