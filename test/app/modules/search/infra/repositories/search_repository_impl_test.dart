import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_github/app/modules/search/domain/errors/errors_result_search.dart';
import 'package:search_github/app/modules/search/infra/datasources/interfaces/search_datasource_infra.dart';
import 'package:search_github/app/modules/search/infra/models/result_search_model.dart';
import 'package:search_github/app/modules/search/infra/repositories/search_repository_impl.dart';

class SearchDatasourceMock extends Mock implements ISeachDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImlp(datasource);

  final listResultSearch = [
    ResultSearchModel(
      image: "image",
      name: "name",
      nickName: "nickName",
      url: "url",
    ),
  ];

  test('should return a list of "ResultSearchModel"', () async {
    when(() => datasource.searchText("ThiagoCRDM"))
        .thenAnswer((_) async => listResultSearch);
    var result = await repository.getUsers("ThiagoCRDM");
    expect(result, Right<Failure, List<ResultSearchModel>>(listResultSearch));
  });

  test('Should return an "ErrorSearch" if throw is thrown on the datasource',
      () async {
    when(() => datasource.searchText(any())).thenThrow(const ErrorSearch());
    var result = await repository.getUsers("ThiagoCRDM");
    expect(result.fold(id, id), isA<ErrorSearch>());
  });

  test(
      'Must return a "DatasourceResultEmpty" if the datasource return is empty',
      () async {
    when(() => datasource.searchText("Thiago"))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    var result = await repository.getUsers("Thiago");
    expect(result.fold(id, id), isA<DatasourceResultEmpty>());
  });
}
