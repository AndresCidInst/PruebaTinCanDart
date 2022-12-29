import 'package:proyecto_prueba_1/main.dart';
import 'package:tincan/tincan.dart';

class LrsUtils {
  //Código de prueba
  //Objetos sacados de los objetos sacados de la LRS de veracity
  static Activity templateActivityInstace() {
    return Activity(
      id: "https://www.coursera.org/specializations/jhu-data-science/3",
      definition: ActivityDefinition(
        type: "http://adlnet.gov/expapi/activities/lesson",
        name: {"en-US": "Getting and Cleaning Data"},
        description: {"en-US": "Getting and Cleaning Data"},
      ),
    );
  }

  static Agent templateAgentInstance() {
    return Agent(
        name: "Lindsy Dael",
        account: AgentAccount(
            homePage: "http://lms.veracity.it",
            name: "76105110100115121326897101108"));
  }

  static Verb templateVerbInstance() {
    return Verb(
      id: "http://adlnet.gov/expapi/verbs/scored",
      display: {"en-US": "scored"},
    );
  }

  static Result templateResultInstace() {
    return Result(
      duration: TinCanDuration.fromParts(hours: "23"),
      /*
      response: "i think that it's save, isn't it?",
      completion: true,
      //problema, la propiedad score envía todos los parámetros a pesar de no estar definidos
      score: Score(min: 0, max: 25, raw: 20, scaled: 0.8),
      */
      extensions:
          Extensions({"http://id.tincanapi.com/extension/ending-point": 36}),
    );
  }

  static Result resultOnlyScore(int finalScore, int min, int max) {
    return Result(
        score: Score(
            raw: finalScore, min: min, max: max, scaled: finalScore / max));
  }
}
