import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Dusuario.dart';
import 'package:proyecto_moviles3/widgets/Recomendados.dart';
import 'package:proyecto_moviles3/widgets/TopSection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://i.postimg.cc/MZ934L9Z/F8t-TKh-IEa-2000x1500-1.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          elevation: 0,
          title: const Center(
            child: Text(
              "HoshiPlay",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DatosUsuario(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 20),
              TopSection(),
              SizedBox(height: 30),
              RecomendadosSection(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
