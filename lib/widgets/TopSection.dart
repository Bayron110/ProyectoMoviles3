import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/widgets/TopCard.dart';


class TopSection extends StatelessWidget {
  const TopSection({super.key});

  final List<String> topImages = const [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr_cmzkkrXOT0VCkmvSSvRP2tJ5pPRIAgI2Q&s",
    "https://static.wikia.nocookie.net/jujutsu-kaisen/images/f/f6/JJK_New_Key_Visual.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwjtbHiFVqFWGc-D1zpM2hHpsd0-0SCW_b2Q&s",
    "https://m.media-amazon.com/images/M/MV5BYmUzMTk5MGQtZDg5Yy00MWEzLWIzNjUtNWIyMjFjODhiYjcyXkEyXkFqcGc@._V1_.jpg",
    "https://m.media-amazon.com/images/M/MV5BN2EzYTYyNGUtOTE2ZS00ZTljLWE5M2EtZDViYjhmYzgwNThhXkEyXkFqcGc@._V1_.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "🔥 Top 5",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topImages.length,
            itemBuilder: (context, index) {
              return TopCard(
                position: index + 1,
                imageUrl: topImages[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
