import 'package:flutter/material.dart';

class LineProgressWidget extends StatelessWidget {
  const LineProgressWidget({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[300],
        color: Color.fromRGBO(7, 119, 245, 1.0),
        minHeight: 9,
      ),
    );
  }
}