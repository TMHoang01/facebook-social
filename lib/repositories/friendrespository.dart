import 'dart:convert';

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/untils/data.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class FriendsRespository {
  Future<ApiResponse> getRequestedFriends(String index, String count) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Dio dio = Dio();
      print('$friendUrl/get_requested_friends ');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/get_requested_friends',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'index': index,
          'count': count,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
      // Logger().d(apiResponse);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> getUserFriends(String user_id, String index, String count) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Dio dio = Dio();
      print('$friendUrl/get_user_friends  ');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/get_user_friends',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'user_id': user_id,
          'index': index,
          'count': count,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> setAcceptFriend(String userId, String isAccept) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      Dio dio = Dio();
      print('$friendUrl/set_accept_friend  ');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/set_accept_friend',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'user_id': userId,
          'is_accept': isAccept,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> setRequestFriend(String userId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      Dio dio = Dio();
      print('$friendUrl/set_request_friend  token: $token');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/set_request_friend',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'user_id': userId,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> getListSuggestedFriends(String index, String count) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      Dio dio = Dio();
      print('$friendUrl/get_list_suggested_friends ');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/get_list_suggested_friends',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'index': index,
          'count': count,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
      Logger().i('getListSuggestedFriends: ${response.data}');
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> undoFriendRequest(String userId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      Dio dio = Dio();
      print('$friendUrl/undo_request  token: $token');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/undo_request',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'user_id': userId,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> blockFriend(String userId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      Dio dio = Dio();
      print('$friendUrl/block  token: $token');
      // checkToken();
      var response = await dio.post(
        '$friendUrl/block',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'token': token,
          'user_id': userId,
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }
}
