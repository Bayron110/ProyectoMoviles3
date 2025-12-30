import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Pantalla1.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/minR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Pantalla6 extends StatelessWidget {
  const Pantalla6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: AppColores.fondoNegro,
        elevation: 0,
        title: Text("Sakamoto Days", style: AppTextos.tituloAppBar),
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
          // Imagen principal
          Container(
            width: double.infinity,
            height: 400,
            decoration: AppDecoraciones.imagenConGradiente(
              "https://i.postimg.cc/y8Kfh7Rj/saka.webp",
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text("Sakamoto Days", style: AppTextos.tituloPrincipal),
                const SizedBox(height: 12),

                // Metadatos
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: AppDecoraciones.bordeClasificacion(),
                      child: Text("16+", style: AppTextos.textoMetadato),
                    ),
                    const SizedBox(width: 10),
                    Text("2025", style: AppTextos.textoSecundario),
                    const SizedBox(width: 10),
                    Text("1 Temporada", style: AppTextos.textoSecundario),
                  ],
                ),
                const SizedBox(height: 20),

                // Botones
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoWidget(),
                            ),
                          );
                        },
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

                // Contador
                ContadorRegresivo(
                  fechaObjetivo: DateTime.now().add(const Duration(days: 5)),
                  titulo: "Estreno en:",
                ),
                const SizedBox(height: 20),

                // Descripción
                Text(
                  "Sakamoto Days narra la historia de Taro Sakamoto, "
                  "un legendario asesino a sueldo que decide retirarse "
                  "para llevar una vida tranquila junto a su familia. "
                  "Sin embargo, su pasado no tarda en alcanzarlo, "
                  "obligándolo a proteger su paz cotidiana mientras "
                  "enfrenta a antiguos enemigos con increíbles escenas "
                  "de acción y comedia.",
                  style: AppTextos.textoNormal,
                ),
                const SizedBox(height: 20),

                // Géneros
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    GeneroChip("Acción"),
                    GeneroChip("Anime"),
                    GeneroChip("Comedia"),
                    GeneroChip("Shōnen"),
                  ],
                ),
                const SizedBox(height: 30),

                InfoRow("Creador:", "Yuto Suzuki"),
                const SizedBox(height: 8),
                InfoRow("Estudio:", "TMS Entertainment"),
                const SizedBox(height: 8),
                InfoRow("Basado en:", "Manga Sakamoto Days"),
                Recomendado(context),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  late String videoId;

  @override
  void initState() {
    super.initState();

    videoId = YoutubePlayer.convertUrlToId(
      "https://www.youtube.com/watch?v=xgCxY0qWRC4",
    )!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  void minimizarVideo() {
    MiniPlayer.mostrar(context, videoId);
    Navigator.pop(context);
  }

  void cerrarVideo() {
    _controller.pause();
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          onPressed: minimizarVideo,
        ),
        title: const Text(
          "Reproduciendo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: cerrarVideo,
          ),
        ],
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}
