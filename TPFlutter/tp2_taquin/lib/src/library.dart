import 'package:flutter/material.dart';

import 'exercise.dart';
import 'screens/exo2_screen.dart';

class Library {
  final List<Exercise> allExercises = [];

  void addExercise({
    required String title,
    required StatefulWidget widget,
  }) {
    var exercise = Exercise(allExercises.length, title, widget);

    allExercises.add(exercise);
  }
}
  
final libraryInstance = Library()
..addExercise(
  title: 'Exercice2', widget: Exo2Screen(title: 'Rotate/Scale image')
  );
