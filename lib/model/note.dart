class Note {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note.withId(
      this._id, this._title, this._description, this._date, this._priority);

  Note(this._title, this._description, this._date, this._priority);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  int get priority => _priority;

  set priority(int value) {
    if (value >= 1 && value <= 2) _priority = value;
  }

  set date(String value) {
    _date = value;
  }

  set description(String value) {
    _description = value;
  }

  set title(String value) {
    if (value.length <= 255) _title = value;
  }

  set id(int value) {
    _id = value;
  }

  //Convert Note object into Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['priority'] = _priority;

    return map;
  }

  //Extract Note object from Map object
  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}
