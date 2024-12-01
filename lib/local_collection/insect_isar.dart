import 'package:isar/isar.dart';

part 'insect_isar.g.dart';

@Collection()
class InsectGroupIsar {
  InsectGroupIsar({
    required this.collectionId,
    required this.count,
    required this.insects,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String collectionId; // Use late if you intend to initialize it later
  final int count;
  List<InsectIsar> insects = [];
}

@embedded
class InsectIsar {
  String? id;
  String? type;
  String? name;
  String? image;
  List<String>? damage;
  List<String>? management;
}
