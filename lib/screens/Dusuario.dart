import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:proyecto_moviles3/screens/login.dart';

class DatosUsuario extends StatefulWidget {
  const DatosUsuario({super.key});

  @override
  State<DatosUsuario> createState() => _DatosUsuarioState();
}

class _DatosUsuarioState extends State<DatosUsuario> {
  final TextEditingController comentarioController = TextEditingController();
  final DatabaseReference comentariosRef =
      FirebaseDatabase.instance.ref("Comentarios");

  final User? usuario = FirebaseAuth.instance.currentUser;


  Future<void> agregarComentario() async {
    if (comentarioController.text.trim().isEmpty || usuario == null) return;

    await comentariosRef.push().set({
      "comentario": comentarioController.text.trim(),
      "uid": usuario!.uid,
      "nombre": usuario!.email!.split('@')[0],
      "correo": usuario!.email,
      "fecha": DateTime.now().toString(),
    });

    comentarioController.clear();
  }

  Future<void> eliminarComentario(String key) async {
    await comentariosRef.child(key).remove();
  }

  void editarComentario(String key, String textoActual) {
    final controller = TextEditingController(text: textoActual);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar comentario"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              await comentariosRef.child(key).update({
                "comentario": controller.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (usuario == null) {
      return const Scaffold(
        body: Center(child: Text("No hay usuario logeado")),
      );
    }

    return Scaffold(
      appBar: appBarPrincipal(),
      body: Column(
        children: [
          perfilUsuario(usuario!),
          cajaComentario(),
          const SizedBox(height: 10),
          listaComentarios(),
        ],
      ),
    );
  }


  AppBar appBarPrincipal() {
    return AppBar(
      title: const Text("Perfil"),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: cerrarSesion,
        ),
      ],
    );
  }

  Widget perfilUsuario(User usuario) {
    final inicial = usuario.email![0].toUpperCase();

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.blue,
          child: Text(
            inicial,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        title: Text(
          usuario.email!.split('@')[0],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(usuario.email!),
      ),
    );
  }

  Widget cajaComentario() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: comentarioController,
        decoration: InputDecoration(
          labelText: "Escribe un comentario",
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: agregarComentario,
          ),
        ),
      ),
    );
  }

  Widget listaComentarios() {
    return Expanded(
      child: StreamBuilder(
        stream: comentariosRef.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No hay comentarios"));
          }

          final Map<dynamic, dynamic> data =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          final comentarios = data.entries.toList();

          return ListView.builder(
            itemCount: comentarios.length,
            itemBuilder: (context, index) {
              final key = comentarios[index].key;
              final comentario = comentarios[index].value;

              final esDuenio = comentario["uid"] == usuario!.uid;

              return tarjetaComentario(
                key: key,
                comentario: comentario,
                esDuenio: esDuenio,
              );
            },
          );
        },
      ),
    );
  }

  Widget tarjetaComentario({
    required String key,
    required Map comentario,
    required bool esDuenio,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(comentario["nombre"][0].toUpperCase()),
        ),
        title: Text(comentario["comentario"]),
        subtitle: Text(
          "${comentario["nombre"]} • ${comentario["fecha"]}",
        ),
        trailing: esDuenio
            ? PopupMenuButton(
                itemBuilder: (_) => const [
                  PopupMenuItem(value: "editar", child: Text("Editar")),
                  PopupMenuItem(value: "eliminar", child: Text("Eliminar")),
                ],
                onSelected: (value) {
                  if (value == "editar") {
                    editarComentario(key, comentario["comentario"]);
                  } else {
                    eliminarComentario(key);
                  }
                },
              )
            : null,
      ),
    );
  }
}
