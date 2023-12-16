part of 'question_page_bloc.dart';

sealed class QuestionPageState extends Equatable {
  const QuestionPageState();

  @override
  List<Object> get props => [];
}

final class QuestionPageInitialS extends QuestionPageState {}

final class QuestionPageLoadingS extends QuestionPageState {}

final class QuestionPageSuccessS extends QuestionPageState {
  final List<Question> questionsList;
  const QuestionPageSuccessS({required this.questionsList});
  @override
  List<Object> get props => [questionsList];
}

final class QuestionPageChangeQuestionS extends QuestionPageState {
  final int index;
  final int answerIndex;
  final Question question;
  final List<String> options;

  const QuestionPageChangeQuestionS({
    required this.question,
    required this.index,
    required this.options,
    required this.answerIndex,
  });
  @override
  List<Object> get props => [question, index, options, answerIndex];
}

final class QuestionPageErrorS extends QuestionPageState {
  final String errrString;

  const QuestionPageErrorS({required this.errrString});
  @override
  List<Object> get props => [errrString];
}

final class QuestionPageSubmitted extends QuestionPageState {}
