import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komodo_trivia/data/models/category_model.dart';
import 'package:komodo_trivia/data/repositories/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitialS());

  getCategories() async {
    emit(CategoryLoadingS());
    try {
      List<QuizCategory> categoryList;

      categoryList = await categoryRepository.getCategories();
      categoryList.shuffle();

      emit(CategorySuccessS(categoryList: categoryList));
    } catch (e) {
      emit(CategoryErrorS(errorString: e.toString()));
    }
  }
}
