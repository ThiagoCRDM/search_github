import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_github/app/modules/search/domain/entities/search_entitie.dart';
import 'package:search_github/app/modules/search/domain/errors/errors_result_search.dart';
import 'package:search_github/app/modules/search/presenter/states/search_state.dart';
import 'package:search_github/app/modules/search/presenter/store/search_store.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {
  Widget _buildList(List<ResultSearchEntitie> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var data = list[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.image),
          ),
          title: Text(data.nickName),
        );
      },
    );
  }

  Widget _buildError(Failure error) {
    if (error is EmptyList) {
      return const Center(
        child: Text('Nada encontrado'),
      );
    } else if (error is ErrorSearch) {
      return const Center(
        child: Text('Erro no github'),
      );
    } else {
      return const Center(
        child: Text('Erro interno'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Profile"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: TextField(
                onChanged: controller.setSearchText,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pesquise...",
                ),
              ),
            ),
            Expanded(
              child: Observer(builder: (_) {
                var state = controller.state;

                if (state is ErrorState) {
                  return _buildError(state.error);
                }

                if (state is StartState) {
                  return const Center(
                    child: Text('Digita alguma coisa...'),
                  );
                } else if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SuccessState) {
                  return _buildList(state.list);
                } else {
                  return Container();
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
