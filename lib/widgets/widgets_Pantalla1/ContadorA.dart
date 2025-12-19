import 'dart:async';
import 'package:flutter/material.dart';


class ContadorAnimado extends StatefulWidget {
  final int segundosIniciales;
  final VoidCallback? onTerminar;
  
  const ContadorAnimado({
    super.key,
    required this.segundosIniciales,
    this.onTerminar,
  });

  @override
  State<ContadorAnimado> createState() => _ContadorAnimadoState();
}

class _ContadorAnimadoState extends State<ContadorAnimado> 
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  late int _segundosRestantes;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _segundosRestantes = widget.segundosIniciales;
    
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _iniciarTimer();
  }

  void _iniciarTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_segundosRestantes > 0) {
        setState(() {
          _segundosRestantes--;
        });
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
      } else {
        timer.cancel();
        if (widget.onTerminar != null) {
          widget.onTerminar!();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutos = _segundosRestantes ~/ 60;
    final segundos = _segundosRestantes % 60;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[900]!, Colors.red[700]!],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, color: Colors.white, size: 20),
          SizedBox(width: 8),
          ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              '${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}