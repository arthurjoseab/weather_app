import 'package:flutter/material.dart';

class HurlyFocusCard extends StatelessWidget {
  const HurlyFocusCard(
      {super.key,
      required this.time,
      required this.temprature,
      required this.icon});
  final String time;
  final String temprature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(19)),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              temprature,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
