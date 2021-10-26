import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_github/app/modules/search/domain/entities/search_entitie.dart';
import 'package:search_github/app/modules/search/domain/errors/errors_result_search.dart';
import 'package:search_github/app/modules/search/domain/repositories/search_repository_interface.dart';
import 'package:search_github/app/modules/search/domain/user_cases/search_by_text/search_by_text_user_case_implements.dart';

class MockSearchByTextRepository extends Mock
    implements ISearchByTextRepository {}

main() {
  final repository = MockSearchByTextRepository();
  final useCase = SearchByTextImpl(repository);
  test("should return a list of results", () async {
    when(() => repository.getUsers("ThiagoCRDM")).thenAnswer(
      (_) async => Right(
        [
          ResultSearchEntitie(
            image: "",
            name: "",
            nickName: "",
            url: "",
          ),
        ],
      ),
    );

    var result = await useCase("ThiagoCRDM");
    expect(result, isA<Right<Failure, List<ResultSearchEntitie>>>());
  });

  test('should return an "InvalidSearchText" if text is invalid', () async {
    var result = await useCase("");
    expect(result.fold(id, id), isA<InvalidSearchText>());
  });

  test('must return an EmptyList if the return is empty', () async {
    when(() => repository.getUsers("void"))
        .thenAnswer((_) async => right(<ResultSearchEntitie>[]));

    var result = await useCase("void");
    expect(result.fold(id, id), isA<EmptyList>());
  });
}
