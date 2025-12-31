import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Pantalla1.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/minR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';
import 'package:video_player/video_player.dart';

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
                Text("Sakamoto Days", style: AppTextos.tituloPrincipal),
                const SizedBox(height: 12),

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
                  fechaObjetivo: DateTime.now().add(const Duration(days: 5)),
                  titulo: "Estreno en:",
                ),
                const SizedBox(height: 20),
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
  late VideoPlayerController _controller;

  final String videoUrl =
      "https://www.dropbox.com/scl/fi/5rw4c2gmhexb8b0x97pgg/WhatsApp-Video-2025-12-30-at-6.14.27-PM.mp4?rlkey=79h08d83cx9cw7bw3zp943u4q&st=92shzj0n&raw=1";

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