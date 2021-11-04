import 'package:async/async.dart';
import 'package:mobx/mobx.dart';

import '../../domain/user_cases/interfaces/search_by_text_user_case_interface.dart';
import '../states/search_state.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final ISearchByText _searchByText;
  CancelableOperation? cancelableOperation;

  @observable
  String searchText = '';

  @observable
  SearchState state = const StartState();

  _SearchStoreBase(this._searchByText) {
    reaction<String>((_) => searchText, (text) async {
      stateReaction(text, cancelableOperation);
    }, delay: 500);
  }

  @action
  setSearchText(String value) => searchText = value;

  @action
  setState(SearchState value) => state = value;

  Future stateReaction(
    String text, [
    CancelableOperation? cancelableOperation,
  ]) async {
    await cancelableOperation?.cancel();
    cancelableOperation =
        CancelableOperation<SearchState>.fromFuture(makeSearch(text));
    if (text.isEmpty) {
      setState(const StartState());
      return;
    }
    setState(const LoadingState());

    setState(
      await cancelableOperation.valueOrCancellation(const LoadingState()),
    );
  }

  Future<SearchState> makeSearch(String text) async {
    final result = await _searchByText(text);
    return result.fold(
      (failure) => ErrorState(failure),
      (list) => SuccessState(list),
    );
  }
}
