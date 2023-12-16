import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komodo_trivia/data/models/category_model.dart';
import 'package:komodo_trivia/logic/bloc/question_page/question_page_bloc.dart';
import 'package:komodo_trivia/logic/cubit/difficulty_cubit/difficulty_cubit.dart';
import 'package:komodo_trivia/presentation/widgets/common/black_custom_button.dart';
import 'package:komodo_trivia/presentation/widgets/difficulty_page/custom_container.dart';
import 'package:komodo_trivia/presentation/widgets/difficulty_page/number_of_questions.dart';
import 'package:komodo_trivia/presentation/widgets/difficulty_page/type_widget.dart';

class DifficultyPage extends StatelessWidget {
  final QuizCategory category;

  const DifficultyPage({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15)
                .copyWith(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: UniqueKey(),
                  child: Image.asset(
                    'assets/images/${category.id}.png',
                    height: 300,
                    width: 200,
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<DifficultyCubit, DifficultyState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Choose number of questions',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                itemCount: numberOfQuestions.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return NumberOfQuestionsWidget(
                                      title:
                                          numberOfQuestions[index].toString(),
                                      index: index,
                                      difficultyIndex: state.difficulty,
                                      questionTypeIndex: state.type,
                                      numberOfQuestions:
                                          state.numberOfQuestions);
                                }),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Choose difficulty level',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                itemCount: difficulty.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CustomContainer(
                                      title: difficulty[index],
                                      index: index,
                                      difficultyIndex: state.difficulty,
                                      questionTypeIndex: state.type,
                                      numberOfQuestions:
                                          state.numberOfQuestions);
                                }),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Choose question type',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: TypeWidget(
                                    title: type[0],
                                    index: 0,
                                    questionTypeIndex: state.type,
                                    difficultyIndex: state.difficulty,
                                    numberOfQuestions: state.numberOfQuestions),
                              ),
                              Expanded(
                                child: TypeWidget(
                                    title: type[1],
                                    index: 1,
                                    questionTypeIndex: state.type,
                                    difficultyIndex: state.difficulty,
                                    numberOfQuestions: state.numberOfQuestions),
                              ),
                            ],
                          ),
                          const Spacer(flex: 1),
                          BlackCustomButton(
                            title: 'Start',
                            onPressed: () {
                              context.pushNamed('question-page',
                                  extra: category);

                              context.read<QuestionPageBloc>().add(
                                  GetQuestionsE(
                                      category: category.id,
                                      difficulty: difficulty[state.difficulty],
                                      amount: numberOfQuestions[
                                          state.numberOfQuestions],
                                      isBool: type[state.type] == type[1]
                                          ? true
                                          : false));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
