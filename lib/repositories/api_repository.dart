// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiResponse {
  String? code;
  String? message;
  Object? data;
  Object? details;
  ApiResponse({
    this.code,
    this.message,
    this.data,
    this.details,
  });
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
      details: json['details'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    data['details'] = this.details;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString

    return jsonEncode(this.toJson());
  }
}