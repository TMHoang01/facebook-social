//login
import 'dart:convert';
import 'dart:math';

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:http/http.dart' as http;
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
      logger.i(jsonDecode(response.body));
      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    // logger.i(apiResponse.toString());
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
}
