import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:late_blight/local_collection/kalimati_tarkari.dart';
import 'package:late_blight/model/tarkari_model.dart';
import 'package:late_blight/services/isar_service/isar_service.dart';

class KalamatiIsarService {
  late Isar isar;
  KalamatiIsarService() {
    isar = IsarService.isar;
  }

  //check the data is already present or not
  Future<bool> isKalimatiTarkariPricePresent(String date) async {
    final tarkari = await isar.kalimatiTarkaris
        .where()
        .filter()
        .dateEqualTo(date)
        .findFirst();
    return tarkari != null;
  }

  Future<void> addTarkariPrice(List<VegAndFruit> prices) async {
    final date = prices.isEmpty ? '' : prices.first.date;
    // return if the date is empty
    if (date.isEmpty) return;

    if (!(await isKalimatiTarkariPricePresent(date))) {
      //add the data to the isar
      await isar.writeTxn(
        () => isar.kalimatiTarkaris.putAll(
          prices.map((price) => _toKalimatiTarkari(price)).toList(),
        ),
      );
      await removeTarkariPriceBeforeDate(date);
    }
  }

  //remove the data before the date
  Future<void> removeTarkariPriceBeforeDate(String date) async {
    await isar.writeTxn(() =>
        isar.kalimatiTarkaris.where().filter().dateLessThan(date).deleteAll());
    debugPrint('removeTarkariPriceBeforeDate');
  }

  //get the data from the isar
  Future<List<VegAndFruit>> getTarkariPrice(String date) async {
    final tarkari = await isar.kalimatiTarkaris
        .where()
        .filter()
        .dateEqualTo(date)
        .findAll();
    return tarkari.map((price) => _toVegAndFruit(price)).toList();
  }

  KalimatiTarkari _toKalimatiTarkari(VegAndFruit price) {
    return KalimatiTarkari(
      price.name,
      price.unit,
      price.minPrice,
      price.maxPrice,
      price.avgPrice,
      price.date,
    );
  }

  VegAndFruit _toVegAndFruit(KalimatiTarkari price) {
    return VegAndFruit(
      id: price.id.toString(),
      name: price.name,
      unit: price.unit,
      minPrice: price.minPrice,
      maxPrice: price.maxPrice,
      avgPrice: price.avgPrice,
      date: price.date,
    );
  }
}
