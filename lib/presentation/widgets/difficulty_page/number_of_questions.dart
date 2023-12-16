import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komodo_trivia/logic/cubit/difficulty_cubit/difficulty_cubit.dart';

class NumberOfQuestionsWidget extends StatelessWidget {
  const NumberOfQuestionsWidget({
    super.key,
    required this.title,
    required this.index,
    required this.difficultyIndex,
    required this.questionTypeIndex,
    required this.numberOfQuestions,
  });

  final String title;
  final int index;
  final int difficultyIndex;
  final int questionTypeIndex;
  final int numberOfQuestions;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DifficultyCubit>().changeDifficulty(
            difficulty: difficultyIndex,
            type: questionTypeIndex,
            numberOfQuestions: index);
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        height: 50,
        width: 60,
        decoration: BoxDecoration(
            color: index == numberOfQuestions
                ? const Color(0xff424045)
                : const Color(0xffFCFAFF),
            border: Border.all(color: const Color.fromARGB(255, 233, 233, 233)),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: index == numberOfQuestions
                    ? const Color(0xffFCFAFF)
                    : const Color(0xff424045)),
          ),
        ),
      ),
    );
  }
}
