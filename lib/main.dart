
import 'package:flutter/material.dart';
import 'package:proyecto_prueba_1/app/views/HomePage/HomePage.dart';
import 'package:proyecto_prueba_1/app/views/Video/VideoView.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // en el Widget FirstScreen
    initialRoute: "/",
    routes: {
      '/': (context) => MyHomePage(title: "Página de pruebas"),
      '/video_viewer': (context) => VideoView(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Página de pruebas",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Página de pruebas"),
    );
  }
}

