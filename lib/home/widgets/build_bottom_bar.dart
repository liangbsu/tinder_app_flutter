import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/tinder_swap_card.dart' show CardController;
import 'package:tinder_app_flutter/view_list_users/screens/view_disliked_list.dart';
import 'package:tinder_app_flutter/view_list_users/screens/view_liked_list.dart';

class BuildBottomBar extends StatelessWidget {
  final CardController cardController;

  const BuildBottomBar({Key? key, required this.cardController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundIconButton.large(
                    icon: Icons.clear,
                    iconColor: Colors.red,
                    onPressed: () {
                      cardController.triggerLeft();
                    },
                  ),
                  RoundIconButton.large(
                    icon: Icons.favorite,
                    iconColor: Colors.green,
                    onPressed: () {
                      cardController.triggerRight();
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xff9c9c9c),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconTexButton(
                    icon: Icons.close,
                    textButton: 'Second Look',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ViewDislikedList()),
                      );
                    },
                  ),
                  IconTexButton(
                    icon: Icons.favorite,
                    textButton: 'Liked List',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ViewLikedList()),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}


class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  const RoundIconButton.large({Key? key,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  }) : size = 60.0, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0x11000000), blurRadius: 10.0),
          ]),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        elevation: 0.0,
        child: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class IconTexButton extends StatelessWidget {
  final IconData icon;
  final String textButton;
  final VoidCallback onPressed;

  const IconTexButton({Key? key, required this.icon, required this.textButton, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      splashColor: const Color(0xff9c9c9c),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              icon,
              size: 30.0,
              color: Colors.red,
            ),
          ),
          Text(
            textButton,
            style: const TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}