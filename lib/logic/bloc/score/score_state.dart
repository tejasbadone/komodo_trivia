part of 'score_bloc.dart';

sealed class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

final class ScoreInitialS extends ScoreState {}

final class ShowScoreDetailsS extends ScoreState {
  final List<String> options;
  final List<String> userAnswerList;
  final List<String> actualAnswerList;
  final List<String> questionsList;
  final List<String> questionNumber;

  const ShowScoreDetailsS({
    required this.options,
    required this.userAnswerList,
    required this.actualAnswerList,
    required this.questionsList,
    required this.questionNumber,
  });

  @override
  List<Object> get props => [
        options,
        userAnswerList,
        actualAnswerList,
        questionsList,
        questionNumber
      ];
}

final class ShowFinalScoreS extends ScoreState {
  final int userScore;
  final int outOff;

  const ShowFinalScoreS({required this.userScore, required this.outOff});
  @override
  List<Object> get props => [userScore, outOff];
}
