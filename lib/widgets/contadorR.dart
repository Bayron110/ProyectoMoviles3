import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/textos.dart';


class ContadorRegresivo extends StatefulWidget {
  final DateTime fechaObjetivo;
  final String titulo;
  
  const ContadorRegresivo({
    super.key,
    required this.fechaObjetivo,
    this.titulo = "Próximo episodio en:",
  });

  @override
  State<ContadorRegresivo> createState() => _ContadorRegresivoState();
}

class _ContadorRegresivoState extends State<ContadorRegresivo> {
  late Timer _timer;
  Duration _tiempoRestante = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calcularTiempoRestante();
    _iniciarTimer();
  }

  void _calcularTiempoRestante() {
    final ahora = DateTime.now();
    setState(() {
      _tiempoRestante = widget.fechaObjetivo.difference(ahora);
      if (_tiempoRestante.isNegative) {
        _tiempoRestante = Duration.zero;
      }
    });
  }

  void _iniciarTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calcularTiempoRestante();
      if (_tiempoRestante.isNegative || _tiempoRestante == Duration.zero) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatearTiempo() {
    final dias = _tiempoRestante.inDays;
    final horas = _tiempoRestante.inHours.remainder(24);
    final minutos = _tiempoRestante.inMinutes.remainder(60);
    final segundos = _tiempoRestante.inSeconds.remainder(60);

    if (dias > 0) {
      return '$dias días $horas:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}';
    } else {
      return '$horas:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColores.grisOscuro,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.5), width: 2),
      ),
      child: Column(
        children: [
          Text(
            widget.titulo,
            style: AppTextos.textoSecundario.copyWith(fontSize: 12),
          ),
          SizedBox(height: 8),
          Text(
            _tiempoRestante == Duration.zero ? "¡Ya disponible!" : _formatearTiempo(),
            style: AppTextos.tituloPrincipal.copyWith(
              fontSize: 24,
              color: Colors.red[400],
            ),
          ),
        ],
      ),
    );
  }
}