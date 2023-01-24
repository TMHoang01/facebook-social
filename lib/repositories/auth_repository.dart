//login
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AuthRepository {
  var logger = Logger();

  Future<ApiResponse> login(String phonenumber, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      print('$authUrl/login');
      var response = await http.post(
        Uri.parse('$authUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phonenumber': phonenumber,
          'password': password,
        }),
      );
      logger.d(jsonDecode(response.body));
      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    // logger.i(apiResponse.toString());
    return apiResponse;
  }

  Future<ApiResponse> logout() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      print('$authUrl/logout');
      var response = await http.post(
        Uri.parse('$authUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': token,
        }),
      );
      logger.i(jsonDecode(response.body));
      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> signupUser({required String phone, required String password}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      print('$authUrl/register');
      var response = await http.post(
        Uri.parse('$authUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phonenumber': phone,
          'password': password,
        }),
      );
      logger.i(jsonDecode(response.body));
      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> checkNewVersion() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      print('$authUrl/check_new_version');
      logger.d('begin check token  ' + token);

      var response = await http.post(
        Uri.parse('$authUrl/check_new_version'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': token,
          'last_update': '1.0',
        }),
      );
      logger.i(jsonDecode(response.body));
      logger.d('after check token  ' + token);
      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> checkVerifyCode(String code, String phone) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = Dio();
    try {
      print('$authUrl/check_verify_code');
      var response = await dio.post(
        '$authUrl/check_verify_code',
        data: {
          'code_verify': code,
          'phonenumber': phone,
        },
      );
      logger.i(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> changeIfnoAfterSignup(String username, XFile avatar) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'avatar': await MultipartFile.fromFile(avatar.path),
      });

      print('$authUrl/change_info_after_signup');
      var response = await dio.post(
        '$authUrl/change_info_after_signup',
        data: formData,
      );
      // logger.i(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }
}
