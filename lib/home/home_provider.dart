
import 'package:flutter/foundation.dart';
import 'package:tinder_app_flutter/home/repository/user_repository.dart';
import 'package:tinder_app_flutter/user.dart';

class HomeProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final List<User> listUsers = [];

  void getListUsers() async {
    final _value = await _userRepository.getDataListUsers();
    listUsers.addAll(_value);
    notifyListeners();
  }
}