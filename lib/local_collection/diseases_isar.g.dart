// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diseases_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlantDiseaseCollection on Isar {
  IsarCollection<PlantDisease> get plantDiseases => this.collection();
}

const PlantDiseaseSchema = CollectionSchema(
  name: r'PlantDisease',
  id: -8284515338203076930,
  properties: {
    r'cause': PropertySchema(
      id: 0,
      name: r'cause',
      type: IsarType.string,
    ),
    r'collectionId': PropertySchema(
      id: 1,
      name: r'collectionId',
      type: IsarType.string,
    ),
    r'diseaseName': PropertySchema(
      id: 2,
      name: r'diseaseName',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 3,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'management': PropertySchema(
      id: 4,
      name: r'management',
      type: IsarType.stringList,
    ),
    r'symptoms': PropertySchema(
      id: 5,
      name: r'symptoms',
      type: IsarType.stringList,
    )
  },
  estimateSize: _plantDiseaseEstimateSize,
  serialize: _plantDiseaseSerialize,
  deserialize: _plantDiseaseDeserialize,
  deserializeProp: _plantDiseaseDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _plantDiseaseGetId,
  getLinks: _plantDiseaseGetLinks,
  attach: _plantDiseaseAttach,
  version: '3.1.0+1',
);

int _plantDiseaseEstimateSize(
  PlantDisease object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cause.length * 3;
  bytesCount += 3 + object.collectionId.length * 3;
  bytesCount += 3 + object.diseaseName.length * 3;
  bytesCount += 3 + object.imageUrl.length * 3;
  bytesCount += 3 + object.management.length * 3;
  {
    for (var i = 0; i < object.management.length; i++) {
      final value = object.management[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.symptoms.length * 3;
  {
    for (var i = 0; i < object.symptoms.length; i++) {
      final value = object.symptoms[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _plantDiseaseSerialize(
  PlantDisease object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cause);
  writer.writeString(offsets[1], object.collectionId);
  writer.writeString(offsets[2], object.diseaseName);
  writer.writeString(offsets[3], object.imageUrl);
  writer.writeStringList(offsets[4], object.management);
  writer.writeStringList(offsets[5], object.symptoms);
}

PlantDisease _plantDiseaseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlantDisease(
    cause: reader.readString(offsets[0]),
    collectionId: reader.readString(offsets[1]),
    diseaseName: reader.readString(offsets[2]),
    imageUrl: reader.readString(offsets[3]),
    management: reader.readStringList(offsets[4]) ?? [],
    symptoms: reader.readStringList(offsets[5]) ?? [],
  );
  object.id = id;
  return object;
}

P _plantDiseaseDeserializeProp<P>(
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
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plantDiseaseGetId(PlantDisease object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _plantDiseaseGetLinks(PlantDisease object) {
  return [];
}

void _plantDiseaseAttach(
    IsarCollection<dynamic> col, Id id, PlantDisease object) {
  object.id = id;
}

extension PlantDiseaseQueryWhereSort
    on QueryBuilder<PlantDisease, PlantDisease, QWhere> {
  QueryBuilder<PlantDisease, PlantDisease, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlantDiseaseQueryWhere
    on QueryBuilder<PlantDisease, PlantDisease, QWhereClause> {
  QueryBuilder<PlantDisease, PlantDisease, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterWhereClause> idBetween(
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

extension PlantDiseaseQueryFilter
    on QueryBuilder<PlantDisease, PlantDisease, QFilterCondition> {
  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> causeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cause',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      causeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cause',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> causeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cause',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> causeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cause',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      causeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cause',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> causeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cause',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> causeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cause',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> causeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cause',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      causeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cause',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      causeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cause',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      collectionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collectionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      collectionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collectionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      collectionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      collectionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collectionId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diseaseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diseaseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diseaseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diseaseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'diseaseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'diseaseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'diseaseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'diseaseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diseaseName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      diseaseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'diseaseName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      managementElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'management',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      managementElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'management',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      managementElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'management',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      managementElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'management',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
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

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'symptoms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symptoms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'symptoms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symptoms',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symptoms',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterFilterCondition>
      symptomsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'symptoms',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PlantDiseaseQueryObject
    on QueryBuilder<PlantDisease, PlantDisease, QFilterCondition> {}

extension PlantDiseaseQueryLinks
    on QueryBuilder<PlantDisease, PlantDisease, QFilterCondition> {}

extension PlantDiseaseQuerySortBy
    on QueryBuilder<PlantDisease, PlantDisease, QSortBy> {
  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> sortByCause() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cause', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> sortByCauseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cause', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> sortByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy>
      sortByCollectionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> sortByDiseaseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diseaseName', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy>
      sortByDiseaseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diseaseName', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }
}

extension PlantDiseaseQuerySortThenBy
    on QueryBuilder<PlantDisease, PlantDisease, QSortThenBy> {
  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByCause() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cause', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByCauseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cause', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy>
      thenByCollectionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByDiseaseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diseaseName', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy>
      thenByDiseaseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diseaseName', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }
}

extension PlantDiseaseQueryWhereDistinct
    on QueryBuilder<PlantDisease, PlantDisease, QDistinct> {
  QueryBuilder<PlantDisease, PlantDisease, QDistinct> distinctByCause(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cause', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QDistinct> distinctByCollectionId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QDistinct> distinctByDiseaseName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diseaseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QDistinct> distinctByManagement() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'management');
    });
  }

  QueryBuilder<PlantDisease, PlantDisease, QDistinct> distinctBySymptoms() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symptoms');
    });
  }
}

extension PlantDiseaseQueryProperty
    on QueryBuilder<PlantDisease, PlantDisease, QQueryProperty> {
  QueryBuilder<PlantDisease, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlantDisease, String, QQueryOperations> causeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cause');
    });
  }

  QueryBuilder<PlantDisease, String, QQueryOperations> collectionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionId');
    });
  }

  QueryBuilder<PlantDisease, String, QQueryOperations> diseaseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diseaseName');
    });
  }

  QueryBuilder<PlantDisease, String, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<PlantDisease, List<String>, QQueryOperations>
      managementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'management');
    });
  }

  QueryBuilder<PlantDisease, List<String>, QQueryOperations>
      symptomsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symptoms');
    });
  }
}
