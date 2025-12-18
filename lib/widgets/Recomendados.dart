import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/widgets/RecomendadoButton.dart';
import '../screens/Pantalla1.dart';
import '../screens/Pantalla2.dart';
import '../screens/Pantalla3.dart';
import '../screens/Pantalla4.dart';
import '../screens/Pantalla5.dart';
import '../screens/Pantalla6.dart';

class RecomendadosSection extends StatelessWidget {
  const RecomendadosSection({super.key});

  final List<String> images = const [
    "https://m.media-amazon.com/images/M/MV5BYzU1NjYzNWEtYjJjYi00MTc4LTliZDAtZmU1ZTkwNzg5NzVkXkEyXkFqcGc@._V1_.jpg",
    "https://upload.wikimedia.org/wikipedia/en/1/16/To_be_Hero_X_key_art.png",
    "https://static.wikia.nocookie.net/wiki-doblaje-espana/images/4/45/Witch_Watch-Poster.png",
    "https://upload.wikimedia.org/wikipedia/en/9/9b/Dragon_Ball_Daima.png",
    "https://a.storyblok.com/f/178900/1064x1596/d60df0cec9/re-zero-season-3-teaser-visual.png",
    "https://images.justwatch.com/poster/324676039/s718/sakamoto-days.jpg",
  ];

  final List<String> titles = const [
    "Recomendado 1",
    "Recomendado 2",
    "Recomendado 3",
    "Recomendado 4",
    "Recomendado 5",
    "Recomendado 6",
  ];

  final List<Widget> screens = const [
    Pantalla1(),
    Pantalla2(),
    Pantalla3(),
    Pantalla4(),
    Pantalla5(),
    Pantalla6(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "⭐ Recomendados de la Semana",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return RecomendadoButton(
              imageUrl: images[index],
              title: titles[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => screens[index],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
