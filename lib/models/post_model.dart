import 'package:date_format/date_format.dart';
import 'poster_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../untils/format_time.dart';
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
  String? status;
  PosterModel? author;
  set setComment(String? comment) {
    this.comment = comment;
  }

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
      this.status,
      this.author});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // print(DateTime.fromMillisecondsSinceEpoch(int.parse(json['created'])));
    FormatTimeApp messages = FormatTimeApp();
    timeago.setLocaleMessages('vi', messages);
    // print(json['author']);
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
      status: json['status'],
      author: json['author'] != null ? PosterModel.fromJson(json['author']) : null,
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
    data['status'] = this.status;
    data['author'] = this.author;
    return data;
  }

  PostModel copyWith({
    String? id,
    List<ImageModel>? image,
    VideoModel? video,
    String? described,
    String? created,
    String? modified,
    String? like,
    String? comment,
    String? isLiked,
    String? isBlocked,
    String? canComment,
    String? canEdit,
    String? status,
    PosterModel? author,
  }) {
    return PostModel(
      id: id ?? this.id,
      image: image ?? this.image,
      video: video ?? this.video,
      described: described ?? this.described,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      like: like ?? this.like,
      comment: comment ?? this.comment,
      isLiked: isLiked ?? this.isLiked,
      isBlocked: isBlocked ?? this.isBlocked,
      canComment: canComment ?? this.canComment,
      canEdit: canEdit ?? this.canEdit,
      status: status ?? this.status,
    );
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
  String? thumb;

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
