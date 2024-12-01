// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insect_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInsectGroupIsarCollection on Isar {
  IsarCollection<InsectGroupIsar> get insectGroupIsars => this.collection();
}

const InsectGroupIsarSchema = CollectionSchema(
  name: r'InsectGroupIsar',
  id: 2443801311839105743,
  properties: {
    r'collectionId': PropertySchema(
      id: 0,
      name: r'collectionId',
      type: IsarType.string,
    ),
    r'count': PropertySchema(
      id: 1,
      name: r'count',
      type: IsarType.long,
    ),
    r'insects': PropertySchema(
      id: 2,
      name: r'insects',
      type: IsarType.objectList,
      target: r'InsectIsar',
    )
  },
  estimateSize: _insectGroupIsarEstimateSize,
  serialize: _insectGroupIsarSerialize,
  deserialize: _insectGroupIsarDeserialize,
  deserializeProp: _insectGroupIsarDeserializeProp,
  idName: r'id',
  indexes: {
    r'collectionId': IndexSchema(
      id: -7489395134515229581,
      name: r'collectionId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'collectionId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'InsectIsar': InsectIsarSchema},
  getId: _insectGroupIsarGetId,
  getLinks: _insectGroupIsarGetLinks,
  attach: _insectGroupIsarAttach,
  version: '3.1.0+1',
);

int _insectGroupIsarEstimateSize(
  InsectGroupIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.collectionId.length * 3;
  bytesCount += 3 + object.insects.length * 3;
  {
    final offsets = allOffsets[InsectIsar]!;
    for (var i = 0; i < object.insects.length; i++) {
      final value = object.insects[i];
      bytesCount += InsectIsarSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _insectGroupIsarSerialize(
  InsectGroupIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.collectionId);
  writer.writeLong(offsets[1], object.count);
  writer.writeObjectList<InsectIsar>(
    offsets[2],
    allOffsets,
    InsectIsarSchema.serialize,
    object.insects,
  );
}

InsectGroupIsar _insectGroupIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InsectGroupIsar(
    collectionId: reader.readString(offsets[0]),
    count: reader.readLong(offsets[1]),
    insects: reader.readObjectList<InsectIsar>(
          offsets[2],
          InsectIsarSchema.deserialize,
          allOffsets,
          InsectIsar(),
        ) ??
        [],
  );
  object.id = id;
  return object;
}

P _insectGroupIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectList<InsectIsar>(
            offset,
            InsectIsarSchema.deserialize,
            allOffsets,
            InsectIsar(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _insectGroupIsarGetId(InsectGroupIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _insectGroupIsarGetLinks(InsectGroupIsar object) {
  return [];
}

void _insectGroupIsarAttach(
    IsarCollection<dynamic> col, Id id, InsectGroupIsar object) {
  object.id = id;
}

extension InsectGroupIsarByIndex on IsarCollection<InsectGroupIsar> {
  Future<InsectGroupIsar?> getByCollectionId(String collectionId) {
    return getByIndex(r'collectionId', [collectionId]);
  }

  InsectGroupIsar? getByCollectionIdSync(String collectionId) {
    return getByIndexSync(r'collectionId', [collectionId]);
  }

  Future<bool> deleteByCollectionId(String collectionId) {
    return deleteByIndex(r'collectionId', [collectionId]);
  }

  bool deleteByCollectionIdSync(String collectionId) {
    return deleteByIndexSync(r'collectionId', [collectionId]);
  }

  Future<List<InsectGroupIsar?>> getAllByCollectionId(
      List<String> collectionIdValues) {
    final values = collectionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'collectionId', values);
  }

  List<InsectGroupIsar?> getAllByCollectionIdSync(
      List<String> collectionIdValues) {
    final values = collectionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'collectionId', values);
  }

  Future<int> deleteAllByCollectionId(List<String> collectionIdValues) {
    final values = collectionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'collectionId', values);
  }

  int deleteAllByCollectionIdSync(List<String> collectionIdValues) {
    final values = collectionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'collectionId', values);
  }

  Future<Id> putByCollectionId(InsectGroupIsar object) {
    return putByIndex(r'collectionId', object);
  }

  Id putByCollectionIdSync(InsectGroupIsar object, {bool saveLinks = true}) {
    return putByIndexSync(r'collectionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCollectionId(List<InsectGroupIsar> objects) {
    return putAllByIndex(r'collectionId', objects);
  }

  List<Id> putAllByCollectionIdSync(List<InsectGroupIsar> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'collectionId', objects, saveLinks: saveLinks);
  }
}

extension InsectGroupIsarQueryWhereSort
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QWhere> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InsectGroupIsarQueryWhere
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QWhereClause> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause>
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

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause> idBetween(
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

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause>
      collectionIdEqualTo(String collectionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'collectionId',
        value: [collectionId],
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterWhereClause>
      collectionIdNotEqualTo(String collectionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionId',
              lower: [],
              upper: [collectionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionId',
              lower: [collectionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionId',
              lower: [collectionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionId',
              lower: [],
              upper: [collectionId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension InsectGroupIsarQueryFilter
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QFilterCondition> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collectionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collectionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionId',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      collectionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collectionId',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      countEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      countGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      countLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      countBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
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

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
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

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
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

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'insects',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'insects',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'insects',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'insects',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'insects',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'insects',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension InsectGroupIsarQueryObject
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QFilterCondition> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterFilterCondition>
      insectsElement(FilterQuery<InsectIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'insects');
    });
  }
}

extension InsectGroupIsarQueryLinks
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QFilterCondition> {}

extension InsectGroupIsarQuerySortBy
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QSortBy> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy>
      sortByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.asc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy>
      sortByCollectionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.desc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy> sortByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy>
      sortByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }
}

extension InsectGroupIsarQuerySortThenBy
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QSortThenBy> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy>
      thenByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.asc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy>
      thenByCollectionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.desc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy> thenByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy>
      thenByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension InsectGroupIsarQueryWhereDistinct
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QDistinct> {
  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QDistinct>
      distinctByCollectionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsectGroupIsar, InsectGroupIsar, QDistinct> distinctByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'count');
    });
  }
}

