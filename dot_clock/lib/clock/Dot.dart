import 'package:flutter/material.dart';

class Dot extends StatefulWidget {
  final bool isLetter;
  final int opacity;
  final int j;
  final List<int> border;
  Dot({this.opacity, this.j, this.border, this.isLetter});

  @override
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double dotSize = 23;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      value: widget.opacity.toDouble(),
      duration: Duration(milliseconds: 300),
    );
    super.initState();

    if (widget.isLetter) dotSize = dotSize / 2;
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(10);

    Future.delayed(Duration(milliseconds: widget.j * 50), () {
      if (widget.opacity == 1)
        _controller.animateTo(1);
      else
        _controller.animateTo(0);
    });

    return Padding(
      padding: const EdgeInsets.all(0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (widget.border != null) {
            if (_controller.value < 1) {
              borderRadius = BorderRadius.circular(10);
            } else {
              borderRadius = BorderRadius.only(
                  topRight: widget.border[0] == 0 && widget.border[2] == 0
                      ? Radius.circular(5)
                      : Radius.circular(0),
                  topLeft: widget.border[0] == 0 && widget.border[1] == 0
                      ? Radius.circular(5)
                      : Radius.circular(0),
                  bottomLeft: widget.border[3] == 0 && widget.border[1] == 0
                      ? Radius.circular(5)
                      : Radius.circular(0),
                  bottomRight: widget.border[3] == 0 && widget.border[2] == 0
                      ? Radius.circular(5)
                      : Radius.circular(0));
            }
          }

          return Transform.scale(
              scale: _controller.value,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: borderRadius),
                height: dotSize,
                width: dotSize,
              ));
        },
      ),
    );
  }
}
