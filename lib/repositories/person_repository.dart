import 'package:calculadora_umc_flutter/models/person.dart';

class PersonRepository {
  final List<Person> _people = [];

  Future<void> addIMCData(Person person) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _people.add(person);
  }

  Future<void> change(
      String id, String name, double weight, double height) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _people.where((person) => person.id == id).first.name = name;
    _people.where((person) => person.id == id).first.weight = weight;
    _people.where((person) => person.id == id).first.height = height;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _people.remove(_people.where((person) => person.id == id).first);
  }

  Future<List<Person>> list() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _people;
  }
}
