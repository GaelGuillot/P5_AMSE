import 'package:flutter/material.dart';

import 'exercise.dart';

class Library {
  final List<Exercise> allExercises = [];

  void addExercise({
    required String title,
    required String description,
    required StatefulWidget widget,
  }) {
    var exercise = Exercise(allExercises.length, title, description, widget);

    allExercises.add(exercise);
  }
}
  
