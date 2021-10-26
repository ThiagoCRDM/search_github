import 'package:fpdart/fpdart.dart';
import '../../entities/search_entitie.dart';
import '../../errors/errors_result_search.dart';
import '../../repositories/search_repository_interface.dart';
import '../interfaces/search_by_text_user_case_interface.dart';

class SearchByTextImpl implements ISearchByText {
  final ISearchByTextRepository _repository;

  SearchByTextImpl(this._repository);

  @override
  Future<Either<Failure, List<ResultSearchEntitie>>> call(
      String searchText) async {
    if (searchText.isEmpty) {
      return const Left(
        InvalidSearchText(
          message: 'the "searchText" parameter cannot be optional',
        ),
      );
    }
    var result = await _repository.getUsers(searchText);
    return result.fold(
      (l) => left(l),
      (r) => r.isEmpty ? left(EmptyList()) : right(r),
    );
  }
}
