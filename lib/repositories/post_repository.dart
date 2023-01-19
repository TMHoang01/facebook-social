// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http_parser/http_parser.dart';

class PostRepository {
  // Future<ApiResponse> getListPosts(String last_id, int index, int count, int newItem) async {
  //   ApiResponse apiResponse = ApiResponse();

  //   try {
  //     print('$postUrl/getListPosts last_id: $last_id index: $index count: $count');
  //     // checkToken();
  //     var response = await http.post(
  //       Uri.parse('$postUrl/get_list_posts'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'last_id': '$last_id',
  //         'index': '$index',
  //         'count': '$count',
  //         'new_item': '$newItem',
  //       }),
  //     );

  //     apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  //     // Logger().d('apiResponse: ${apiResponse.toJson()}');
  //   } catch (e) {
  //     print(e);
  //     apiResponse.message = serviceError;
  //   }
  //   return apiResponse;
  // }

  Future<ApiResponse> getListPosts(String last_id, int index, int count, int newItem) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      Dio dio = Dio();
      print('$postUrl/getListPosts last_id: $last_id index: $index count: $count');
      // checkToken();
      var response = await dio.post(
        '$postUrl/get_list_posts',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'last_id': '$last_id',
          'index': '$index',
          'count': '$count',
          'new_item': '$newItem',
        },
      );

      apiResponse = ApiResponse.fromJson(response.data);
      // Logger().d('apiResponse: ${apiResponse.toJson()}');
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> getPostById(String post_id) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      print('$postUrl/getPostById');
      checkToken();
      var response = await http.post(
        Uri.parse('$postUrl/get_post_by_id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'post_id': '$post_id',
          'token': token,
        }),
      );

      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> addPost(String? described, List<XFile>? images, XFile? video, String? status) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Dio dio = Dio();

      // Tạo multipart form data
      FormData formData = FormData();
      formData.fields.add(MapEntry("token", token));
      formData.fields.add(MapEntry("described", described ?? ''));
      formData.fields.add(MapEntry("status", status ?? ''));
      if (images!.isNotEmpty) {
        for (var i = 0; i < images.length; i++) {
          //check if the file type is jpeg, jpg, or png

          Logger().d('Invalid file type ${images[i].path}');

          // Thêm hình ảnh vào form data
          formData.files.add(
            MapEntry(
              "image",
              await MultipartFile.fromBytes(
                await images[i].readAsBytes(),
                filename: images[i].name,
                contentType: MediaType('image', 'jpg|jpeg|png'),
              ),
            ),
          );
        }
      }
      if (video != null) {
        // Thêm video vào form data
        formData.files.add(
          MapEntry(
            "video",
            await MultipartFile.fromBytes(
              await video.readAsBytes(),
              filename: video.name,
              contentType: MediaType('video', 'mp4'),
            ),
          ),
        );
      }

      // Gửi dữ liệu lên backend
      var response = await dio.post(
        '$postUrl/add_post',
        options: Options(
          validateStatus: (_) => true,
          contentType: "multipart/form-data",
          responseType: ResponseType.json,
        ),
        data: formData,
      );
      // Logger().d('response: ${response.statusCode} \n data: ${response.data} \n ');
      apiResponse = ApiResponse.fromJson(response.data);
      Logger().d('apiResponse: ${apiResponse.toJson()}');
    } catch (e) {
      print(e);
      Logger().e(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }
}
