import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Pantalla1.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';

class Pantalla4 extends StatelessWidget {
  const Pantalla4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: AppColores.fondoNegro,
        elevation: 0,
        title: Text(
          "Dragon Ball Z",
          style: AppTextos.tituloAppBar,
        ),
      ),
      body: Vista(context),
    );
  }
}

Widget Vista(context) {
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
              "https://i.postimg.cc/Dy6fFw7d/dz.jpg",
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                Text(
                  "Dragon Ball Z",
                  style: AppTextos.tituloPrincipal,
                ),
                const SizedBox(height: 12),

            
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: AppDecoraciones.bordeClasificacion(),
                      child: Text("7+", style: AppTextos.textoMetadato),
                    ),
                    const SizedBox(width: 10),
                    Text("1989 - 1996",
                        style: AppTextos.textoSecundario),
                    const SizedBox(width: 10),
                    Text("9 Temporadas",
                        style: AppTextos.textoSecundario),
                  ],
                ),
                const SizedBox(height: 20),

         
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
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
                const SizedBox(height: 20),

               
                ContadorRegresivo(
                  fechaObjetivo: DateTime.now().add(
                    const Duration(days: 5, hours: 6),
                  ),
                  titulo: "Próximo episodio en:",
                ),
                const SizedBox(height: 20),

                
                Text(
                  "Dragon Ball Z continúa la historia de Goku, "
                  "quien junto a sus amigos protege la Tierra de "
                  "enemigos poderosos como los Saiyajin, Freezer, "
                  "Cell y Majin Boo. Las intensas batallas y "
                  "transformaciones legendarias definen esta saga.",
                  style: AppTextos.textoNormal,
                ),
                const SizedBox(height: 20),

               
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    GeneroChip("Acción"),
                    GeneroChip("Anime"),
                    GeneroChip("Shonen"),
                    GeneroChip("Artes Marciales"),
                    GeneroChip("Fantasía"),
                  ],
                ),
                const SizedBox(height: 30),

              
                InfoRow("Creador:", "Akira Toriyama"),
                const SizedBox(height: 8),
                InfoRow("Estudio:", "Toei Animation"),
                const SizedBox(height: 8),
                InfoRow("Basado en:", "Manga Dragon Ball"),
                Recomendado(context)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
