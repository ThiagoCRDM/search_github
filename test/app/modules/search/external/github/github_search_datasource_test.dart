import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_github/app/modules/search/external/github/github_search_datasource_impl.dart';
import 'package:search_github/app/modules/search/infra/models/result_search_model.dart';

import '../../../../../data/fake_data.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubSearchDatasource(dio);
  test('Must return a "resulSearchtModel"', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: jsonDecode(jsonResponse),
        statusCode: 200,
        requestOptions: RequestOptions(
          path: '',
        ),
      ),
    );
    var result = await datasource.searchText("ThiagoCRDM");
    expect(result, isA<List<ResultSearchModel>>());
  });
}
