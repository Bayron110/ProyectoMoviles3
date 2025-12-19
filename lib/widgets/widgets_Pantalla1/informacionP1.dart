import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';


class GeneroChip extends StatelessWidget {
  final String texto;
  
  const GeneroChip(this.texto, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: AppDecoraciones.chipGenero(),
      child: Text(
        texto,
        style: AppTextos.textoChip,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String valor;
  
  const InfoRow(this.label, this.valor, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextos.textoSecundario),
        SizedBox(width: 8),
        Expanded(
          child: Text(valor, style: AppTextos.textoNormal.copyWith(fontSize: 14)),
        ),
      ],
    );
  }
}