import 'package:tinder_app_flutter/networking/api_base_helper.dart';
import 'package:tinder_app_flutter/user.dart';

class UserRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<User>> getDataListUsers(int _page) async {
    final String _url = 'https://dummyapi.io/data/v1/user?limit=10&page=$_page';
    final _response = await _helper.get(_url);
    return ListUsers.fromJson(_response).results;
  }

  Future<User> getUserDetail(String? userID) async {
    final String _url = 'https://dummyapi.io/data/v1/user/$userID';
    final _response = await _helper.get(_url);
    return User.fromJson(_response);
  }
}