import 'package:flutter/material.dart';

class BuildLabel extends StatelessWidget {
  final String label;
  const BuildLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
