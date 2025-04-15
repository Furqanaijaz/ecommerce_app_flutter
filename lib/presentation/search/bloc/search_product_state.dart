abstract class SearchProductState {}

class SearchProductInitialState extends SearchProductState {}

class SearchProductLoadingState extends SearchProductState {}

class SearchProductLoadedState extends SearchProductState {
  final List<dynamic> products;

  SearchProductLoadedState({required this.products});
}

class SearchProductErrorState extends SearchProductState {
  final String error;

  SearchProductErrorState({required this.error});
}
