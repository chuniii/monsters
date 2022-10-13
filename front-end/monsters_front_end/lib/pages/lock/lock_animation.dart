import 'package:flutter/material.dart';
import 'package:monsters_front_end/pages/style.dart';

class MPinAnimationController {
  late void Function(String) animate;
  late void Function() clear;
}

class MPinAnimation extends StatefulWidget {
  final MPinAnimationController controller;

  const MPinAnimation({Key? key, required this.controller}) : super(key: key);
  @override
  _MPinAnimationState createState() => _MPinAnimationState(controller);
}

class _MPinAnimationState extends State<MPinAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _sizeAnimation;
  Animation<double>? _opacityAnimation;
  String pin = '';

  void animate(String input) {
    _controller!.forward();
    setState(() {
      pin = input;
    });
  }

  void clear() {
    setState(() {
      pin = '';
    });
  }

  _MPinAnimationState(controller) {
    controller?.animate = animate;
    controller?.clear = clear;
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    );
    _controller!.addListener(() {
      if (_controller!.status == AnimationStatus.completed)
        _controller!.reverse();
      setState(() {});
    });
    _sizeAnimation = Tween<double>(begin: 24, end: 72).animate(_controller!);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      child: Container(
        height: _sizeAnimation!.value * 2,
        width: _sizeAnimation!.value * 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_sizeAnimation!.value),
          color: pin == '' ? BackgroundColorSoft : BackgroundColorWarm,
        ),
        child: Opacity(
          opacity: _opacityAnimation!.value,
          child: Transform.scale(
            scale: _sizeAnimation!.value / 48,
            child: Text(
              pin,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
