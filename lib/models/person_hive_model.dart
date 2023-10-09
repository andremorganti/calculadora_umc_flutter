import 'package:hive/hive.dart';

part 'person_hive_model.g.dart';

@HiveType(typeId: 0)
class PersonHiveModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  double? height;

  PersonHiveModel();

  PersonHiveModel.empty() {
    name = "";
    height = 0;
  }
}
