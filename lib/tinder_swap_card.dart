import 'dart:math' show pi;
import 'package:flutter/material.dart';

enum TriggerDirection { none, right, left }

class TinderSwapCard extends StatefulWidget {
  final CardBuilder _cardBuilder;

  final int _totalNum;

  final int _animDuration;

  final double _swipeEdge;

  final CardController? cardController;

  final CardSwipeCompleteCallback? swipeCompleteCallback;

  final Size _cardSizes;

  @override
  _TinderSwapCardState createState() => _TinderSwapCardState();

  TinderSwapCard({Key? key,
    required CardBuilder cardBuilder,
    required int totalNum,
    required double maxWidth,
    required double maxHeight,
    int animDuration = 600,
    double swipeEdge = 2.0,
    this.swipeCompleteCallback,
    this.cardController
  })  :
        _cardBuilder = cardBuilder,
        _totalNum = totalNum,
        _animDuration = animDuration,
        _cardSizes = Size(maxWidth, maxHeight),
        _swipeEdge = swipeEdge, super(key: key);
}

class _TinderSwapCardState extends State<TinderSwapCard> with TickerProviderStateMixin {

  final Alignment _cardAligns = const Alignment(0.0, 0.0);

  late Alignment frontCardAlign;

  late AnimationController _animationController;

  late int _currentFront = 0;

  static TriggerDirection? _trigger;

  Widget _buildCard(BuildContext context, int realIndex) {
    if (_currentFront == widget._totalNum - 1 && realIndex % 2  == 0 || _currentFront > widget._totalNum - 1) return Container();

    if (realIndex % 2 != 0) {
      return Align(
        alignment: _animationController.status == AnimationStatus.forward
            ? frontCardAlign = CardAnimation.frontCardAlign(
          _animationController,
          frontCardAlign,
          widget._swipeEdge,
        ).value
            : frontCardAlign,
        child: Transform.rotate(
          angle: -(pi / 180.0) *
              (_animationController.status == AnimationStatus.forward
                  ? CardAnimation.frontCardRota(
                  _animationController, frontCardAlign.x)
                  .value
                  : frontCardAlign.x),
          child: SizedBox.fromSize(
            size: widget._cardSizes,
            child: widget._cardBuilder(
              context,
              _currentFront,
            ),
          ),
        ),
      );
    }
    return Align(
      alignment: _cardAligns,
      child: SizedBox.fromSize(
        size: widget._cardSizes,
        child: widget._cardBuilder(
          context,
          _currentFront + 1,
        ),
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    final cards = <Widget>[];

    for (var i = 0; i < 2; i++) {
      cards.add(_buildCard(context, i));
    }

    cards.add(Align(
      alignment: _cardAligns,
      child: SizedBox.fromSize(
        size: widget._cardSizes,
        child: GestureDetector(
          onPanUpdate: (final details) {
            setState(() {
              frontCardAlign = Alignment(
                frontCardAlign.x + details.delta.dx * 20 / MediaQuery.of(context).size.width,
                0,
              );
            });
          },
          onPanEnd: (final details) {
            animateCards(TriggerDirection.none);
          },
        ),
      ),
    ));
    return cards;
  }

  void animateCards(TriggerDirection trigger) {
    if (_animationController.isAnimating) {
      return;
    }
    _trigger = trigger;
    _animationController.stop();
    _animationController.value = 0.0;
    _animationController.forward();
  }

  void triggerSwap(TriggerDirection trigger) {
    animateCards(trigger);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.cardController?.removeListener();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() {
    widget.cardController?.addListener(triggerSwap);

    frontCardAlign = _cardAligns;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget._animDuration,
      ),
    );

    _animationController.addListener(() => setState(() {}));

    _animationController.addStatusListener(
          (final status) {
        final index = _currentFront;

        if (status == AnimationStatus.completed) {
          CardSwipeOrientation orientation;

          if (frontCardAlign.x < -widget._swipeEdge) {
            orientation = CardSwipeOrientation.left;
          } else if (frontCardAlign.x > widget._swipeEdge) {
            orientation = CardSwipeOrientation.right;
          } else {
            frontCardAlign = _cardAligns;
            orientation = CardSwipeOrientation.recover;
          }

          if (widget.swipeCompleteCallback != null) {
            widget.swipeCompleteCallback!(orientation, index);
          }

          if (orientation != CardSwipeOrientation.recover) changeCardOrder();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _buildCards(context));
  }

  void changeCardOrder() {
    setState(() {
      _currentFront++;
      frontCardAlign = _cardAligns;
    });
  }
}

typedef CardBuilder = Widget Function(BuildContext context, int index);

enum CardSwipeOrientation { left, right, recover }

typedef CardSwipeCompleteCallback = void Function(CardSwipeOrientation orientation, int index);

class CardAnimation {
  static Animation<Alignment> frontCardAlign(
      AnimationController controller,
      Alignment beginAlign,
      double swipeEdge,
      ) {
    double endX, endY;

    if (_TinderSwapCardState._trigger == TriggerDirection.none) {
      endX = beginAlign.x > 0
          ? (beginAlign.x > swipeEdge ? beginAlign.x + 10.0 : 0.0)
          : (beginAlign.x < -swipeEdge ? beginAlign.x - 10.0 : 0.0);
      endY = 0.0;
    } else if (_TinderSwapCardState._trigger == TriggerDirection.left) {
      endX = beginAlign.x - swipeEdge;
      endY = 0.0;
    } else {
      endX = beginAlign.x + swipeEdge;
      endY = 0.0;
    }
    return AlignmentTween(
      begin: beginAlign,
      end: Alignment(endX, endY),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
  }

  static Animation<double> frontCardRota(AnimationController controller, double beginRot) {
    return Tween(begin: beginRot, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
  }
}

typedef TriggerListener = void Function(TriggerDirection trigger);

class CardController {
  late TriggerListener? _listener;

  void triggerLeft() {
    _listener!(TriggerDirection.left);
  }

  void triggerRight() {
    _listener!(TriggerDirection.right);
  }

  void addListener(final TriggerListener listener) {
    _listener = listener;
  }

  void removeListener() {
    _listener = null;
  }
}