import 'dart:math';
import 'package:flutter/material.dart';

class PlayingAnimateWidget extends StatefulWidget {
  @override
  _PlayingAnimateWidgetState createState() => _PlayingAnimateWidgetState();
}

class _PlayingAnimateWidgetState extends State<PlayingAnimateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.3;
    double heightSize = MediaQuery.of(context).size.height / 4;
    return Container(
      height: heightSize,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CustomPaint(
            painter: _SpritePainter(_controller),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 100, // beyaz alan
                      width: 100,
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.white, width: 5),
                      //     // color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(125)),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                      )),
                )),
                Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/images/mic.png',
                    // alignment: Alignment.topCenter,
                    height: 100, //logo
                    width: 100,
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class _SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  _SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 2.0)).clamp(0.0, 6.0);
    Color color = Colors.lightBlue.withOpacity(0.5);
    
    double size = rect.width;
    double area = size * size;
    double radius = sqrt(area * value / 4); // yeşil alan

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(_SpritePainter oldDelegate) {
    return true;
  }
}
