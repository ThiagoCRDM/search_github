import '../../domain/entities/search_entitie.dart';
import '../../domain/errors/errors_result_search.dart';

abstract class SearchState {}

class StartState implements SearchState {
  const StartState();
}

class LoadingState implements SearchState {
  const LoadingState();
}

class ErrorState implements SearchState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements SearchState {
  final List<ResultSearchEntitie> list;
  const SuccessState(this.list);
}
