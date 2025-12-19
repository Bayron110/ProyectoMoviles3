import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: AppColores.fondoNegro,
        elevation: 0,
        title: Text(
          "My Hero Academia Vigilantes",
          style: AppTextos.tituloAppBar,
        ),
      ),
      body: Vista(),
    );
  }
}

Widget Vista() {
  return SingleChildScrollView(
    child: Container(
      decoration: AppDecoraciones.fondoNegro(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: AppDecoraciones.imagenConGradiente(
              "https://i.postimg.cc/Qx54tMXM/latest-cb-20210104051630-path-prefix-es.webp",
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  "My Hero Academia: Vigilantes",
                  style: AppTextos.tituloPrincipal,
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: AppDecoraciones.bordeClasificacion(),
                      child: Text("13+", style: AppTextos.textoMetadato),
                    ),
                    SizedBox(width: 10),
                    Text("2016 - 2022", style: AppTextos.textoSecundario),
                    SizedBox(width: 10),
                    Text("6 Temporadas", style: AppTextos.textoSecundario),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: ()=>(),
                        icon: Icon(
                          Icons.play_arrow,
                          color: AppColores.textoBotonPrimario,
                        ),
                        label: Text(
                          "Reproducir",
                          style: AppTextos.textoBotonPrimario,
                        ),
                        style: AppDecoraciones.botonPrimario(),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: ()=>(),
                        icon: Icon(Icons.add, color: AppColores.blanco),
                        label: Text(
                          "Mi lista",
                          style: AppTextos.textoBotonSecundario,
                        ),
                        style: AppDecoraciones.botonSecundario(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                ContadorRegresivo(
                  fechaObjetivo: DateTime.now().add(
                    Duration(days: 7, hours: 3),
                  ),
                  titulo: "Nuevo episodio en:",
                ),
                SizedBox(height: 20),

                Text(
                  "My Hero Academia: Vigilantes sigue la historia de Koichi Haimawari, "
                  "un joven sin licencia de héroe que ayuda a la gente en secreto. "
                  "Junto a sus amigos Pop☆Step y Knuckleduster, enfrentan villanos "
                  "y desafíos mientras descubren una conspiración más grande que "
                  "amenaza la sociedad de héroes.",
                  style: AppTextos.textoNormal,
                ),
                SizedBox(height: 20),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    GeneroChip("Acción"),
                    GeneroChip("Anime"),
                    GeneroChip("Shonen"),
                    GeneroChip("Superhéroes"),
                  ],
                ),
                SizedBox(height: 30),

                InfoRow("Creador:", "Hideyuki Furuhashi"),
                SizedBox(height: 8),
                InfoRow("Estudio:", "Bones"),
                SizedBox(height: 8),
                InfoRow("Basado en:", "My Hero Academia de Kōhei Horikoshi"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}