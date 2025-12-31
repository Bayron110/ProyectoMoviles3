import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Pantalla1.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/minR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';
import 'package:video_player/video_player.dart';

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
class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  final String videoUrl =
      "https://www.dropbox.com/scl/fi/606clcc91ejkv35ud1f0v/WhatsApp-Video-2025-12-30-at-6.10.27-PM.mp4?rlkey=j0rjqpklnu1731ni1e3n7pguw&st=7sxt8tai&raw=1";

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void minimizarVideo() {
    MiniPlayer.mostrarVideo(context, videoUrl);
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
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}