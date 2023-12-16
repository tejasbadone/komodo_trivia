import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komodo_trivia/data/models/question_model.dart';
import 'package:komodo_trivia/data/repositories/questions_repository.dart';

part 'question_page_event.dart';
part 'question_page_state.dart';

class QuestionPageBloc extends Bloc<QuestionPageEvent, QuestionPageState> {
  final QuestionsRepository questionsRepository;
  List<Question> questionsList = [];
  List<String> options = [];
  List<String> answers = [];

  QuestionPageBloc(this.questionsRepository) : super(QuestionPageInitialS()) {
    on<GetQuestionsE>(getQuestionHandler);
    on<ChangePageQuestionE>(changePageQuestionHandler);
    on<OptionClickedE>(optionClickedHandler);
    on<ClearQuestionBlocListsE>(clearQuestionBlocListsHandler);
  }

  Future<void> getQuestionHandler(event, emit) async {
    emit(QuestionPageLoadingS());
    try {
      questionsList = await questionsRepository.getQuestions(
          category: event.category,
          amount: event.amount,
          difficulty: event.difficulty,
          isBool: event.isBool);

      final question = questionsList[0];
      List<String> options = question.options;

      options.add(question.answer);
      options.shuffle();

      emit(QuestionPageSuccessS(questionsList: questionsList));
      emit(QuestionPageChangeQuestionS(
          answerIndex: -1,
          question: questionsList[0],
          index: 0,
          options: options));
    } catch (e) {
      emit(QuestionPageErrorS(errrString: e.toString()));
    }
  }

  void _prepareState(
      {required int answerIndex,
      required int index,
      required List<String> options,
      required emit}) {
    emit(QuestionPageChangeQuestionS(
      answerIndex: answerIndex,
      question: questionsList[index],
      index: index,
      options: options,
    ));
  }

  void optionClickedHandler(OptionClickedE event, emit) {
    final currentState = state as QuestionPageChangeQuestionS;

    _prepareState(
        answerIndex: event.answerIndex,
        index: currentState.index,
        options: currentState.options,
        emit: emit);
  }

  void changePageQuestionHandler(event, emit) async {
    if (event.index >= questionsList.length) {
      emit(QuestionPageSubmitted());
    } else {
      final question = questionsList[event.index];
      options = question.options;

      options.add(question.answer);
      options.shuffle();
      _prepareState(
          answerIndex: -1, index: event.index, options: options, emit: emit);
    }
  }

  void clearQuestionBlocListsHandler(event, emit) {
    questionsList.clear();
    options.clear();
    answers.clear();
  }

  List<Question> get questions {
    if (state is QuestionPageSuccessS) {
      return questionsList;
    }
    return [];
  }
}
