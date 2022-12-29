import 'package:proyecto_prueba_1/LRSconnector.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';
import 'package:tincan/tincan.dart';

class LrsController {
  static void captureRecordTemplate() {
    //Creador de statement
    final statement = Statement(
        verb: LrsUtils.templateVerbInstance(),
        object: LrsUtils.templateActivityInstace(),
        result: LrsUtils.templateResultInstace());

    //Llama a la clase encargada de hacerr la conección con la LRS
    //y llamada al método construido para realizar el registro
    LrsConnector().saveRegister(statement, LrsUtils.templateAgentInstance());
  }

  static void capturePoints(int counter, int maxPoint, int minPoint) {
    final statement = Statement(
        verb: LrsUtils.templateVerbInstance(),
        object: LrsUtils.templateActivityInstace(),
        result: LrsUtils.resultOnlyScore(counter, minPoint, maxPoint));

    LrsConnector().saveRegister(statement, LrsUtils.templateAgentInstance());
  }

  static void captureRecord() {}
  /*
  static retrieveStatementById(String id) {

    final statement = LrsConnector().retrieveStatement(id);

    Statement savedStatement = Statement();

    statement.then((value) => {savedStatement = value.data!});
    print(savedStatement);
    return savedStatement;
  }
  */
}
