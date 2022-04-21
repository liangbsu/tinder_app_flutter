
import 'package:flutter/foundation.dart';
import 'package:tinder_app_flutter/home/repository/user_repository.dart';
import 'package:tinder_app_flutter/user.dart';

class HomeProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final List<User> listUsers = [];
  int _page = 0;

  void firsFetchData() async {
    await getListUsers();
    getUserDetail(0);
  }

  Future<void> getListUsers() async {
    _page++;
    final _value = await _userRepository.getDataListUsers(_page);
    listUsers.addAll(_value);
    notifyListeners();
  }

  void getUserDetail(int indexUserInList) async {
    final _value = await _userRepository.getUserDetail(listUsers[indexUserInList].id);
    if (_value.id != null) {
      listUsers[indexUserInList] = _value;
      notifyListeners();
    }
  }
}