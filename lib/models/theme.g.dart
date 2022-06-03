// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $UISettingLocalAdapter on LocalAdapter<UISetting> {
  static final Map<String, RelationshipMeta> _kUISettingRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kUISettingRelationshipMetas;

  @override
  UISetting deserialize(map) {
    map = transformDeserialize(map);
    return _$UISettingFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$UISettingToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _uISettingsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $UISettingHiveLocalAdapter = HiveLocalAdapter<UISetting>
    with $UISettingLocalAdapter;

class $UISettingRemoteAdapter = RemoteAdapter<UISetting> with NothingMixin;

final internalUISettingsRemoteAdapterProvider =
    Provider<RemoteAdapter<UISetting>>((ref) => $UISettingRemoteAdapter(
        $UISettingHiveLocalAdapter(ref.read),
        InternalHolder(_uISettingsFinders)));

final uISettingsRepositoryProvider =
    Provider<Repository<UISetting>>((ref) => Repository<UISetting>(ref.read));

extension UISettingDataRepositoryX on Repository<UISetting> {}

extension UISettingRelationshipGraphNodeX on RelationshipGraphNode<UISetting> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UISetting _$UISettingFromJson(Map<String, dynamic> json) => UISetting(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.light,
    );

Map<String, dynamic> _$UISettingToJson(UISetting instance) => <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
