import 'package:dio/dio.dart';

import '../../infra/datasources/interfaces/search_datasource_infra.dart';
import '../../infra/models/result_search_model.dart';

class GithubSearchDatasource implements ISeachDatasource {
  final Dio _dio;

  GithubSearchDatasource(this._dio);
  String get _apiURI => 'https://api.github.com/search/users?q=';

  @override
  Future<List<ResultSearchModel>> searchText(String textSearch) async {
    String newTextSearch = textSearch.trim().replaceAll(' ', '+');
    final response = await _dio.get(_apiURI + newTextSearch);
    try {
      if (response.statusCode == 200) {
        var jsonList = response.data['items'] as List;

        return jsonList
            .map((data) => ResultSearchModel(
                  image: data['avatar_url'],
                  name: data['login'],
                  nickName: data['login'],
                  url: data['url'],
                ))
            .toList();
      } else {
        throw Exception('error  unexpected');
      }
    } on DioError {
      rethrow;
    } catch (e) {
      return throw Exception(
        "status code: ${response.statusCode}. error: ${e.toString()}",
      );
    }
  }
}
