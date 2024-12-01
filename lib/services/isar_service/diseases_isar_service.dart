import 'package:isar/isar.dart';
import 'package:late_blight/local_collection/diseases_isar.dart';
import 'package:late_blight/services/isar_service/isar_service.dart';
import 'package:late_blight/model/diseases_model.dart' as model;

class DiseasesIsarService {
  late Isar isar;
  DiseasesIsarService() {
    isar = IsarService.isar;
  }

  addDiseases(List<model.PlantDisease> diseases) async {
    await isar.writeTxn(
      () => isar.plantDiseases.putAll(
        diseases.map((disease) => _toPlantDisease(disease)).toList(),
      ),
    );
  }

  addDisease(model.PlantDisease disease) async {
    await isar.writeTxn(() => isar.plantDiseases.put(_toPlantDisease(disease)));
  }

  Future<bool> exists(String collectionId) async {
    //check all
    final disease = await isar.plantDiseases
        .where()
        .filter()
        .collectionIdEqualTo(collectionId)
        .findFirst();
    return disease != null;
  }

  addIfNotExists(List<model.PlantDisease> diseases) {
    for (final disease in diseases) {
      exists(disease.id).then((value) {
        if (!value) {
          addDisease(disease);
        }
      });
    }
  }

  removeOne(int id) async {
    await isar.writeTxn(() => isar.plantDiseases.delete(id));
  }

  removeAll() async {
    await isar.writeTxn(() => isar.plantDiseases.where().deleteAll());
  }

  Future<List<model.PlantDisease>> getDiseases() async {
    final diseases = await isar.plantDiseases.where().findAll();
    return diseases.map((disease) => _toModelPlantDisease(disease)).toList();
  }

  model.PlantDisease _toModelPlantDisease(PlantDisease disease) {
    return model.PlantDisease(
      id: disease.collectionId,
      diseaseName: disease.diseaseName,
      cause: disease.cause,
      imageUrl: disease.imageUrl,
      symptoms: disease.symptoms,
      management: disease.management,
    );
  }

  PlantDisease _toPlantDisease(model.PlantDisease disease) {
    return PlantDisease(
      collectionId: disease.id,
      diseaseName: disease.diseaseName,
      cause: disease.cause,
      imageUrl: disease.imageUrl,
      symptoms: disease.symptoms,
      management: disease.management,
    );
  }
}
