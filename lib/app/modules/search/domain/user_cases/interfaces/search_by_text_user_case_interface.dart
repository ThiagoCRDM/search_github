import 'package:fpdart/fpdart.dart';
import '../../entities/search_entitie.dart';
import '../../errors/errors_result_search.dart';

abstract class ISearchByText {
  Future<Either<Failure, List<ResultSearchEntitie>>> call(String searchText);
}
