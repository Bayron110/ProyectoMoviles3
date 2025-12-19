import 'package:flutter/material.dart';
import 'colores.dart';

class AppDecoraciones {
  static BoxDecoration fondoNegro() {
    return BoxDecoration(color: AppColores.fondoNegro);
  }
  
  static BoxDecoration imagenConGradiente(String urlImagen) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(urlImagen),
        fit: BoxFit.cover,
      ),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: AppColores.gradienteImagen,
      ),
    );
  }
  
  static BoxDecoration chipGenero() {
    return BoxDecoration(
      color: AppColores.grisOscuro,
      borderRadius: BorderRadius.circular(20),
    );
  }
  
  static BoxDecoration bordeClasificacion() {
    return BoxDecoration(
      border: Border.all(color: AppColores.gris),
      borderRadius: BorderRadius.circular(2),
    );
  }
  
  static ButtonStyle botonPrimario() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColores.botonPrimario,
      padding: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
  
  static ButtonStyle botonSecundario() {
    return OutlinedButton.styleFrom(
      side: BorderSide(color: AppColores.bordeBotonSecundario),
      padding: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}