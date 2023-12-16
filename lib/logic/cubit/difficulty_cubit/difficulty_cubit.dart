import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'difficulty_state.dart';

List<String> difficulty = ['Easy', 'Medium', 'Hard'];
List<String> type = ['Multiple Choice', 'True/False'];
List<int> numberOfQuestions = [10, 20, 30, 40, 50];

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit()
      : super(const DifficultyState(
            difficulty: 0, type: 0, numberOfQuestions: 0));

  void changeDifficulty(
      {required int difficulty,
      required int type,
      required int numberOfQuestions}) {
    emit(DifficultyState(
        difficulty: difficulty,
        type: type,
        numberOfQuestions: numberOfQuestions));
  }
}
