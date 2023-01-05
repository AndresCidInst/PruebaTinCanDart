class PressOnPlay {
  late int counter;
  late DateTime _start;
  late DateTime _end;
  late final int _min;
  late final int _max;
  late int _lvl;
  //Experiencia requerida para subir de nivel, la experiencia son las veces que precion+o el botón (counter)
  double _requireExperiencie = 10;
  int _experience = 0;

  //Constructor
  PressOnPlay(this._min, this._max) {
    _lvl = 1;
    counter = 0;
    _start = DateTime(2000);
  }

  //Metodos
  void incrementCounter() {
    counter++;
    _experience++;
  }

  void moreExperiencePerLvl() {
    _lvl++;
    _requireExperiencie *= 1.5;
  }

  int get max => _max;

  int get min => _min;

  DateTime get end => _end;

  void setEnd(DateTime value) =>_end = value;

  DateTime get start => _start;

  void setStart(DateTime value) => _start = value;

  get lvl => _lvl;

  void setLvl (int value) => _lvl = value;

  get requireExperiencie => _requireExperiencie;

  void setRequireExperience(double value) => _requireExperiencie = value;

  int get experience => _experience;

  void setExperience(int value) => _experience = value;

}
