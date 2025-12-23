import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_moviles3/screens/homes.dart';
import 'package:proyecto_moviles3/screens/registro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void login() {
    if (userController.text.isEmpty || passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bienvenido a AnimeApp 🍥')),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController correo = TextEditingController();
    TextEditingController contrasenia = TextEditingController();
    return Scaffold(
      body: Container(
        
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.postimg.cc/SN6KGWyf/preciosas-nubes-arte-digital-23-2151105777.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Anime Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: correo,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Correo',
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

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () => login2(correo, contrasenia,context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 234, 196, 196),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Entrar'),
              ),
              
              Text(""),
              ElevatedButton(
                onPressed: () => iraRegistro(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 238, 197, 197),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Registrase'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void iraRegistro(context){
  Navigator.push(context, 
  MaterialPageRoute(builder: (context) => Registro(),)
  );
}

Future<void> login2(correo, contrasenia, context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correo.text,
      password: contrasenia.text,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } on FirebaseAuthException catch (e) {
    String mensajeError = '';
    if (e.code == 'user-not-found') {
      mensajeError = 'No existe un usuario con ese correo.';
    } else if (e.code == 'wrong-password') {
      mensajeError = 'La contraseña es incorrecta.';
    } else {
      mensajeError = 'Error al iniciar sesión. Intenta nuevamente.';
    }

    showAboutDialog(
      context: context,
      applicationName: 'Error de Credenciales',
      children: [
        Text(mensajeError),
      ],
    );
  }
}
