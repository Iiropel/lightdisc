import 'dart:math';
import 'package:flutter/material.dart';

// based on https://github.com/anupcowkur/Bubbles

class Bubbles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Bubble> bubbles;
  final int numberOfBubbles = 250;
  final Color color = Colors.white;
  final double maxBubbleSize = 2.0;

  @override
  void initState() {
    super.initState();

    // Initialize bubbles
    bubbles = List();
    int i = numberOfBubbles;
    while (i > 0) {
      bubbles.add(Bubble(color, maxBubbleSize));
      i--;
    }

    // Init animation controller
    _controller = new AnimationController(
        duration: const Duration(seconds: 1000), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomPaint(
        foregroundPainter:
        BubblePainter(bubbles: bubbles, controller: _controller),
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
      ),
    );
  }

  void updateBubblePosition() {
    bubbles.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  AnimationController controller;

  BubblePainter({this.bubbles, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles.forEach((it) => it.draw(canvas, canvasSize));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color colour;
  double direction;
  double speed;
  double speedX;
  double radius;
  double x;
  double y;

  Bubble(Color colour, double maxBubbleSize) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = 0;
    var randomSpeed = Random().nextDouble();
    this.speed = randomSpeed*randomSpeed;
    this.speedX = 0.0;
    this.x = -100;
    this.y = -100;
    this.radius = Random().nextDouble() * maxBubbleSize;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    avoidCenter(canvasSize);

    collisionRules(canvasSize);

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x < 0) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y < 0) {
      this.y = Random().nextDouble() * canvasSize.height/2 + canvasSize.height/2;
    }
  }

  updatePosition() {
    speed = speed + 0.005;
    x += speedX;
    var a = 180 - (direction + 90);
    direction > 0 && direction < 90 // make these make sense again
        ? x += speed * 0 / sin(speed)
        : x -= speed * 0 / sin(speed);
    direction > 90 && direction < 270 // make these make sense again
        ? y += speed * 1 / sin(speed)
        : y -= speed * 1 / sin(speed);
  }

  avoidCenter(Size canvasSize)
  {
    double distance = 1.0 - ((canvasSize.height/2 + canvasSize.height/2) - (canvasSize.height - y)) / canvasSize.height;
    if(y > canvasSize.height/2)
      {
        if(x < canvasSize.width * 0.5)
          speedX = -10 * (distance *distance* distance);
        else
          speedX = 10 * (distance * distance*distance);
      }
    else
      {
        if(x < canvasSize.width * 0.5)
          speedX = 5 * (distance * distance*distance * distance);
        else
          speedX = -5 * (distance *distance*distance * distance);
      }


  }

  collisionRules(Size canvasSize) {
    if(x > canvasSize.width * 0.15 && x < canvasSize.width * 0.85  && y < canvasSize.height *0.65 && y > canvasSize.height * 0.35)
    {
      speed = Random().nextDouble();
      direction = 180;
    }
    else if (y < 0) {
      speed = Random().nextDouble();
      x = Random().nextDouble() * canvasSize.width;
      y =  canvasSize.height;
    }
    else if (y > canvasSize.height) {
      speed = Random().nextDouble();
      x = Random().nextDouble() * canvasSize.width;
      direction = 0;
      y =  canvasSize.height;
    }
  }
}