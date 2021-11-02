import 'package:fpdart/fpdart.dart';

import '../models/result_search_model.dart';
import '../datasources/interfaces/search_datasource_infra.dart';

import '../../domain/entities/search_entitie.dart';
import '../../domain/errors/errors_result_search.dart';
import '../../domain/repositories/search_repository_interface.dart';

class SearchRepositoryImlp implements ISearchByTextRepository {
  final ISeachDatasource _datasource;

  SearchRepositoryImlp(this._datasource);

  @override
  Future<Either<Failure, List<ResultSearchEntitie>>> getUsers(
      String searchText) async {
    List<ResultSearchModel> listResultSearch = [];
    try {
      listResultSearch = await _datasource.searchText(searchText);
    } catch (e) {
      return left(const ErrorSearch());
    }
    return listResultSearch.isEmpty
        ? left(const DatasourceResultEmpty())
        : right(listResultSearch);
  }
}
