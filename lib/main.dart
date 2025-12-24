import 'package:flutter/material.dart';
import 'package:proyecto_moviles3/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const HoshiPlay());
}

class HoshiPlay extends StatelessWidget {
  const HoshiPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      
    );
  }  
}
