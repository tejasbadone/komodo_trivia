import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komodo_trivia/logic/bloc/question_page/question_page_bloc.dart';
import 'package:komodo_trivia/logic/bloc/score/score_bloc.dart';
import 'package:komodo_trivia/presentation/widgets/common/white_custom_button.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.07),
              Image.asset(
                'assets/images/score.png',
                height: 170,
                width: 170,
              ),
              const SizedBox(height: 30),
              BlocBuilder<ScoreBloc, ScoreState>(
                builder: (context, state) {
                  List<int> scoreData =
                      context.read<ScoreBloc>().userScoreMethod();
                  if (state is ShowFinalScoreS) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.userScore.toString(),
                          style: const TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: Color(0xff019D91)),
                        ),
                        Text(
                          '/${state.outOff}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        scoreData[0].toString(),
                        style: const TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            color: Color(0xff019D91)),
                      ),
                      Text(
                        '/${scoreData[1]}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Score',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              Row(
                children: [
                  Expanded(
                    child: WhiteCustomButton(
                        buttonTitle: 'Play Again',
                        icon: Icons.replay_rounded,
                        onPressed: () {
                          context.goNamed('home-page');
                          context.read<ScoreBloc>().add(ScoreClearListsE());
                          context
                              .read<QuestionPageBloc>()
                              .add(ClearQuestionBlocListsE());
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: WhiteCustomButton(
                        buttonTitle: 'Details',
                        icon: Icons.chevron_right_rounded,
                        onPressed: () {
                          context.read<ScoreBloc>().add(ShowScoreDetailsE());
                          context.pushNamed('score-details-page');
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
