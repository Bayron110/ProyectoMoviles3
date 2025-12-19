import 'package:flutter/material.dart';
import 'colores.dart';

class AppTextos {
  static const TextStyle tituloPrincipal = TextStyle(
    color: AppColores.blanco,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle tituloAppBar = TextStyle(
    color: AppColores.blanco,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle textoNormal = TextStyle(
    color: AppColores.blanco,
    fontSize: 15,
    height: 1.5,
  );
  
  static const TextStyle textoSecundario = TextStyle(
    color: AppColores.gris,
    fontSize: 14,
  );
  
  static const TextStyle textoBotonPrimario = TextStyle(
    color: AppColores.textoBotonPrimario,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  
  static const TextStyle textoBotonSecundario = TextStyle(
    color: AppColores.blanco,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  
  static const TextStyle textoChip = TextStyle(
    color: AppColores.blanco,
    fontSize: 13,
  );
  
  static const TextStyle textoMetadato = TextStyle(
    color: AppColores.gris,
    fontSize: 12,
  );
}