import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_github/app/modules/search/search_module.dart';
import 'package:search_github/app/modules/search/domain/entities/search_entitie.dart';
import 'package:search_github/app/modules/search/domain/errors/errors_result_search.dart';
import 'package:search_github/app/modules/search/domain/user_cases/interfaces/search_by_text_user_case_interface.dart';

import '../../../data/fake_data.dart';

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

  test('Must run usecase "search_by_text"', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: jsonDecode(jsonResponse),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    var usercase = Modular.get<ISearchByText>();
    var result = await usercase("thiagocrdm");

    expect(result.isRight(), true);
    expect(result, isA<Right<Failure, List<ResultSearchEntitie>>>());
  });
}
