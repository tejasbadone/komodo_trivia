part of 'difficulty_cubit.dart';

class DifficultyState extends Equatable {
  final int difficulty;
  final int type;
  final int numberOfQuestions;
  const DifficultyState(
      {required this.difficulty,
      required this.type,
      required this.numberOfQuestions});

  @override
  List<Object> get props => [difficulty, type, numberOfQuestions];
}
