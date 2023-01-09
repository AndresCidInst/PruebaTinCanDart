import 'package:proyecto_prueba_1/LRSconnector.dart' show LrsConnector;
import 'package:proyecto_prueba_1/app/domain/entities/PressOnPlay.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';
import 'package:tincan/tincan.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
  
  static void captureRecordVIdeoTemplate(){
    LrsConnector().saveRegister(
    Statement(
      object: LrsUtils().buildActivity("WatchTheLesson"),
      verb: LrsUtils().buildVerb("en-US", "Watch"),
      result: LrsUtils.templateResultVideo()
    ), LrsUtils.templateAgentInstance());
  }

  static void capturePoints(int counter, int maxPoint, int minPoint) {
    final statement = Statement(
        verb: LrsUtils.templateVerbInstance(),
        object: LrsUtils.templateActivityInstace(),
        result: LrsUtils.resultOnlyScore(counter, minPoint, maxPoint));

    LrsConnector().saveRegister(statement, LrsUtils.templateAgentInstance());
  }

  static void captureRecordResult(Verb verb, Agent agent, Activity activity, result, String? response) async {
    //Llama valores desde la vista para hacer la construccion y armado del statement
    if(result.runtimeType == PressOnPlay) {
      LrsConnector().saveRegister(
          Statement(verb: verb, object: activity, result: LrsUtils.buildFullResultPress(result, response)), agent);
    }else if (result.runtimeType == YoutubePlayerController){

      Result retrieveResult = Result();
      await LrsUtils.buildFullResultVideo(result, response)
          .then((value) => retrieveResult = value);

      LrsConnector().saveRegister(
          Statement(
              verb: verb,
              object: activity,
              result: retrieveResult
          ), agent);
    }
  }

  static void captureRecord(Verb verb, Agent agent, Activity activity){
    LrsConnector().saveRegister(Statement(
        verb: verb,
        object: activity
    ), agent);
  }


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
