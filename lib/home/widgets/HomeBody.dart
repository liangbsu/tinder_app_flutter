
import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/tinder_swap_card.dart';

class HomeBody extends StatelessWidget {
  final CardController cardController;

  HomeBody({Key? key, required this.cardController}) : super(key: key);

  final List<String> welcomeImages = [
    "https://cdn.wallpapersafari.com/28/53/PjfrGv.jpg",
    "https://alrigh.com/wp-content/uploads/2020/06/11-Toga-profile-picture.jpg",
    "https://cdn.wallpapersafari.com/28/53/PjfrGv.jpg",
    "https://alrigh.com/wp-content/uploads/2020/06/11-Toga-profile-picture.jpg",
    "https://cdn.wallpapersafari.com/28/53/PjfrGv.jpg",
    "https://alrigh.com/wp-content/uploads/2020/06/11-Toga-profile-picture.jpg"
  ];

  @override
  Widget build(BuildContext context) {

    return TinderSwapCard(
      totalNum: welcomeImages.length,
      swipeEdge: 5.0,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
      maxHeight: MediaQuery.of(context).size.height,
      cardBuilder: (context, index) {
        return SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  welcomeImages[index],
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Adina 68',
                        style: TextStyle(color: Colors.white, fontSize: 22.0)
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Icon(Icons.circle, color: Colors.green, size: 10.0),
                        ),
                        Text(
                          'Recently Active',
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      cardController: cardController,
      swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
        /// Get orientation & index of swiped card!
      },
    );
  }
}
