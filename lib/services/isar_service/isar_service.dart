import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar isar;
  static Future<void> init(
    List<CollectionSchema<dynamic>> schemas,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      schemas,
      directory: directory.path,
      name: "ku_krishi",
    );
  }

  static Future<void> close() async {
    await isar.close();
  }
}
