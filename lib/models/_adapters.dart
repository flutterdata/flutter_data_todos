import 'package:flutter_data/flutter_data.dart';

mixin JSONPlaceholderAdapter<T extends DataSupport<T>>
    on StandardJSONAdapter<T> {
  @override
  String get baseUrl => 'http://jsonplaceholder.typicode.com';

  @override
  String get identifierSuffix => 'Id';
}
