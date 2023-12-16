part of 'question_page_bloc.dart';

sealed class QuestionPageEvent extends Equatable {
  const QuestionPageEvent();

  @override
  List<Object> get props => [];
}

class GetQuestionsE extends QuestionPageEvent {
  final int category;
  final int amount;
  final String difficulty;
  final bool isBool;

  const GetQuestionsE(
      {required this.category,
      required this.amount,
      required this.difficulty,
      required this.isBool});

  @override
  List<Object> get props => [
        category,
        amount,
        difficulty,
        isBool,
      ];
}

final class ChangePageQuestionE extends QuestionPageEvent {
  final int index;

  const ChangePageQuestionE({required this.index});

  @override
  List<Object> get props => [index];
}

final class OptionClickedE extends QuestionPageEvent {
  final int answerIndex;

  const OptionClickedE({required this.answerIndex});

  @override
  List<Object> get props => [answerIndex];
}

final class ClearQuestionBlocListsE extends QuestionPageEvent {}
