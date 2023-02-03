import 'package:fb_copy/models/auth_model.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

const host = '169.254.109.23';
const baseUrl = "http://$host:5000/it4788";
const authUrl = '$baseUrl/auth';
const friendUrl = '$baseUrl/friend';
const postUrl = '$baseUrl/post';
const userUrl = '$baseUrl/user';
const searchUrl = '$baseUrl/search';
const commentUrl = '$baseUrl/comment';
const likeUrl = '$baseUrl/like';
const settingUrl = '$baseUrl/setting';
const chatUrl = '$baseUrl/chat';

AuthModel? authUser;
String token = '';
List<PostModel> listPost = [];

Future<void> checkToken() async {
  if (token == '') {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    // create excpetion {code: 9998, message: 'Phiên đăng nhập bạn đã hết hạn vui lòng đăng nhập lại', details: 'Token is invalid'}
    if (token == '') {
      Logger().d('Token is invalid');
      throw Exception('Phiên đăng nhập bạn đã hết hạn vui lòng đăng nhập lại');
    }
  }
}

class AppColor {
  static const Color primaryColor = Color(0xFF1876F2);
  static const Color greenColor = Color(0xFF42b72a);
  static const Color grayColor = Color(0xFF8D8D8D);
  static const Color secondaryColor = Color(0xFFE9EBEE);
  static const Color kPrimaryColor = Color(0xFF1979FF);
  static const Color kPrimaryLightColor = Color(0xFFE3F2FD);
  static const Color kPrimaryColorText = Color(0xFF1979FF);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color kColorTextNormal = Color(0xFF000000);
  static const Color kBlack = Color(0xFF000000);
  static const Color kColorButton = Color(0xFF757575);
  static const Color kBackgroundGrey = Color(0xFFe4e6eb);
  static const Color kGreenComment = Color(0xff00c853);
  static const Color kDanger = Color(0xffc62828);
}

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
const postStatusArray = [
  'hạnh phúc',
  'có phúc',
  'được yêu',
  'buồn',
  'đáng yêu',
  'biết ơn',
  'hào hứng',
  'đang yêu',
  'điên',
  'cảm kích',
  'sung sướng',
  'tuyệt vời',
  'ngốc nghếch',
  'vui vẻ',
  'tuyệt vời',
  'thật phong cách',
  'thú vị',
  'thư giãn',
  'positive',
  'rùng mình',
  'đầy hi vọng',
  'hân hoan',
  'mệt mỏi',
  'có động lực',
  'proud',
  'chỉ có một mình',
  'chu đáo',
  'OK',
  'nhớ nhà',
  'giận dữ',
  'ốm yếu',
  'hài lòng',
  'kiệt sức',
  'xúc động',
  'tự tin',
  'rất tuyệt',
  'tươi mới',
  'quyết đoán',
  'kiệt sức',
  'bực mình',
  'vui vẻ',
  'gặp may',
  'đau khổ',
  'buồn tẻ',
  'buồn ngủ',
  'tràn đầy sinh lực',
  'đói',
  'chuyên nghiệp',
  'đau đớn',
  'thanh thản',
  'thất vọng',
  'lạc quan',
  'lạnh',
  'dễ thương',
  'tuyệt cú mèo',
  'thật tuyệt',
  'hối tiếc',
  'thật giỏi',
  'lo lắng',
  'vui nhộn',
  'tồi tệ',
  'xuống tinh thần',
  'đầy cảm hứng',
  'hài lòng',
  'phấn khích',
  'bình tĩnh',
  'bối rối',
  'goofy',
  'trống vắng',
  'tốt',
  'mỉa mai',
  'cô đơn',
  'mạnh mẽ',
  'lo lắng',
  'đặc biệt',
  'chán nản',
  'vui vẻ',
  'tò mò',
  'ủ dột',
  'được chào đón',
  'gục ngã',
  'xinh đẹp',
  'tuyệt vời',
  'cáu',
  'căng thẳng',
  'thiếu',
  'kích động',
  'tinh quái',
  'kinh ngạc',
  'tức giận',
  'buồn chán',
  'bối rồi',
  'mạnh mẽ',
  'phẫn nộ',
  'mới mẻ',
  'thành công',
  'ngạc nhiên',
  'bối rối',
  'nản lòng',
  'tẻ nhạt',
  'xinh xắn',
  'khá hơn',
  'tội lỗi',
  'an toàn',
  'tự do',
  'hoang mang',
  'già nua',
  'lười biếng',
  'tồi tệ hơn',
  'khủng khiếp',
  'thoải mái',
  'ngớ ngẩn',
  'hổ thẹn',
  'kinh khủng',
  'đang ngủ',
  'khỏe',
  'nhanh nhẹn',
  'ngại ngùng',
  'gay go',
  'kỳ lạ',
  'như con người',
  'bị tổn thương',
  'khủng khiếp'
];

const reportSubjectArray = {
  'Ảnh khỏa thân': [
    'Ảnh khỏa thân người lớn',
    'Gợi dục',
    'Hoạt động tình dục',
    'Bóc lột tình dục',
    'Dịch vụ tình dục',
    'Liên quan đến trẻ em',
    'Chia sẻ hình ảnh riêng tư'
  ],
  'Bạo lực': [
    'Hình ảnh bạo lực',
    'Tử vong hoặc bị thương nặng',
    'Mối đe dọa bạo lực',
    'Ngược đãi động vật',
    'Vấn đề khác'
  ],
  'Quấy rồi': ['Tôi', 'Một người bạn'],
  'Tự tử/Tự gây thương tích': 'Tự tử/Tự gây thương tích',
  'Tin giả': 'Tin giả',
  'Spam': 'Spam',
  'Bán hàng trái phép': [
    'Chất cấm, chất gây nghiện',
    'Vũ khí',
    'Động vật có nguy cơ bị tuyệt chủng',
    'Động vật khác',
    'Vấn đề khác'
  ],
  'Ngôn từ gây thù ghét': [
    'Chủng tộc hoặc sắc tộc',
    'Nguồn gốc quốc gia',
    'Thành phần tôn giáo',
    'Phân chia giai cấp xã hội',
    'Thiên hướng tình dục',
    'Giới tính hoặc bản dạng giới',
    'Tình trạng khuyết tật hoặc bệnh tật',
    'Hạng mục khác'
  ],
  'Khủng bố': 'Khủng bố'
};
final linkPattern = RegExp(r"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");
final Map<String, String> emojiMap = {
  ":)": "😊",
  ":(": "😞",
  ":|": "😐",
  ":D": "😀",
  ":P": "😛",
  ":*": "😘",
  ":O": "😮",
  ":@": "😡",
  ":S": "😕",
  ":&": "😷",
  ":\\": "😒",
  ":^)": "😏",
  ":3": "😝",
  ":v": "😉",
  ":x": "😶",
  ":?": "😕",
  ":!": "😱",
  // ":(": "😔",
  // ":)": "😃",
  ":>": "😎",
  ":<": "😒",
  ":/": "😕",
  ":;": "😉",
  ":=": "😐",
  ":~": "😐",
  ":`": "😐",
  ":_": "😐",
  ":`(": "😢",
  ":`)": "😂",
  ":`D": "😂",
  ":`*": "😘",
  ":`v": "😘",
  ":`3": "😘",
  "(T_T)": "😭",
  "(^_^)": "😊",
  "^_^": "😊",
  // add more emojis here
};
