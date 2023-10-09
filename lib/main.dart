import 'package:calculadora_umc_flutter/models/person_hive_model.dart';
import 'package:calculadora_umc_flutter/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documetsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documetsDirectory.path);
  Hive.registerAdapter(PersonHiveModelAdapter());
  runApp(const MyApp());
}
