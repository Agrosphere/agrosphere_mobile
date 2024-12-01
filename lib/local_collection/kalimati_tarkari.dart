import 'package:isar/isar.dart';

part 'kalimati_tarkari.g.dart';

@collection
class KalimatiTarkari {
  KalimatiTarkari(
    this.name,
    this.unit,
    this.minPrice,
    this.maxPrice,
    this.avgPrice,
    this.date,
  );
  final Id id = Isar.autoIncrement;
  final String name;
  final String unit;
  final String minPrice;
  final String maxPrice;
  final String avgPrice;
  final String date;
}
