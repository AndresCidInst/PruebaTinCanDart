import 'package:flutter/material.dart';
import 'package:proyecto_prueba_1/app/controllers/LrsController.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';
import 'package:tincan/tincan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _saveRegister() async {
    LrsController.captureRecordTemplate();
  }

  void totalPresionados() {
    LrsController.capturePoints(_counter, 10, 0);
  }

  /*
  void _retrieveRecod(String id) {
    Statement record = LrsController.retrieveStatementById(id);
    (record != null) ? print(record.actor!.account) : print(" No hay registro");
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Guardar Registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Guardar registro de plantilla"),
                  FloatingActionButton(
                    onPressed: _saveRegister,
                    child: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
              Row(
                children: const [SizedBox(height: 50)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Text("Pulse hasta 10 el botón")],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        if (_counter > 9) {
                          totalPresionados();
                          _counter = 0;
                        }
                        _incrementCounter();
                      },
                      icon: const Icon(
                        Icons.touch_app_outlined,
                        color: Colors.white,
                      ),
                      label: Text("Presioname"),
                    ),
                  ]),
              Row(
                children: const [
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Cantidad de veces precionado: $_counter"),

                  /*
          Row(children: [
            const Text("Llamar registro"),
            FloatingActionButton(
              onPressed: (() {
                _retrieveRecod("c9c9e162-42c6-4cb1-bcbb-1deb3991dee8");
              }),
              child: const Icon(Icons.add),
            )
          ])
          */
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [if (_counter == 10) const Text("Lo has logrado :D")],
              )
            ]));
  }
}
