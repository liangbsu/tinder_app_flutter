import 'dart:convert';
import 'dart:io';

import 'package:tinder_app_flutter/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String _appID = '625ffe74e6a875260670577c';

  Future<List<User>> getDataListUsers() async {
    List<User> result = [];
    try {
      final response = await http.get(
        Uri.parse('https://dummyapi.io/data/v1/user?limit=10'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'app-id': _appID
        },
      );
      if (response.statusCode == 200) {
        result = List.from(json.decode(response.body)['data']).map((_user) => User.fromJson(_user)).toList();
      }
    } catch (e) {
      result = [];
    }
    return result;
  }

  Future<User> getUserDetail(String? userID) async {
    User result = User();
    try {
      final response = await http.get(
        Uri.parse('https://dummyapi.io/data/v1/user/$userID'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'app-id': _appID
        },
      );
      if (response.statusCode == 200) {
        result = User.fromJson(json.decode(response.body));
      }
    } catch (e) {
      result = User();
    }
    return result;
  }
}