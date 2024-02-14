import 'package:flutter/material.dart';

class Additional_item extends StatelessWidget {
  const Additional_item({
    super.key,
    required this.icon_name,
    required this.text,
    required this.value,
  });
  final IconData icon_name;
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon_name,
          size: 32,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