extension InsectGroupIsarQueryProperty
    on QueryBuilder<InsectGroupIsar, InsectGroupIsar, QQueryProperty> {
  QueryBuilder<InsectGroupIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InsectGroupIsar, String, QQueryOperations>
      collectionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionId');
    });
  }

  QueryBuilder<InsectGroupIsar, int, QQueryOperations> countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'count');
    });
  }

  QueryBuilder<InsectGroupIsar, List<InsectIsar>, QQueryOperations>
      insectsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insects');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InsectIsarSchema = Schema(
  name: r'InsectIsar',
  id: 1076061864143526492,
  properties: {
    r'damage': PropertySchema(
      id: 0,
      name: r'damage',
      type: IsarType.stringList,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 2,
      name: r'image',
      type: IsarType.string,
    ),
    r'management': PropertySchema(
      id: 3,
      name: r'management',
      type: IsarType.stringList,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 5,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _insectIsarEstimateSize,
  serialize: _insectIsarSerialize,
  deserialize: _insectIsarDeserialize,
  deserializeProp: _insectIsarDeserializeProp,
);

int _insectIsarEstimateSize(
  InsectIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.damage;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.management;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _insectIsarSerialize(
  InsectIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.damage);
  writer.writeString(offsets[1], object.id);
  writer.writeString(offsets[2], object.image);
  writer.writeStringList(offsets[3], object.management);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.type);
}

InsectIsar _insectIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InsectIsar();
  object.damage = reader.readStringList(offsets[0]);
  object.id = reader.readStringOrNull(offsets[1]);
  object.image = reader.readStringOrNull(offsets[2]);
  object.management = reader.readStringList(offsets[3]);
  object.name = reader.readStringOrNull(offsets[4]);
  object.type = reader.readStringOrNull(offsets[5]);
  return object;
}

P _insectIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InsectIsarQueryFilter
    on QueryBuilder<InsectIsar, InsectIsar, QFilterCondition> {
  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> damageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'damage',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'damage',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'damage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'damage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'damage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'damage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'damage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'damage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'damage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damage',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'damage',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'damage',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> damageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'damage',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'damage',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'damage',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'damage',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      damageLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'damage',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'management',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'management',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'management',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'management',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'management',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'management',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'management',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'management',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'management',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'management',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'management',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition>
      managementLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'management',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameEqualTo(
    String? value, {
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

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameGreaterThan(
    String? value, {
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

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameLessThan(
    String? value, {
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

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<InsectIsar, InsectIsar, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension InsectIsarQueryObject
    on QueryBuilder<InsectIsar, InsectIsar, QFilterCondition> {}
