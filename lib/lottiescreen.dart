import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieScreen extends StatefulWidget {
  LottieScreen({Key? key}) : super(key: key);

  @override
  State<LottieScreen> createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(
        ('lib/animations/tower-signal.json'),
        height: 50,
      ),
    );
  }
}
