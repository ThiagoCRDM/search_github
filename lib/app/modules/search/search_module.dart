import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_github/app/modules/search/domain/user_cases/search_by_text/search_by_text_user_case_implements.dart';
import 'package:search_github/app/modules/search/external/github/github_search_datasource_impl.dart';
import 'package:search_github/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:search_github/app/modules/search/presenter/store/search_store.dart';
import 'presenter/pages/search_page.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Dio()),
    Bind.singleton((i) => GithubSearchDatasource(i<Dio>())),
    Bind.singleton((i) => SearchRepositoryImlp(i())),
    Bind.singleton((i) => SearchByTextImpl(i())),
    Bind.singleton((i) => SearchStore(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SearchPage()),
  ];
}
