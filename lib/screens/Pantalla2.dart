import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/Pantalla1.dart';
import 'package:proyecto_moviles3/styles/colores.dart';
import 'package:proyecto_moviles3/styles/decoracion.dart';
import 'package:proyecto_moviles3/styles/textos.dart';
import 'package:proyecto_moviles3/widgets/contadorR.dart';
import 'package:proyecto_moviles3/widgets/minR.dart';
import 'package:proyecto_moviles3/widgets/widgets_Pantalla1/informacionP1.dart';
import 'package:video_player/video_player.dart';

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoNegro,
      appBar: AppBar(
        backgroundColor: AppColores.fondoNegro,
        elevation: 0,
        title: Text("Tobe Hero X", style: AppTextos.tituloAppBar),
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
              'https://i.postimg.cc/NFBFW7N3/Tobe-X-Hero.jpg',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("TOBE HERO X", style: AppTextos.tituloPrincipal),
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: AppDecoraciones.bordeClasificacion(),
                      child: Text("16+", style: AppTextos.textoMetadato),
                    ),
                    SizedBox(width: 10),
                    Text("2016 - 2025", style: AppTextos.textoSecundario),
                    SizedBox(width: 10),
                    Text("3 temporadas", style: AppTextos.textoSecundario),
                  ],
                ),
                SizedBox(height: 20),
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
                    SizedBox(width: 10),
                    
                  ],
                ),
                SizedBox(height: 20),
                ContadorRegresivo(
                  fechaObjetivo: DateTime.now().add(
                    Duration(days: 32, hours: 15),
                  ),
                  titulo: "Nuevo Temporada en: ",
                ),
                SizedBox(height: 20),
                Text(
                  "En una sociedad futurista marcada por desigualdades y corrupción, surge una nueva generación de héroes que deben enfrentarse no solo a poderosos enemigos, "
                  " sino también a las sombras de sus propios traumas y decisiones. La historia sigue a un protagonista que recibe un poder extraordinario, pero pronto descubre "
                  " que ser héroe implica sacrificios devastadores."
                  "La serie combina acción intensa, ciencia ficción y drama psicológico, mostrando un mundo donde los héroes son cuestionados y la línea entre justicia y venganza "
                  " se vuelve difusa. Con una estética que recuerda a Arcane y una narrativa que mezcla tragedia y crítica social, To Be Hero X se distancia del tono cómico de las "
                  " primeras temporadas para ofrecer una experiencia más madura y perturbadora.",
                  style: AppTextos.textoNormal,
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    GeneroChip("Acción"),
                    GeneroChip("Ciencia Ficción"),
                    GeneroChip("Tragedia"),
                    GeneroChip("Drama"),
                    GeneroChip("Psicológico"),
                  ],
                ),
                SizedBox(height: 30,),
                InfoRow("Creador", "Li Haoling"),
                SizedBox(height: 8),
                InfoRow("Estudio:", "Pb Animation Co. Ltd., Studio LAN, Paper Plane Animation Studio"),
                SizedBox(height: 8),
                InfoRow("Basado en:", "Historia 100% Original con ecenas de Violencia"),
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
      "https://www.dropbox.com/scl/fi/cynwuqrka8ithdxmx9ntr/WhatsApp-Video-2025-12-30-at-6.00.07-PM.mp4?rlkey=azlamc7hp005t58xslin19uwt&st=c9cwj4st&raw=1";

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

