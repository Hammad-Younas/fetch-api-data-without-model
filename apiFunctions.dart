import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/appConstants.dart';

class ApiFunctions {
  var dio = Dio();

  String? accessToken;

  Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );

    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.getProfile}?userId=$userId',
    );
    var response = await http.post(
      url,
      body: {
        // "userId":3
      },
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );

    print(accessToken);
    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.getHomePosts}',
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );
    var response = await http.post(
      url,
      body: {"userId": "$userId"},
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getActivities() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );
    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.getActivities}?userId=2',
    );
    var response = await http.post(
      url,
      body: {
        // "userId":3
      },
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getMarketPlaceList() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );

    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.marketPlaceList}',
    );
    var response = await http.post(
      url,
      body: {
        // "userId":3
      },
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data;
  }
  Future<Map<String, dynamic>> getSpecificUserList() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );

    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.specificUserList}',
    );
    var response = await http.post(
      url,
      body: {
        "userId":userId
      },
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getCategoriesList() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );

    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.categories}',
    );
    var response = await http.post(
      url,
      body: {
        // "userId":3
      },
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data;
  }

  login(username, password) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.login}',
    );
    var response = await http.post(
      url,
      body: {"userName": username.toString(), "password": password.toString()},
      headers: {
        // 'content-type': 'application/json',
        // "authorization" : 'Bearer $accessToken'
      },
    );
    String body = utf8.decode(response.bodyBytes);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(body);
    await prefs.setString(AppConstants.accessToken, "${data["data"]["token"]}");

    return data;
  }

  Future uploadReels(
    File file,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );

    String fileName = file.path.split('/').last;

    var formData = FormData.fromMap({
      'userId': 3,
      'video[1]': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post(
        '${AppConstants.baseURL}${AppConstants.addReels}',
        data: formData,
        options: Options(headers: {"accessToken": '$accessToken'}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');

    // var data = jsonDecode(response.data) ;
    return response.data;
  }

  Future<Map<String, dynamic>> search(type, keyword) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    var url = Uri.parse(
      '${AppConstants.baseURL}${AppConstants.search}',
    );
    var response = await http.post(
      url,
      body: {"type": type.toString(), "keyword": keyword.toString()},
      headers: {
        // 'content-type': 'application/json',
        "accessToken": '$accessToken'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    return data["data"];
  }

  Future uploadPost(
    File file,
    text,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );

    print(file.path);
    print(userId!);
    String fileName = file.path.split('/').last;


    var formData = FormData.fromMap({
      'userId': int.parse(userId),
      "caption": "$text",
      "tagUsers": [],
      "location": "Multan, pakistan",
      "lat": 71.2,
      "lang": 35.2,
      'files[1]': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post(
        '${AppConstants.baseURL}${AppConstants.addPost}',
        data: formData,
        options: Options(headers: {"accessToken": '$accessToken'}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    print('Response body: ${response.data["code"]}');

    // var data = jsonDecode(response.data) ;
    return response.data;
  }


  Future uploadStory(
    File file,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );

    print(file.path);
    print(userId!);
    String fileName = file.path.split('/').last;


    var formData = FormData.fromMap({
      'userId': int.parse(userId),
      'files[1]': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post(
        '${AppConstants.baseURL}${AppConstants.addStatus}',
        data: formData,
        options: Options(headers: {"accessToken": '$accessToken'}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    print('Response body: ${response.data["code"]}');

    // var data = jsonDecode(response.data) ;
    return response.data;
  }

  Future uploadNewListing(
     String title,
   int price,
    int categoryId,
    String itemCondition,
    String des,

    File file,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
      AppConstants.accessToken,
    );
    String? userId = prefs.getString(
      AppConstants.userId,
    );

    print(file.path);
    print(userId!);
    String fileName = file.path.split('/').last;


    var formData = FormData.fromMap({
      'userId': int.parse(userId),
      'title': "$title",
      'price': price,
      'category_id': categoryId,
      'item_condition': "$itemCondition",
      'description': "$des",
      'location': "Multan",
      'quantity': 3,
      'files[1]': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await dio.post(
        '${AppConstants.baseURL}${AppConstants.addListing}',
        data: formData,
        options: Options(headers: {"accessToken": '$accessToken'}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    print('Response body: ${response.data["code"]}');

    return response.data;
  }
}
