import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_app_flutter/home/home_provider.dart';
import 'package:tinder_app_flutter/view_list_users/widgets/card_user.dart';

class ViewLikedList extends StatelessWidget {
  const ViewLikedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked List'),
      ),
      body: _homeProvider.listUsersLiked.isNotEmpty ? GridView.count(
        primary: false,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
        crossAxisCount: 2,
        children: List.generate(_homeProvider.listUsersLiked.length, (index) {
          final _user = _homeProvider.listUsersLiked.elementAt(index);
          return CardUser(user: _user);
        })
      ) : const Center(
        child: Text("Don't have anyone yet!"),
      )
    );
  }
}
