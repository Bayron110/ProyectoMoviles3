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
              "https://i.postimg.cc/Qx54tMXM/latest-cb-20210104051630-path-prefix-es.webp"
            ),
            fit: BoxFit.contain, 
          ),
        ),
      ),
    ),
  );
}