import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';

class Pantalla3 extends StatelessWidget {
  const Pantalla3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: AppColores.fondoNegro,
        elevation: 0,
        title: Text(
          "Witch Watch",
          style: AppTextos.tituloAppBar,
        ),
      ),
      body: VistaPantalla3(context),
    );
  }
}

Widget VistaPantalla3(context) {
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
              "https://i.postimg.cc/1XR2YVH1/witch-watch-animate-fair-featuring-new-pajama-themed-v0-ifbdu7z6c5lf1.webp",
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Witch Watch",
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
                    Text("2022 - 2023", style: AppTextos.textoSecundario),
                    SizedBox(width: 10),
                    Text("1 Temporada", style: AppTextos.textoSecundario),
                  ],
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => (),
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
                        onPressed: () => (),
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
                  "Witch Watch sigue la historia de un joven mago que se ve envuelto en aventuras "
                  "mágicas junto a sus compañeros mientras enfrenta misterios y enemigos sobrenaturales. "
                  "Cada capítulo revela secretos sobre la sociedad mágica y su lucha por mantener la paz.",
                  style: AppTextos.textoNormal,
                ),
                SizedBox(height: 20),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    GeneroChip("Acción"),
                    GeneroChip("Comedia"),
                    GeneroChip("Fantástico"),
                    GeneroChip("Magia"),
                  ],
                ),
                SizedBox(height: 30),

                InfoRow("Creador:", "Toshihiko Tsukiji"),
                SizedBox(height: 8),
                InfoRow("Estudio:", "Satelight"),
                SizedBox(height: 8),
                InfoRow("Basado en:", "Manga Witch Watch"),
                SizedBox(height: 30),

                RecomendadoPantalla3(context),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<List> leerListaAnimes(context) async {
  final jsonString = await DefaultAssetBundle.of(
    context,
  ).loadString("assets/data/animes.json");
  return json.decode(jsonString)['animes'];
}

Widget RecomendadoPantalla3(context) {
  return FutureBuilder(
    future: leerListaAnimes(context),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        final random = Random();
        final listaMezclada = List.from(data)..shuffle(random);

        final seleccionados = listaMezclada.take(6).toList();

        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: seleccionados.length,
            itemBuilder: (context, index) {
              final item = seleccionados[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item['imagen'],
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 6),
                    Text(item['nombre'],
                        style: TextStyle(color: Colors.white)),
                    Text(
                      "Año: ${item['año_creacion']}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return Text(
          "No hay recomendados disponibles",
          style: TextStyle(color: Colors.white),
        );
      }
    },
  );
}
