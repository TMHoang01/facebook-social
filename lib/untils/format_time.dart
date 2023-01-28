import 'package:timeago/timeago.dart' as timeago;
import 'package:date_format/date_format.dart';

class FormatTimeApp implements timeago.LookupMessages {
  // set locale

  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'nữa';
  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';
  @override
  String aboutAMinute(int minutes) => 'một phút';
  @override
  String minutes(int minutes) => '$minutes phút';
  @override
  String aboutAnHour(int minutes) => '1 giờ';
  @override
  String hours(int hours) => '$hours giờ';
  @override
  String aDay(int hours) => '1 ngày';
  @override
  String days(int days) => '$days ngày';
  @override
  String aboutAMonth(int days) => '1 tháng';
  @override
  String months(int months) => '$months tháng';
  @override
  String aboutAYear(int year) => '1 năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
  String getCustomFormat(String timeString) {
    var timestamp = int.parse(timeString);

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var now = DateTime.now();
    // convert to 3 days ago
    if (now.difference(date).inDays < 10) {
      return timeago.format(date, locale: 'vi');
    } else {
      return formatDate(date, [d, ' thg ', m, ', ', yyyy]);
    }
  }
}
