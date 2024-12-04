// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linux_device_asset.entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLinuxDeviceAssetCollection on Isar {
  IsarCollection<DesktopDeviceAsset> get desktopDeviceAssets =>
      this.collection();
}

const LinuxDeviceAssetSchema = CollectionSchema(
  name: r'LinuxDeviceAsset',
  id: 7754027704819300677,
  properties: {
    r'hash': PropertySchema(
      id: 0,
      name: r'hash',
      type: IsarType.byteList,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    )
  },
  estimateSize: _linuxDeviceAssetEstimateSize,
  serialize: _linuxDeviceAssetSerialize,
  deserialize: _linuxDeviceAssetDeserialize,
  deserializeProp: _linuxDeviceAssetDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'hash': IndexSchema(
      id: -7973251393006690288,
      name: r'hash',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hash',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _linuxDeviceAssetGetId,
  getLinks: _linuxDeviceAssetGetLinks,
  attach: _linuxDeviceAssetAttach,
  version: '3.1.8',
);

int _linuxDeviceAssetEstimateSize(
  DesktopDeviceAsset object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.hash.length;
  bytesCount += 3 + object.id.length * 3;
  return bytesCount;
}

void _linuxDeviceAssetSerialize(
  DesktopDeviceAsset object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.hash);
  writer.writeString(offsets[1], object.id);
}

DesktopDeviceAsset _linuxDeviceAssetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DesktopDeviceAsset(
    hash: reader.readByteList(offsets[0]) ?? [],
    id: reader.readString(offsets[1]),
  );
  return object;
}

P _linuxDeviceAssetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _linuxDeviceAssetGetId(DesktopDeviceAsset object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _linuxDeviceAssetGetLinks(
    DesktopDeviceAsset object) {
  return [];
}

void _linuxDeviceAssetAttach(
    IsarCollection<dynamic> col, Id id, DesktopDeviceAsset object) {}

extension LinuxDeviceAssetByIndex on IsarCollection<DesktopDeviceAsset> {
  Future<DesktopDeviceAsset?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  DesktopDeviceAsset? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<DesktopDeviceAsset?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<DesktopDeviceAsset?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(DesktopDeviceAsset object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(DesktopDeviceAsset object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<DesktopDeviceAsset> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<DesktopDeviceAsset> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension LinuxDeviceAssetQueryWhereSort
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QWhere> {
  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LinuxDeviceAssetQueryWhere
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QWhereClause> {
  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      hashEqualTo(List<int> hash) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hash',
        value: [hash],
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterWhereClause>
      hashNotEqualTo(List<int> hash) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [],
              upper: [hash],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [hash],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [hash],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hash',
              lower: [],
              upper: [hash],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LinuxDeviceAssetQueryFilter
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QFilterCondition> {
  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hash',
        value: value,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      hashLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hash',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idEqualTo(
    String value, {
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

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idGreaterThan(
    String value, {
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

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idLessThan(
    String value, {
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

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
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

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LinuxDeviceAssetQueryObject
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QFilterCondition> {}

extension LinuxDeviceAssetQueryLinks
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QFilterCondition> {}

extension LinuxDeviceAssetQuerySortBy
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QSortBy> {
  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension LinuxDeviceAssetQuerySortThenBy
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QSortThenBy> {
  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension LinuxDeviceAssetQueryWhereDistinct
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QDistinct> {
  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QDistinct>
      distinctByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hash');
    });
  }

  QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }
}

extension LinuxDeviceAssetQueryProperty
    on QueryBuilder<DesktopDeviceAsset, DesktopDeviceAsset, QQueryProperty> {
  QueryBuilder<DesktopDeviceAsset, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DesktopDeviceAsset, List<int>, QQueryOperations> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hash');
    });
  }

  QueryBuilder<DesktopDeviceAsset, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}
