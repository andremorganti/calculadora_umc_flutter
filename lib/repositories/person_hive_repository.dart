import 'package:calculadora_umc_flutter/models/person_hive_model.dart';
import 'package:hive/hive.dart';

class PersonHiveRepository {
  static late Box _box;

  PersonHiveRepository._create();

  static Future<PersonHiveRepository> load() async {
    if (Hive.isBoxOpen('PersonHiveModel')) {
      _box = Hive.box('PersonHiveModel');
    } else {
      _box = await Hive.box('PersonHiveModel');
    }
    return PersonHiveRepository._create();
  }

  save(PersonHiveModel personHiveModel) {
    _box.put('personHiveModel', personHiveModel);
  }

  PersonHiveModel loadData() {
    var personHiveModel = _box.get('personHiveModel');
    if (personHiveModel == null) {
      return PersonHiveModel.empty();
    }
    return personHiveModel;
  }
}
