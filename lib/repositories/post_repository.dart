// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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
      print('$postUrl/getListPosts last_id: $last_id index: $index count: $count token: $token');
      // checkToken();
      var response = await dio.post(
        '$postUrl/get_list_posts',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {
          'last_id': last_id,
          'index': '$index',
          'count': '$count',
          'token': token,
          // 'new_item': '$newItem',
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

  Future<ApiResponse> getPost(String post_id) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      print('$postUrl/get_post');
      checkToken();
      var response = await http.post(
        Uri.parse('$postUrl/get_post'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': post_id,
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
      if (images != null) {
        for (var i = 0; i < images.length; i++) {
          //check if the file type is jpeg, jpg, or png

          Logger().d('Invalid file type ${images[i].path}');

          // Thêm hình ảnh vào form data
          formData.files.add(
            MapEntry(
              "image",
              MultipartFile.fromBytes(
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
            MultipartFile.fromBytes(
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

  Future<ApiResponse> editPost(
      {String? postId,
      String? described,
      String? status,
      List<XFile>? images,
      List<String>? imagesIdDelete,
      XFile? video}) async {
    ApiResponse apiResponse = ApiResponse();
    // Logger().d('edit_post: $postUrl/edit_post');

    Dio dio = Dio();

    // Tạo multipart form data
    FormData formData = FormData();
    try {
      formData.fields.add(MapEntry("token", token));
      formData.fields.add(MapEntry("id", postId.toString()));
      if (described != null) {
        formData.fields.add(MapEntry("described", described));
      }
      if (status != null) {
        formData.fields.add(MapEntry("status", status));
      }

      if (images != null) {
        for (var i = 0; i < images.length; i++) {
          // Thêm hình ảnh vào form data
          formData.files.add(
            MapEntry(
              "image",
              MultipartFile.fromBytes(
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
            MultipartFile.fromBytes(
              await video.readAsBytes(),
              filename: video.name,
              contentType: MediaType('video', 'mp4'),
            ),
          ),
        );
      }
      if (imagesIdDelete!.isNotEmpty) {
        // conver sang json
        String jsonImageDel = jsonEncode(imagesIdDelete);
        formData.fields.add(MapEntry("image_del", jsonImageDel));
      }

      print('$postUrl/edit_post: ');

      // Gửi dữ liệu lên backend
      var response = await dio.post(
        '$postUrl/edit_post',
        options: Options(
          validateStatus: (_) => true,
          contentType: "multipart/form-data",
          responseType: ResponseType.json,
        ),
        data: formData,
      );
      // Logger().d('response: ${response.statusCode} \n data: ${response.data} \n ');
      apiResponse = ApiResponse.fromJson(response.data);
      Logger().d('apiResponse edit_post: ${apiResponse.toJson()}');
    } catch (e) {
      print(e);
      Logger().e(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> deletePost(String id) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = Dio();
    try {
      final response = await dio.post(
        '$postUrl/delete_post',
        options: Options(
          validateStatus: (_) => true,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
        data: jsonEncode({
          "token": token,
          "id": id,
        }),
      );
      apiResponse = ApiResponse.fromJson(response.data);
      Logger().d('apiResponse delete_post: ${apiResponse.toJson()}');
    } catch (e) {
      print(e);
      Logger().e(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> likePost(String id) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = Dio();
    print('like_post: $likeUrl/like');
    try {
      final response = await dio.post(
        '$likeUrl/like',
        options: Options(
          validateStatus: (_) => true,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
        data: jsonEncode({
          "token": token,
          "id": id,
        }),
      );
      Logger().d('apiResponse like_post: ${response.data}');

      apiResponse = ApiResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      Logger().e(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }

  Future<ApiResponse> reportPost(String id) async {
    ApiResponse apiResponse = ApiResponse();
    Dio dio = Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("token", token));
    formData.fields.add(MapEntry("id", id));

    try {
      final response = await dio.post('$postUrl/delete_post',
          options: Options(
            validateStatus: (_) => true,
            contentType: "multipart/form-data",
            responseType: ResponseType.json,
          ),
          data: jsonEncode({
            formData,
          }));
      apiResponse = ApiResponse.fromJson(response.data);
      Logger().d('apiResponse delete_post: ${apiResponse.toJson()}');
    } catch (e) {
      print(e);
      Logger().e(e);
      apiResponse.message = serviceError;
    }
    return apiResponse;
  }
}
