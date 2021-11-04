import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_github/app/modules/search/search_module.dart';
import 'package:search_github/app/modules/search/presenter/states/search_state.dart';
import 'package:search_github/app/modules/search/presenter/store/search_store.dart';

import '../../../../data/fake_data.dart';

class DioMock extends Mock implements Dio {}

main() {
  var dio = DioMock();

  setUp(() {
    initModule(
      SearchModule(),
      replaceBinds: [
        BindInject((i) => dio),
      ],
    );
  });

  when(() => dio.get(any())).thenAnswer(
    (_) async => Response(
      data: jsonDecode(jsonResponse),
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ),
  );

  test('must return a "SuccessState"', () async {
    var store = Modular.get<SearchStore>();
    var result = await store.makeSearch("text");
    expect(result, isA<SuccessState>());
  });

  test('must change state to "SuccessState"', () async {
    var store = Modular.get<SearchStore>();
    await store.stateReaction("text");
    expect(store.state, isA<SuccessState>());
  });
}
