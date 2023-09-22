import 'dart:math';
import 'dart:typed_data';

import 'package:calculadora_umc_flutter/models/person.dart';
import 'package:calculadora_umc_flutter/repositories/person_repository.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var personRepository = PersonRepository();
  var _people = <Person>[];
  var nameController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var valueIMC = 0.0;
  var _valueIMC = 0.0;
  Person person = Person("", 0, 0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeople();
  }

  void getPeople() async {
    _people = await personRepository.list();

    setState(() {});
  }

  void addPeopleToRepository(
      String name, double weight, double height, double imc) {
    Person newPerson = Person(name, weight, height, imc);
    _people.add(newPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculadora de IMC'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameController.text = "";
          weightController.text = "";
          heightController.text = "";
          valueIMC = 0.0;
          _valueIMC = valueIMC;
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Novo IMC"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        const Text(
                          "Peso",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 12, 67, 161)),
                        ),
                        TextField(
                          controller: weightController,
                        ),
                        const Text(
                          "Altura",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 12, 67, 161)),
                        ),
                        TextField(
                          controller: heightController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              if (weightController.text.isNotEmpty &&
                                  heightController.text.isNotEmpty) {
                                valueIMC = person.calculateIMC(
                                    double.parse(weightController.text),
                                    double.parse(heightController.text));
                                _valueIMC = valueIMC;
                                addPeopleToRepository(
                                    "",
                                    double.parse(weightController.text),
                                    double.parse(heightController.text),
                                    valueIMC);
                                setState(() {
                                  getPeople();
                                });
                                Navigator.pop(context);
                              }
                              print("IMC: $valueIMC");
                              print("_people: ${_people}");
                            });
                          },
                          child: const Text("Calcular",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        tooltip: 'Calcular',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: AlignmentDirectional.center,
        child: ListView.builder(
            itemCount: _people.length,
            itemBuilder: (BuildContext bc, int index) {
              var itemIMC = _people[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemIMC.weight.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(itemIMC.height.toString(),
                      style: const TextStyle(fontSize: 20)),
                  Text(itemIMC.imc.toString(),
                      style: const TextStyle(fontSize: 20))
                ],
              );
            }),
      ),
    );
  }
}
