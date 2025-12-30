import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecomendacionU extends StatefulWidget {
  const RecomendacionU({super.key});

  @override
  State<RecomendacionU> createState() => _RecomendacionUState();
}

class _RecomendacionUState extends State<RecomendacionU> {
  final nombre = TextEditingController();
  final genero = TextEditingController();
  final link = TextEditingController();

  final User? usuario = FirebaseAuth.instance.currentUser;
  final DatabaseReference ref =
      FirebaseDatabase.instance.ref("RecomendadosU");

  Future<void> enviar() async {
    if (usuario == null ||
        nombre.text.isEmpty ||
        genero.text.isEmpty ||
        link.text.isEmpty) return;

    await ref.push().set({
      "nombre": nombre.text.trim(),
      "genero": genero.text.trim(),
      "link": link.text.trim(),
      "likes": 0,
      "votos": {},
      "uid": usuario!.uid,
      "usuario": usuario!.email!.split('@')[0],
      "fecha": DateTime.now().toString(),
    });

    nombre.clear();
    genero.clear();
    link.clear();
  }

  Future<void> votar(String key, Map rec) async {
    if (usuario == null) return;

    Map votos = Map.from(rec["votos"] ?? {});
    int likes = rec["likes"] ?? 0;

    if (votos.containsKey(usuario!.uid)) {
      votos.remove(usuario!.uid);
      likes--;
    } else {
      votos[usuario!.uid] = true;
      likes++;
    }

    await ref.child(key).update({
      "likes": likes < 0 ? 0 : likes,
      "votos": votos,
    });
  }

  Future<void> eliminar(String key) async {
    await ref.child(key).remove();
  }

  void editar(String key, Map rec) {
    nombre.text = rec["nombre"];
    genero.text = rec["genero"];
    link.text = rec["link"];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar recomendación"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombre, decoration: const InputDecoration(labelText: "Anime")),
            TextField(controller: genero, decoration: const InputDecoration(labelText: "Género")),
            TextField(controller: link, decoration: const InputDecoration(labelText: "Link YouTube")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.child(key).update({
                "nombre": nombre.text,
                "genero": genero.text,
                "link": link.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  void reproducir(String url) {
    final id = YoutubePlayer.convertUrlToId(url);
    if (id == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoWidget(videoId: id),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recomendaciones de Anime")),
      body: Column(
        children: [
          formulario(),
          const Divider(),
          lista(),
        ],
      ),
    );
  }

  Widget formulario() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(controller: nombre, decoration: const InputDecoration(labelText: "Anime")),
          TextField(controller: genero, decoration: const InputDecoration(labelText: "Género")),
          TextField(controller: link, decoration: const InputDecoration(labelText: "Link YouTube")),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: enviar,
            icon: const Icon(Icons.send),
            label: const Text("Enviar"),
          ),
        ],
      ),
    );
  }

  Widget lista() {
    return Expanded(
      child: StreamBuilder(
        stream: ref.onValue,
        builder: (_, snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No hay recomendaciones"));
          }

          final Map data = snapshot.data!.snapshot.value as Map;
          final items = data.entries.toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final key = items[i].key;
              final rec = items[i].value;
              final esDuenio = rec["uid"] == usuario?.uid;
              final yaVoto = rec["votos"] != null &&
                  rec["votos"][usuario?.uid] == true;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.play_circle, size: 30),
                    onPressed: () => reproducir(rec["link"]),
                  ),
                  title: Text(rec["nombre"]),
                  subtitle: Text("${rec["genero"]} • ${rec["usuario"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          yaVoto ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () => votar(key, rec),
                      ),
                      Text("${rec["likes"]}"),
                      if (esDuenio)
                        PopupMenuButton(
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: "edit", child: Text("Editar")),
                            PopupMenuItem(value: "delete", child: Text("Eliminar")),
                          ],
                          onSelected: (v) {
                            if (v == "edit") editar(key, rec);
                            if (v == "delete") eliminar(key);
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class VideoWidget extends StatefulWidget {
  final String videoId;
  const VideoWidget({super.key, required this.videoId});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Reproduciendo"),
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

