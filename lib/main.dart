import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/tinder_swap_card.dart' show CardController;
import 'package:tinder_app_flutter/home/widgets/build_bottom_bar.dart';
import 'package:tinder_app_flutter/home/widgets/home_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tinder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CardController _cardController = CardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(cardController: _cardController),
      bottomNavigationBar: BuildBottomBar(cardController: _cardController),
    );
  }
}
