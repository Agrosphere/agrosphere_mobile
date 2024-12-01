import 'package:isar/isar.dart';
import 'package:late_blight/local_collection/insect_isar.dart';
import 'package:late_blight/model/insect_model.dart';
import 'package:late_blight/services/isar_service/isar_service.dart';

class InsectIsarService {
  late Isar isar;
  InsectIsarService() {
    isar = IsarService.isar;
  }

  addInsectGroup(List<InsectGroup> insectGroups) async {
    await isar.writeTxn(
      () => isar.insectGroupIsars.putAll(
        insectGroups.map((group) => _toInsectGroupIsar(group)).toList(),
      ),
    );
  }

  deleteAll() async {
    await isar.writeTxn(() => isar.insectGroupIsars.where().deleteAll());
  }

  Future<List<InsectGroup>> getInsectGroups() async {
    final groups = await isar.insectGroupIsars.where().findAll();
    return groups.map((group) => _toInsectGroup(group)).toList();
  }

  InsectGroup _toInsectGroup(InsectGroupIsar group) {
    return InsectGroup(
      id: group.collectionId,
      count: group.count,
      insects: group.insects.map((insect) => _toInsect(insect)).toList(),
    );
  }

  Insect _toInsect(InsectIsar insect) {
    return Insect(
      id: insect.id!,
      type: insect.type!,
      name: insect.name!,
      image: insect.image!,
      damage: insect.damage!,
      management: insect.management!,
    );
  }

  InsectGroupIsar _toInsectGroupIsar(InsectGroup group) {
    return InsectGroupIsar(
      collectionId: group.id,
      count: group.count,
      insects: group.insects.map((insect) => _toInsectIsar(insect)).toList(),
    );
  }

  InsectIsar _toInsectIsar(Insect insect) {
    return InsectIsar()
      ..id = insect.id
      ..type = insect.type
      ..damage = insect.damage
      ..management = insect.management
      ..name = insect.name
      ..image = insect.image;
  }
}
