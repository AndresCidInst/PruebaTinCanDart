import 'package:proyecto_prueba_1/LRSconnector.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';
import 'package:tincan/tincan.dart';

class LrsController {
  void captureRegister() {
    //Creado de statement
    final statement = Statement(
        verb: LrsUtils().templateVerbInstance(),
        object: LrsUtils().templateActivityInstace());

    //Llama a la clase encargada de hacerr la conección con la LRS
    //y llamada al método construido para realizar el registro
    LrsConnector().saveRegister(statement, LrsUtils().templateAgentInstance());
  }
}
