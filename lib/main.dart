import 'package:flutter/material.dart';
//import 'package:proyecto_moviles3/screens/homes.dart';
import 'package:proyecto_moviles3/screens/login.dart';
//import 'package:proyecto_moviles3/screens/registro.dart';

void main() {
  runApp(const HoshiPlay());
}

class HoshiPlay extends StatelessWidget {
  const HoshiPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      
    );
  }
}
