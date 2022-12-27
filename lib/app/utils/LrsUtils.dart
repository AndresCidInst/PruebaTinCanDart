import 'package:proyecto_prueba_1/main.dart';
import 'package:tincan/tincan.dart';

class LrsUtils {
  //Código de prueba
  //Objetos sacados del readme del repositorio https://github.com/jblough/TinCanDart
  instanciaActivdadPlanilla() {
    return Activity(
      id: "https://www.coursera.org/specializations/jhu-data-science/3",
      definition: ActivityDefinition(
        type: "http://adlnet.gov/expapi/activities/lesson",
        name: {"en-US": "Getting and Cleaning Data"},
        description: {"en-US": "Getting and Cleaning Data"},
      ),
    );
  }

  instanciaAgentePlanilla() {
    return Agent(
        name: "Lindsy Dael",
        account: AgentAccount(
            homePage: "http://lms.veracity.it",
            name: "76105110100115121326897101108"));
  }

  instanciaVerboPlanilla() {
    return Verb(
      id: "http://adlnet.gov/expapi/verbs/scored",
      display: {"en-US": "scored"},
    );
  }
}