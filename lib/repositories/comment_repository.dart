import 'package:dio/dio.dart';

import 'package:fb_copy/constants.dart';

import 'package:fb_copy/models/user_model.dart';

import 'package:fb_copy/repositories/api_repository.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CommentRepository {
  // get_comment api input: token,id,index,count
  // get_comment api output: apiResponse
  Future<ApiResponse> getComment({required String id, required String index, required String count}) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = new Dio();
    try {
      print('$commentUrl/get_comment');
      var response = await dio.post(
        '$commentUrl/get_comment',
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'token': token,
          'id': id,
          'index': index,
          'count': count,
        },
      );
      // Logger().d(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);

      apiResponse.message = serviceError;
    }
    // Logger().i(apiResponse.toString());
    return apiResponse;
  }

  // set_comment api input body: token,id,comment, index, count
  // set_comment api output: apiResponse
  Future<ApiResponse> setComment(
      {required String id, required String comment, required String index, required String count}) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = new Dio();
    try {
      print('$commentUrl/set_comment');
      var response = await dio.post(
        '$commentUrl/set_comment',
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'token': token,
          'id': id,
          'comment': comment,
          'index': index,
          'count': count,
        },
      );
      // Logger().d(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);

      apiResponse.message = serviceError;
    }
    // Logger().i(apiResponse.toString());
    return apiResponse;
  }
}
