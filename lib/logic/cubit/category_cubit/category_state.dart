part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitialS extends CategoryState {}

final class CategoryLoadingS extends CategoryState {}

final class CategorySuccessS extends CategoryState {
  final List<QuizCategory> categoryList;

  const CategorySuccessS({required this.categoryList});
  @override
  List<Object> get props => [categoryList];
}

final class CategoryErrorS extends CategoryState {
  final String errorString;

  const CategoryErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
