import '../../models/result_search_model.dart';

abstract class ISeachDatasource {
  Future<List<ResultSearchModel>> searchText(String textSearch);
}
