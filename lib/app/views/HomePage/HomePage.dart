import 'package:flutter/material.dart';
import 'package:proyecto_prueba_1/app/controllers/LrsController.dart';
import 'package:proyecto_prueba_1/app/domain/entities/PressOnPlay.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

  void _setCounterInit() {
    setState(() {
      press.counter = 0;
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
        press,
        "Press de button to win");
    press.setStart(DateTime(2000));
    press.setEnd(DateTime(2000));
  }

  void _saveRecordPress(String verb, String activity) async {
    LrsController.captureRecord(LrsUtils().buildVerb("en-US", verb),
        LrsUtils.templateAgentInstance(), LrsUtils().buildActivity(activity));
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: (){Navigator.pushNamed(context, '/video_viewer');},
                        child: const Text("Template de statement video"))
                  ]),
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
                        if (press.start.year == 2000) {
                          press.setStart(DateTime.now());
                          _saveRecordPress("Start", "PressOnWin");
                        }
                        if (press.counter > 9) {
                          press.setEnd(DateTime.now());
                          press.moreExperiencePerLvl();
                          _saveRecordResult("Press", "PressOnWin");
                          _setCounterInit();
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
                          _saveRecordPress("Finsh", "PressOnWin");
                          _setCounterInit();
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
