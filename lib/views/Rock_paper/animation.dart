import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlinkingImage extends StatefulWidget {
  final List<String> images;
  final Duration duration;

  BlinkingImage({
    Key? key,
    required this.images,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _BlinkingImageState createState() => _BlinkingImageState();
}

class _BlinkingImageState extends State<BlinkingImage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _blink();
  }

  void _blink() async {
    while (mounted) {
      await Future.delayed(widget.duration);
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.images.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(widget.images[_currentIndex]);
  }
}
