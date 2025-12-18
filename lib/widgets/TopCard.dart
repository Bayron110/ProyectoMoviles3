import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  final int position;
  final String imageUrl;

  const TopCard({
    super.key,
    required this.position,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Positioned(
        bottom: 10,
        left: 10,
        child: Text(
          "#$position",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 8),
            ],
          ),
        ),
      ),
    );
  }
}
