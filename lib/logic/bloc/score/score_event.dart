part of 'score_bloc.dart';

sealed class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

final class ScoreDeatilsDataE extends ScoreEvent {
  final List<String> options;
  final int userAnswer;
  final String actualAnswer;
  final String question;
  final String questionNumber;

  const ScoreDeatilsDataE({
    required this.options,
    required this.userAnswer,
    required this.question,
    required this.questionNumber,
    required this.actualAnswer,
  });

  @override
  List<Object> get props =>
      [options, userAnswer, actualAnswer, question, questionNumber];
}

final class ShowScoreDetailsE extends ScoreEvent {}

final class ScoreClearListsE extends ScoreEvent {}

final class GetFinalScoreE extends ScoreEvent {}
