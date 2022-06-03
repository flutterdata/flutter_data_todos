import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_data_todos/main.data.dart';

part 'theme.g.dart';

@JsonSerializable()
@DataRepository([])
class UISetting extends DataModel<UISetting> {
  final ThemeMode themeMode;

  UISetting({this.themeMode = ThemeMode.light});
  @override
  int get id => 0;
}

final uiSettingsInitProvider = FutureProvider((ref) async {
  var setting = await ref.uISettings.findOne(0, remote: false);
  print('Future: $setting');
  if (setting == null) {
    await UISetting().save(remote: false);
  }
});
