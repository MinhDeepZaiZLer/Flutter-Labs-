import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blue.shade900,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade900,
            title: const Text('Ask Me Anything'),
          ),
          body: const MagicBall(),
        ),
      ),
    );

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  int ballNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            ballNumber = Random().nextInt(5) + 1; // Random từ 1 đến 5
          });
        },
        child: Image.asset('images/ball$ballNumber.png'),
      ),
    );
  }
}