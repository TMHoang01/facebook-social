import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/models/poster_model.dart';

class CommentModel {
  String? id;
  String? comment;
  String? created;
  PosterModel? poster;
  String? isBlocked;

  CommentModel({this.id, this.comment, this.created, this.poster, this.isBlocked});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    created = json['created'];
    poster = json['poster'] != null ? new PosterModel.fromJson(json['poster']) : null;
    isBlocked = json['is_blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['created'] = this.created;
    if (this.poster != null) {
      data['poster'] = this.poster!.toJson();
    }
    data['is_blocked'] = this.isBlocked;
    return data;
  }
}
