import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_github/app/modules/search/search_module.dart';

void main() {
  setUpAll(() {
    initModule(SearchModule());
  });
}
