// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String question;
  final String answer;
  final List<String> options;

  const Question(
      {required this.question, required this.answer, required this.options});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
      'options': options,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        question: map['question'] as String,
        answer: map['correct_answer'] as String,
        options: List<String>.from(
          (map['incorrect_answers'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [question, answer, options];
}
