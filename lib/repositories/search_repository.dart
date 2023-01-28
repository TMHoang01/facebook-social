import 'package:dio/dio.dart';

import 'package:fb_copy/constants.dart';

import 'package:fb_copy/models/user_model.dart';

import 'package:fb_copy/repositories/api_repository.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SearchRepository {
  var logger = Logger();

  Future<ApiResponse> search(String keyword, String userId, String index, String count) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = new Dio();
    try {
      print('$searchUrl/search');
      var response = await dio.get(
        '$searchUrl/search',
        queryParameters: {
          'keyword': keyword,
          'user_id': userId,
          'count': count,
          'index': index,
          'token': token,
        },
      );
      logger.d(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);

      apiResponse.message = serviceError;
    }
    // logger.i(apiResponse.toString());
    return apiResponse;
  }

  Future<ApiResponse> getSavedSearch(String index, String count) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = new Dio();
    try {
      print('$searchUrl/getSavedSearch');
      var response = await dio.get(
        '$searchUrl/get_saved_search',
        queryParameters: {
          'token': token,
          'index': index,
          'count': count,
        },
      );
      logger.d(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);

      apiResponse.message = serviceError;
    }
    // logger.i(apiResponse.toString());
    return apiResponse;
  }

  Future<ApiResponse> del_saved_search(String search_id, String? all) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = new Dio();
    all ??= '0';
    try {
      print('$searchUrl/del_saved_search');
      var response = await dio.get(
        '$searchUrl/del_saved_search',
        queryParameters: {
          'token': token,
          'search_id': search_id,
          'all': all,
        },
      );
      logger.d(response.data);
      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);

      apiResponse.message = serviceError;
    }
    // logger.i(apiResponse.toString());
    return apiResponse;
  }
}
