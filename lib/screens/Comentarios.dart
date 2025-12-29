import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Comentarios extends StatefulWidget {
  const Comentarios({super.key});

  @override
  State<Comentarios> createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseReference ref =
      FirebaseDatabase.instance.ref().child("Comentarios");

  User? usuario = FirebaseAuth.instance.currentUser;

  void agregarComentario() async {
    if (_controller.text.isEmpty) return;

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Debes iniciar sesión para comentar")),
      );
      return;
    }

    await ref.push().set({
      "texto": _controller.text,
      "uid": usuario!.uid,
      "email": usuario!.email,
      "fecha": DateTime.now().toString(),
    });

    _controller.clear();
  }

  void eliminarComentario(String key) async {
    await ref.child(key).remove();
  }

  void editarComentario(String key, String textoActual) {
    final TextEditingController editController =
        TextEditingController(text: textoActual);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar comentario"),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Guardar"),
            onPressed: () async {
              await ref.child(key).update({
                "texto": editController.text,
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comentarios")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Escribe un comentario",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: agregarComentario,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text("No hay comentarios"));
                }

                final data = Map<String, dynamic>.from(
                    snapshot.data!.snapshot.value as Map);

                final keys = data.keys.toList().reversed.toList();

                return ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    final comentario = data[key];

                    final bool esAutor =
                        usuario != null && usuario!.uid == comentario["uid"];

                    return Card(
                      child: ListTile(
                        title: Text(comentario["texto"]),
                        subtitle:
                            Text("${comentario["email"]} • ${comentario["fecha"]}"),
                        trailing: esAutor
                            ? PopupMenuButton(
                                itemBuilder: (_) => [
                                  const PopupMenuItem(
                                    value: "editar",
                                    child: Text("Editar"),
                                  ),
                                  const PopupMenuItem(
                                    value: "eliminar",
                                    child: Text("Eliminar"),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == "editar") {
                                    editarComentario(
                                        key, comentario["texto"]);
                                  } else {
                                    eliminarComentario(key);
                                  }
                                },
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
