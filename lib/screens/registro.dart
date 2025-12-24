import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/login.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController usuario = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasenia = TextEditingController();
  final TextEditingController confirmar = TextEditingController();

  void registrar() {
    if (usuario.text.isEmpty ||
        correo.text.isEmpty ||
        contrasenia.text.isEmpty ||
        confirmar.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    if (contrasenia.text != confirmar.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro exitoso 🎉')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.postimg.cc/tCrTLPT8/retrato-personaje-anime-estrellas-23-2151556349.avif',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Registro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: usuario,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                TextField(
                  controller: correo,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                TextField(
                  controller: contrasenia,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                TextField(
                  controller: confirmar,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: ()=>registro(usuario, contrasenia, confirmar, correo, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text('Registrarse'),
                ),
                Text(""),
                ElevatedButton(
                  onPressed: ()=>irLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text('Iniciar Sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> registro(usuario, contrasenia, confirmar, correo, context) async {
  if (usuario != null) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Usuarios/");

    await ref.push().set({
      "Nombre": usuario.text,
      "Correo": correo.text,
    });

    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Éxito"),
          content: const Text("Registro realizado exitosamente"),
        );
      },
    );

    if (correo != null && contrasenia != null) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: correo.text,
          password: contrasenia.text,
        );
         Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('La contraseña es demasiado débil.');
        } else if (e.code == 'email-already-in-use') {
          print('Ya existe una cuenta con ese correo.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

void irLogin(context){
   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
}