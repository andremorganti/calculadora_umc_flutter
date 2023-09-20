import 'dart:math';

import 'package:flutter/material.dart';

class Person {
//attributes of person to calculate the IMC
  final String _id = UniqueKey().toString();
  String _name = "";
  double _weight = 0.0;
  double _height = 0.0;
  double _imc = 0.0;

//constructor
  Person(this._name);

//gets and setters
  String get id => _id;

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  double get weight => _weight;

  set weight(double weight) {
    _weight = weight;
  }

  double get height => _height;

  set height(double height) {
    _height = height;
  }

  double get imc => _imc;

  void calculateIMC() {
    if (_height <= 0.0 || _weight <= 0.0) {
      throw ArgumentError("O valor não pode ser menor ou igual a 0");
    }
    _imc = _weight / pow(_height / 100, 2);
    return;
  }
}
