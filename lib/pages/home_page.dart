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
  var _people = const <Person>[];
  var nameController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var valueIMC = 0.0;
  Person person = Person("");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculadora de IMC'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Peso',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  'Altura',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  'IMC',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameController.text = "";
          weightController.text = "";
          heightController.text = "";
          valueIMC = 0.0;
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
                            if (weightController.text.isNotEmpty &&
                                heightController.text.isNotEmpty) {
                              valueIMC = person.calculateIMC(
                                  double.parse(weightController.text),
                                  double.parse(heightController.text));
                            }
                            print("IMC: $valueIMC");
                            setState(() {});
                          },
                          child: const Text("Calcular",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "IMC",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 12, 67, 161)),
                        ),
                        Text(
                          valueIMC.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 12, 67, 161)),
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
    );
  }
}
