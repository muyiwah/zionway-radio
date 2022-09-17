import 'package:flutter/material.dart';

class NewBox extends StatelessWidget {
  final child;
  const NewBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(child: child),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(255, 46, 77, 162),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 74, 152, 203),
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
          BoxShadow(
            color: Color.fromARGB(255, 100, 97, 97),
            blurRadius: 15,
            offset: Offset(-2, -2),
          ),
        ],
      ),
    );
  }
}
