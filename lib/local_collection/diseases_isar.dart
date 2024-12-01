import 'package:isar/isar.dart';

part 'diseases_isar.g.dart';

@collection
class PlantDisease {
  PlantDisease({
    required this.collectionId,
    required this.diseaseName,
    required this.cause,
    required this.imageUrl,
    required this.symptoms,
    required this.management,
  });
  Id id = Isar.autoIncrement;
  final String collectionId;
  final String diseaseName;
  final String cause;
  final String imageUrl;
  final List<String> symptoms;
  final List<String> management;
}
