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
    "https://i.postimg.cc/pdyKm0DR/MV5BYz-U1Nj-Yz-NWEt-Yj-Jj-Yi00MTc4LTli-ZDAt-Zm-U1ZTkw-Nzg5Nz-Vk-Xk-Ey-Xk-Fqc-Gc-V1.jpg",
    "https://i.postimg.cc/NF8H3Zw7/To-be-Hero-X-key-art.png",
    "https://i.postimg.cc/gJHcmpnR/latest-cb-20250427084642-path-prefix-es.webp",
    "https://i.postimg.cc/JhwRX0X5/Dragon-Ball-Daima.png",
    "https://i.postimg.cc/HnFhNcd2/re-zero-season-3-teaser-visual.png",
    "https://i.postimg.cc/3Jgsq10k/sakamoto-days.jpg",
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
