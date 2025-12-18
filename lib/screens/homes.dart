import 'package:flutter/material.dart';
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
            "https://www.clarin.com/img/2024/03/25/F8tTKhIEa_2000x1500__1.jpg",
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
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
