// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? avatar;
  String? token;
  String? phonenumber;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.token,
    this.phonenumber,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? token,
    String? phonenumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
      phonenumber: phonenumber ?? this.phonenumber,
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    token = json['token'];
    phonenumber = json['phonenumber'];
  }
  UserModel.fromObject(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    token = json['token'];
    phonenumber = json['phonenumber'];
  }
}
