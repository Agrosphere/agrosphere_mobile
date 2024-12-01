// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kalimati_tarkari.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetKalimatiTarkariCollection on Isar {
  IsarCollection<KalimatiTarkari> get kalimatiTarkaris => this.collection();
}

const KalimatiTarkariSchema = CollectionSchema(
  name: r'KalimatiTarkari',
  id: -4556164404363741641,
  properties: {
    r'avgPrice': PropertySchema(
      id: 0,
      name: r'avgPrice',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.string,
    ),
    r'maxPrice': PropertySchema(
      id: 2,
      name: r'maxPrice',
      type: IsarType.string,
    ),
    r'minPrice': PropertySchema(
      id: 3,
      name: r'minPrice',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 5,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _kalimatiTarkariEstimateSize,
  serialize: _kalimatiTarkariSerialize,
  deserialize: _kalimatiTarkariDeserialize,
  deserializeProp: _kalimatiTarkariDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _kalimatiTarkariGetId,
  getLinks: _kalimatiTarkariGetLinks,
  attach: _kalimatiTarkariAttach,
  version: '3.1.0+1',
);

int _kalimatiTarkariEstimateSize(
  KalimatiTarkari object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.avgPrice.length * 3;
  bytesCount += 3 + object.date.length * 3;
  bytesCount += 3 + object.maxPrice.length * 3;
  bytesCount += 3 + object.minPrice.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _kalimatiTarkariSerialize(
  KalimatiTarkari object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avgPrice);
  writer.writeString(offsets[1], object.date);
  writer.writeString(offsets[2], object.maxPrice);
  writer.writeString(offsets[3], object.minPrice);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.unit);
}

KalimatiTarkari _kalimatiTarkariDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KalimatiTarkari(
    reader.readString(offsets[4]),
    reader.readString(offsets[5]),
    reader.readString(offsets[3]),
    reader.readString(offsets[2]),
    reader.readString(offsets[0]),
    reader.readString(offsets[1]),
  );
  return object;
}

P _kalimatiTarkariDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _kalimatiTarkariGetId(KalimatiTarkari object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _kalimatiTarkariGetLinks(KalimatiTarkari object) {
  return [];
}

void _kalimatiTarkariAttach(
    IsarCollection<dynamic> col, Id id, KalimatiTarkari object) {}

extension KalimatiTarkariQueryWhereSort
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QWhere> {
  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension KalimatiTarkariQueryWhere
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QWhereClause> {
  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension KalimatiTarkariQueryFilter
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QFilterCondition> {
  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avgPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avgPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avgPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avgPrice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      avgPriceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avgPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maxPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maxPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maxPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maxPrice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      maxPriceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maxPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'minPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'minPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'minPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'minPrice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      minPriceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'minPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension KalimatiTarkariQueryObject
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QFilterCondition> {}

extension KalimatiTarkariQueryLinks
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QFilterCondition> {}

extension KalimatiTarkariQuerySortBy
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QSortBy> {
  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByAvgPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPrice', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByAvgPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPrice', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByMaxPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByMaxPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByMinPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByMinPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension KalimatiTarkariQuerySortThenBy
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QSortThenBy> {
  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByAvgPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPrice', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByAvgPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgPrice', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByMaxPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByMaxPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPrice', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByMinPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByMinPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPrice', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QAfterSortBy>
      thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension KalimatiTarkariQueryWhereDistinct
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> {
  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> distinctByAvgPrice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgPrice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> distinctByMaxPrice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxPrice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> distinctByMinPrice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minPrice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KalimatiTarkari, KalimatiTarkari, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }
}

extension KalimatiTarkariQueryProperty
    on QueryBuilder<KalimatiTarkari, KalimatiTarkari, QQueryProperty> {
  QueryBuilder<KalimatiTarkari, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<KalimatiTarkari, String, QQueryOperations> avgPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgPrice');
    });
  }

  QueryBuilder<KalimatiTarkari, String, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<KalimatiTarkari, String, QQueryOperations> maxPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxPrice');
    });
  }

  QueryBuilder<KalimatiTarkari, String, QQueryOperations> minPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minPrice');
    });
  }

  QueryBuilder<KalimatiTarkari, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<KalimatiTarkari, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }
}
