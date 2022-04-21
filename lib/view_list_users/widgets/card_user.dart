import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/user.dart';

class CardUser extends StatelessWidget {
  final User user;

  const CardUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            user.imageUrl ?? '',
            errorBuilder: ((context, _ , stackTrace) => Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey,
                child: const Icon(Icons.error, color: Colors.red, size: 22.0))),
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
          child: Text(
              (user.firstName ?? '') + ' ' + (user.lastName ?? '') + ' ' + '${user.age ?? ''}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 14.0)
          ),
        )
      ],
    );
  }
}
