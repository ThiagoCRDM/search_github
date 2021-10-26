import 'package:fpdart/fpdart.dart';
import 'package:search_github/app/modules/search/domain/entities/search_entitie.dart';
import 'package:search_github/app/modules/search/domain/errors/errors_result_search.dart';

abstract class ISearchByTextRepository {
  Future<Either<Failure, List<ResultSearchEntitie>>> getUsers(searchText);
}
