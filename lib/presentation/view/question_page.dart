import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:komodo_trivia/core/utils.dart';
import 'package:komodo_trivia/data/models/category_model.dart';
import 'package:komodo_trivia/logic/bloc/question_page/question_page_bloc.dart';
import 'package:komodo_trivia/logic/bloc/score/score_bloc.dart';
import 'package:komodo_trivia/logic/cubit/difficulty_cubit/difficulty_cubit.dart';
import 'package:komodo_trivia/presentation/widgets/common/black_custom_button.dart';
import 'package:komodo_trivia/presentation/widgets/common/error_widget.dart';
import 'package:komodo_trivia/presentation/widgets/question_page/option_widget.dart';
import 'package:komodo_trivia/presentation/widgets/question_page/questions_loading_widget.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key, required this.category});
  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final CountDownController _timerController = CountDownController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: BlocConsumer<QuestionPageBloc, QuestionPageState>(
          listener: (context, state) {
            if (state is QuestionPageSubmitted) {
              context.pushReplacementNamed('score-page');
              context.read<ScoreBloc>().add(GetFinalScoreE());
            }
          },
          builder: (context, state) {
            if (state is QuestionPageLoadingS) {
              return const QuestionsLoadingWidget();
            }

            if (state is QuestionPageChangeQuestionS) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${state.index + 1}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                      CircularCountDownTimer(
                          width: 45,
                          height: 45,
                          duration: 10,
                          isReverse: true,
                          isReverseAnimation: true,
                          strokeWidth: 5,
                          controller: _timerController,
                          onComplete: () {
                            context.read<QuestionPageBloc>().add(
                                ChangePageQuestionE(index: state.index + 1));
                            _timerController.restart();

                            context.read<ScoreBloc>().add(ScoreDeatilsDataE(
                                  options: state.options,
                                  userAnswer: state.answerIndex - 1,
                                  question: state.question.question,
                                  questionNumber: '${state.index + 1}',
                                  actualAnswer: state.question.answer,
                                ));
                          },
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          fillColor: const Color.fromARGB(255, 233, 233, 233),
                          backgroundColor: const Color(0xffFAFAFA),
                          ringColor: const Color(0xff424045)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    decodeString(state.question.question),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 15),
                  LayoutGrid(
                    columnSizes: [1.fr, 1.fr],
                    rowSizes: const [auto, auto],
                    rowGap: 10,
                    columnGap: 10,
                    children: [
                      for (int i = 1; i <= state.options.length; i++)
                        OptionWidget(
                          clickedIndex: state.answerIndex,
                          optionText: decodeString(state.options[i - 1]),
                          questionIndex: i,
                          onPressed: () {
                            context
                                .read<QuestionPageBloc>()
                                .add(OptionClickedE(answerIndex: i));
                          },
                        ),
                    ],
                  ),
                  const Spacer(),
                  Hero(
                    tag: UniqueKey(),
                    child: BlackCustomButton(
                      title: 'Submit',
                      onPressed: () {
                        context
                            .read<QuestionPageBloc>()
                            .add(ChangePageQuestionE(index: state.index + 1));

                        _timerController.restart();

                        context.read<ScoreBloc>().add(ScoreDeatilsDataE(
                              options: state.options,
                              userAnswer: state.answerIndex - 1,
                              question: state.question.question,
                              questionNumber: '${state.index + 1}',
                              actualAnswer: state.question.answer,
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                  ),
                ],
              );
            }

            if (state is QuestionPageErrorS) {
              if (state.errrString == '1') {
                return const CustomErrorWidget(
                  assetName: 'no_data_found.json',
                  errorString:
                      "Oops! It seems there aren't enough questions. Please consider adjusting the number, difficulty level, or question type and try again",
                );
              }
              if (state.errrString == '3' ||
                  state.errrString == '4' ||
                  state.errrString == '5') {
                return const CustomErrorWidget(
                  assetName: 'server-error.json',
                  errorString:
                      "Oops! Too many requests at once. Please wait for 5 seconds!",
                );
              }
              if (state.errrString == 'socketerror') {
                return BlocBuilder<DifficultyCubit, DifficultyState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const CustomErrorWidget(
                            assetName: 'server-error.json',
                            errorString:
                                "Oops! We're having trouble connecting to the server. Please ensure your internet connection is stable and try again."),
                        BlackCustomButton(
                            title: 'Try again',
                            onPressed: () {
                              context.read<QuestionPageBloc>().add(
                                  GetQuestionsE(
                                      category: category.id,
                                      difficulty: difficulty[state.difficulty],
                                      amount: numberOfQuestions[
                                          state.numberOfQuestions],
                                      isBool: type[state.type] == type[1]
                                          ? true
                                          : false));
                            })
                      ],
                    );
                  },
                );
              } else {
                return const CustomErrorWidget(
                  assetName: 'server-error.json',
                  errorString:
                      'Oops! Error connecting to the server, please try again!',
                );
              }
            }

            return const Text('else');
          },
        ),
      ),
    );
  }
}
