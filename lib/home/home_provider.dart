
import 'package:flutter/foundation.dart';
import 'package:tinder_app_flutter/home/repository/user_repository.dart';
import 'package:tinder_app_flutter/user.dart';

class HomeProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final List<User> listUsers = [];
  final List<User> listUsersLiked = [];
  final List<User> listUsersDisliked = [];
  int _page = 0;

  void firsFetchData() async {
    await getListUsers();
    getUserDetail(0);
  }

  Future<void> getListUsers() async {
    try {
      _page++;
      final _value = await _userRepository.getDataListUsers(_page);
      listUsers.addAll(_value);
      notifyListeners();
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void getUserDetail(int indexUserInList) async {
    try {
      final _value = await _userRepository.getUserDetail(listUsers[indexUserInList].id);
      listUsers[indexUserInList] = _value;
      notifyListeners();
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}