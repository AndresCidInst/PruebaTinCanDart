import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../domain/entities/PressOnPlay.dart';
import 'package:tincan/tincan.dart';

class LrsUtils {
  String verbProvider = "https://ww.ejemplo.cl/verbs/";
  String activityProvider = "https://ww.ejemplo.cl/activities/";

  //Código de prueba
  //Objetos sacados de los objetos sacados de la LRS de veracity
  static Activity templateActivityInstace() {
    return Activity(
      id: "https://www.coursera.org/specializations/jhu-data-science/3",
      definition: ActivityDefinition(
        type: "https://adlnet.gov/expapi/activities/lesson",
        name: {"en-US": "Getting and Cleaning Data"},
        description: {"en-US": "Getting and Cleaning Data"},
      ),
    );
  }

  static Agent templateAgentInstance() {
    return Agent(
        name: "Lindsy Dael",
        account: AgentAccount(
            homePage: "https://lms.veracity.it",
            name: "76105110100115121326897101108"));
  }

  static Verb templateVerbInstance() {
    return Verb(
      id: "https://adlnet.gov/expapi/verbs/scored",
      display: {"en-US": "scored"},
    );
  }

  static Result buildFullResultVideoTemplate(
      Duration duration, DateTime start, DateTime end) {
    return Result(
        duration: TinCanDuration.fromDuration(duration),
        extensions:
            Extensions({"https://ejemlos.cl/extension/Video/Start": "}"}));
  }

  static Result templateResultVideo() {
    return Result(
        duration: TinCanDuration.fromDuration(const Duration(minutes: 2)),
        completion: null);
  }

  //Seccion de los métidos del atributo "Activity"
  Activity buildActivity(String activityName) {
    return Activity(id: activityProvider + activityName);
  }

  Activity buildActivityWithDefinition(
      String activityId, String type, String name, String language) {
    return Activity(
        id: activityProvider + activityId,
        definition: ActivityDefinition(type: type, name: {language: name}));
  }

  //seccion de los métodos del atributo "Verb"
  Verb buildVerb(String idiom, String verb) {
    return Verb(id: verbProvider + verb, display: {idiom: verb});
  }

  //Seccion de de los métodos del atributo "Result"

  static Result templateResultInstace() {
    return Result(
      duration: TinCanDuration.fromParts(days: "2", hours: "23", months: "1"),
      //Breve texto adicional al resultado

      response: "i think that it's save, isn't it?",
      completion: true,
      //problema, la propiedad score envía todos los parámetros a pesar de no estar definidos
      score: Score(min: 0, max: 25, raw: 20, scaled: 0.8),
      extensions:
          Extensions({"https://id.tincanapi.com/extension/ending-point": 36}),
    );
  }

  static Result buildFullResultPress(
      PressOnPlay pointResult, String? response) {
    return Result(
        duration: TinCanDuration.fromDiff(pointResult.start, pointResult.end),
        response: response,
        completion: confirmComplete(pointResult),
        success: confirmComplete(pointResult),
        score:
            buildScore(pointResult.counter, pointResult.min, pointResult.max),
        extensions: Extensions({
          "https://ejemlos.cl/extension/PointOnPress/lvl": pointResult.lvl,
          "https://ejemlos.cl/extension/PointOnPress/experienceGained":
              "${pointResult.experience}/${pointResult.requireExperiencie}"
        })
        //Si en la mismo atributo extends hay más de una extencion, el LRS solo deja una, independiente si tienen mismos valores o no
        /*
            "https://ejemlos.cl/extension/PointOnPress/experienceGained":"${pointResult.experience}/${pointResult.requireExperiencie}",
            "https://ejemlos.cl/extension/PointOnPress/experienceGained":"${pointResult.experience}/${pointResult.requireExperiencie}",
            "https://ejemlos.cl/extension/PointOnPress/experienceGained":"${pointResult.experience}/${pointResult.requireExperiencie}",
            "https://ejemlos.cl/extension/PointOnPress/experienceGained":"${pointResult.experience}/${pointResult.requireExperiencie}",
            "https://ejemlos.cl/extension/PointOnPress/experienceGained":"${pointResult.experience}/${pointResult.requireExperiencie}"}),
        {"":"${pointResult.counter}/${pointResult.requireExperiencie}"}*/
        );
  }

  static Result resultOnlyScore(int finalScore, int min, int max) =>
      Result(score: buildScore(finalScore, min, max));

  static Future<Result> buildFullResultVideo(
      YoutubePlayerController result, String? response) async {
    //Obtiene los valores de tiempo visto del video, la dutación del video y si lo vio sin audio, respectivamente
    int passedTime = await result.currentTime.then((value)
        async => Duration(seconds: value.toInt()).inSeconds);
    int videoDuration = await result.duration
        .then((value) => Duration(seconds: value.toInt()).inSeconds);

    return Result(
        duration: TinCanDuration.fromDuration(Duration(seconds: videoDuration)),
        completion: result.duration == result.currentTime,
        response: response,
        score: buildScore(passedTime, 0, videoDuration));
  }

  //Herramientas para el atributo Result
  static bool confirmComplete(PressOnPlay pointResult) =>
      pointResult.max == pointResult.counter;

  static Score buildScore(int finalScore, int min, max) {
    return Score(raw: finalScore, min: min, max: max, scaled: finalScore / max);
  }
}
