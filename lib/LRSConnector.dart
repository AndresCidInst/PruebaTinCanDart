import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tincan/tincan.dart';

class LrsFeedback {
  final bool isError;
  final String? feedback;

  LrsFeedback({this.isError = false, this.feedback});
}

class LrsConnector {
  final _statementStream = BehaviorSubject<List<Statement>?>();
  final _feedback = StreamController<LrsFeedback>();
  Stream<LrsFeedback>? _feedbackBroadcast;

  /// Stream of statements retrieved from the LRS
  Stream<List<Statement>?> get statements => _statementStream.stream;

  /// Stream of responses from LRS operations
  Stream<LrsFeedback>? get feedback => _feedbackBroadcast;

  final _reportStatementController = StreamController<Statement>();

  /// Record a Statement on the LRS
  Function(Statement) get recordStatement =>
      _reportStatementController.sink.add;

  late LRS _lrs;

  LrsConnector() {
    _lrs = RemoteLRS(
      endpoint: "https://prueba-01.lrs.io/xapi/",
      username: "buzeno",
      password: "degegu",
    );
  }

  saveRegister(Statement statement, Agent agent) {
    //Establece conección la LRS
    LrsConnector();
    //Manda el statement agregandole el agente de forma separada a la construcción del mismo
    _lrs.saveStatement(statement.copyWith(actor: agent));
  }
}

final lrsConnector = LrsConnector();
