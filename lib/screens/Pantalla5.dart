import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Pantalla1.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';

class Pantalla5 extends StatelessWidget {
  const Pantalla5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: AppColores.fondoNegro,
        elevation: 0,
        title: Text(
          "RE:ZERO - Empezar de cero en otro mundo",
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
              "https://i.postimg.cc/Rhj7ZL1r/zero.jpg",
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(
                  "RE:ZERO - Empezar de cero en otro mundo",
                  style: AppTextos.tituloPrincipal,
                ),
                const SizedBox(height: 12),

               
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: AppDecoraciones.bordeClasificacion(),
                      child: Text("16+", style: AppTextos.textoMetadato),
                    ),
                    const SizedBox(width: 10),
                    Text("2016 - Presente", style: AppTextos.textoSecundario),
                    const SizedBox(width: 10),
                    Text("2 Temporadas + OVAs", style: AppTextos.textoSecundario),
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
                    const Duration(days: 3, hours: 4),
                  ),
                  titulo: "Próximo episodio en:",
                ),
                const SizedBox(height: 20),

                Text(
                  "RE:ZERO sigue la historia de Subaru Natsuki, "
                  "un joven que es transportado a un mundo fantástico. "
                  "Descubre que tiene la habilidad de regresar en el tiempo "
                  "cada vez que muere, y utiliza este poder para proteger "
                  "a sus amigos y enfrentar peligros mortales. "
                  "Entre traiciones, misterios y emociones intensas, "
                  "Subaru lucha por sobrevivir y cambiar su destino.",
                  style: AppTextos.textoNormal,
                ),
                const SizedBox(height: 20),

            
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    GeneroChip("Acción"),
                    GeneroChip("Anime"),
                    GeneroChip("Fantasía"),
                    GeneroChip("Drama"),
                    GeneroChip("Suspenso"),
                  ],
                ),
                const SizedBox(height: 30),

                InfoRow("Creador:", "Tappei Nagatsuki"),
                const SizedBox(height: 8),
                InfoRow("Estudio:", "White Fox"),
                const SizedBox(height: 8),
                InfoRow("Basado en:", "Novela ligera RE:ZERO"),
                Recomendado(context)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
