import 'package:flutter/material.dart';
import 'package:proyecto_prueba_1/app/controllers/LrsController.dart';
import 'package:proyecto_prueba_1/app/domain/entities/PressOnPlay.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';

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
  PressOnPlay press = PressOnPlay(0, 10);

  void _incrementCounter() {
    setState(() {
      press.incrementCounter();
    });
  }

  void _saveRecordTemplate() {
    LrsController.captureRecordTemplate();
  }

  void _saveRecordResult(String verb, String activity) async {
    LrsController.captureRecordResult(
        LrsUtils().buildVerb("en-US", verb),
        LrsUtils.templateAgentInstance(),
        LrsUtils().buildActivity(activity),
        press, "Press de button to win");
  }
 /*
  void _totalPresionados() {
    LrsController.capturePoints(press.counter, 10, 0);
   }

  void _retrieveRecod(String id) {
    Statement record = LrsController.retrieveStatementById(id);
    (record != null) ? print(record.actor!.account) : print(" No hay registro");
  }
  */

  //Widgets

  void _alertaNoInicio(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
                "Debes precionar iniciar el contador para pecionar este boton"),
            actions: [
              TextButton(
                  onPressed: Navigator.of(context).pop, child: const Text("Ok"))
            ],
          );
        }));
  }

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
                    onPressed: (() => _saveRecordTemplate),
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
                        if (press.start.year == 2000) press.setStart(DateTime.now());
                        if (press.counter > 9) {
                          press.setEnd(DateTime.now());
                          press.moreExperiencePerLvl();
                          _saveRecordResult("Press", "PressToWin");
                          press.counter = 0;
                        }
                        _incrementCounter();
                      },
                      icon: const Icon(
                        Icons.touch_app_outlined,
                        color: Colors.white,
                      ),
                      label: const Text("Presioname"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        if (press.start.year != 2000) {
                          press.setEnd(DateTime.now());
                          _saveRecordResult("Press", "PressOnPLay");
                          press.counter=0;
                          _incrementCounter();
                        } else {
                          _alertaNoInicio(context);
                        }
                      },
                      child: const Text("Dejar de precionar"),
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
                  Text("Cantidad de veces precionado: ${press.counter}"),

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
                children: [
                  if (press.counter == 10) const Text("Lo has logrado :D")
                ],
              )
            ]));
  }
}
