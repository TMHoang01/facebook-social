// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String id;
  final String? title;
  final String? described;
  final String author;
  final Media? video;
  final String? like;
  final String? comment;

  PostModel({
    required this.id,
    this.title,
    this.described,
    required this.author,
    this.video,
    this.like,
    this.comment,
  });

  @override
  List<Object> get props => [id, author];

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      described: json['described'],
      author: json['author'],
      video: json['video'] != null ? Media.fromJson(json['video']) : null,
      like: json['like'],
      comment: json['comment'],
    );
  }
}

class Media {
  String? id;
  String? url;

  Media({this.id, this.url});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
