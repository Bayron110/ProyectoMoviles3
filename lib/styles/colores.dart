import 'package:flutter/material.dart';

class AppColores {
  static const Color fondoNegro = Color.fromRGBO(0, 0, 0, 1);
  static const Color blanco = Colors.white;
  static const Color gris = Colors.grey;
  static final Color grisOscuro = Colors.grey[900]!;
  
  static const Color botonPrimario = Colors.white;
  static const Color textoBotonPrimario = Colors.black;
  static const Color bordeBotonSecundario = Colors.grey;
  
  static List<Color> gradienteImagen = [
    Colors.transparent,
    Colors.black.withOpacity(0.7),
    Colors.black,
  ];
}