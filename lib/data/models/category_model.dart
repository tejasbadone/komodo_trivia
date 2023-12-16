// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuizCategory extends Equatable {
  final int id;
  final String name;

  const QuizCategory({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory QuizCategory.fromMap(Map<String, dynamic> map) {
    return QuizCategory(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizCategory.fromJson(String source) =>
      QuizCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [id, name];
}
