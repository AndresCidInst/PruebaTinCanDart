import 'package:proyecto_prueba_1/LRSconnector.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';
import 'package:tincan/tincan.dart';

class LrsController {
  void captureRegister() {
    //Creado de statement
    final statement = Statement(
        verb: LrsUtils().instanciaVerboPlanilla(),
        object: LrsUtils().instanciaActivdadPlanilla());
    LrsConnector()
        .saveRegister(statement, LrsUtils().instanciaAgentePlanilla());
  }
}
