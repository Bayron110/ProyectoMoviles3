import 'package:flutter/material.dart';

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("My Hero Acadenia Vigilantes"),),
      body: Vista(),
    );
  }
}
Widget Vista() {
  return Container(
    decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1)),
    child: Center(   
      child: Container(
        width: 300,   
        height: 400,  
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://static.wikia.nocookie.net/bokunoheroacademia/images/a/ab/Volumen_1_Vigilantes.png/revision/latest?cb=20210104051630&path-prefix=es"
            ),
            fit: BoxFit.contain, 
          ),
        ),
      ),
    ),
  );
}