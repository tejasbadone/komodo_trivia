import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc() : super(ScoreInitialS()) {
    on<ScoreDeatilsDataE>(_scoreHandler);
    on<ShowScoreDetailsE>(_showScoreHandler);
    on<ScoreClearListsE>(_clearListsHandler);
    on<GetFinalScoreE>(_getFinalScoreHandler);
  }
  List<String> userAnswerList = [];
  List<String> actualAnswerList = [];
  List<String> questionsList = [];
  List<String> questionsNumberList = [];
  List<String> options = [];

  void _scoreHandler(ScoreDeatilsDataE event, emit) {
    options = event.options;
    String userAnswer =
        event.userAnswer < 0 ? 'Not Selected' : options[event.userAnswer];
    String actualAnswer = event.actualAnswer;

    userAnswerList.add(userAnswer);
    actualAnswerList.add(actualAnswer);
    questionsList.add(event.question);
    questionsNumberList.add(event.questionNumber);
  }

  void _clearListsHandler(event, emit) {
    userAnswerList.clear();
    actualAnswerList.clear();
    questionsList.clear();
    questionsNumberList.clear();
  }

  List<int> userScoreMethod() {
    int userScore = 0;
    int length = actualAnswerList.length;
    for (int i = 0; i < actualAnswerList.length; i++) {
      if (actualAnswerList[i] == userAnswerList[i]) {
        userScore++;
      }
    }
    return [userScore, length];
  }

  void _getFinalScoreHandler(event, emit) {
    int userScore = userScoreMethod()[0];

    emit(
        ShowFinalScoreS(userScore: userScore, outOff: actualAnswerList.length));
  }

  void _showScoreHandler(event, emit) {
    emit(ShowScoreDetailsS(
        options: options,
        userAnswerList: userAnswerList,
        actualAnswerList: actualAnswerList,
        questionsList: questionsList,
        questionNumber: questionsNumberList));
  }
}
