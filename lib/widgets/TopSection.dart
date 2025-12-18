import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/widgets/TopCard.dart';


class TopSection extends StatelessWidget {
  const TopSection({super.key});

  final List<String> topImages = const [
    "https://i.postimg.cc/qvDjD6wK/s-l1200.jpg",
    "https://i.postimg.cc/prkD931k/518168.jpg",
    "https://i.postimg.cc/8CWMd708/images-q-tbn-ANd9Gc-Qwjtb-Hi-FVq-FWGc-D1zp-M2h-Hpsd0-0SCW-b2Q-s.jpg",
    "https://i.postimg.cc/50bYwnzC/MV5BYm-Uz-MTk5MGQt-ZDg5Yy00MWEz-LWIz-Nj-Ut-NWIy-Mj-Fj-ODhi-Yjcy-Xk-Ey-Xk-Fqc-Gc-V1.jpg",
    "https://i.postimg.cc/VvHJPwVT/MV5BN2Ez-YTYy-NGUt-OTE2ZS00ZTlj-LWE5M2Et-ZDVi-Yjhm-Yzgw-NThh-Xk-Ey-Xk-Fqc-Gc-V1.jpg",
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
