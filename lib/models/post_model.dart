import 'package:date_format/date_format.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class PostModel {
  String? id;
  List<ImageModel>? image;
  VideoModel? video;
  String? described;
  String? created;
  String? modified;
  String? like;
  String? comment;
  String? isLiked;
  String? isBlocked;
  String? canComment;
  String? canEdit;
  String? state;
  Author? author;

  PostModel(
      {this.id,
      this.image,
      this.video,
      this.described,
      this.created,
      this.modified,
      this.like,
      this.comment,
      this.isLiked,
      this.isBlocked,
      this.canComment,
      this.canEdit,
      this.state,
      this.author});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    print(DateTime.fromMillisecondsSinceEpoch(int.parse(json['created'])));
    MyCustomMessages messages = MyCustomMessages();
    timeago.setLocaleMessages('vi', messages);

    return PostModel(
      id: json['id'],
      image: json['image'] != null ? (json['image'] as List).map((i) => ImageModel.fromJson(i)).toList() : null,
      video: json['video'] != null ? VideoModel.fromJson(json['video']) : null,
      described: json['described'],
      created: messages.getCustomFormat(json['created']),
      modified: json['modified'],
      like: json['like'],
      comment: json['comment'],
      isLiked: json['is_liked'],
      isBlocked: json['is_blocked'],
      canComment: json['can_comment'],
      canEdit: json['can_edit'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    data['described'] = this.described;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['like'] = this.like;
    data['comment'] = this.comment;
    data['is_liked'] = this.isLiked;
    data['is_blocked'] = this.isBlocked;
    data['can_comment'] = this.canComment;
    data['can_edit'] = this.canEdit;
    data['state'] = this.state;
    return data;
  }
}

class ImageModel {
  String? id;
  String? url;

  ImageModel({this.id, this.url});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class VideoModel {
  String? url;
  Null? thumb;

  VideoModel({this.url, this.thumb});

  VideoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['thumb'] = this.thumb;
    return data;
  }
}

class Author {
  String? id;
  Null? username;
  Null? avatar;

  Author({this.id, this.username, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}

class MyCustomMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'nữa';
  @override
  String lessThanOneMinute(int seconds) => 'một phút';
  @override
  String aboutAMinute(int minutes) => 'một phút';
  @override
  String minutes(int minutes) => '$minutes phút';
  @override
  String aboutAnHour(int minutes) => '1 tiếng';
  @override
  String hours(int hours) => '$hours tiếng';
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
