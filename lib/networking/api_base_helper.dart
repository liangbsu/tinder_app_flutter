import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:tinder_app_flutter/networking/api_exceptions.dart';

class ApiBaseHelper {
  final String _appID = '625ffe74e6a875260670577c';

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'app-id': _appID
        },
      );
      responseJson = _checkResponseStatus(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: body
      );
      responseJson = _checkResponseStatus(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http.put(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: body
      );
      responseJson = _checkResponseStatus(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    dynamic apiResponse;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      apiResponse = _checkResponseStatus(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return apiResponse;
  }
}

dynamic _checkResponseStatus(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

