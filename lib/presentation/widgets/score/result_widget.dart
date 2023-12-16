import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.wrongAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });
  final String questionNumber;
  final String question;
  final String wrongAnswer;
  final String correctAnswer;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question $questionNumber',
          style: const TextStyle(
              fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600),
        ),
        Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        isCorrect
            ? ResultContainer(
                icon: Icons.check_circle_outline,
                iconColor: Colors.green,
                content: correctAnswer,
              )
            : LayoutGrid(
                columnSizes: [1.fr, 1.fr],
                rowSizes: const [auto],
                columnGap: 14,
                children: [
                  ResultContainer(
                    icon: Icons.cancel_outlined,
                    iconColor: Colors.red,
                    content: wrongAnswer,
                  ),
                  ResultContainer(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    content: correctAnswer,
                  ),
                ],
              ),
        const SizedBox(height: 16),
        const Divider(
          thickness: 0.3,
          indent: 35,
          endIndent: 35,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.content,
  });

  final IconData icon;
  final Color iconColor;
  final String content;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xffFCFAFF),
            border: Border.all(color: iconColor),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff424045),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
