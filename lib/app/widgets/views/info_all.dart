import 'package:flutter/material.dart';

class InfoAll extends StatelessWidget {
  const InfoAll({
    super.key,
    required this.icon,
    required this.text,
    required this.child,
  });
  final IconData icon;
  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: child,
        ),
      ],
    );
  }
}
