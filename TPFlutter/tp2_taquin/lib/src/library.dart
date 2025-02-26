import 'package:flutter/material.dart';

import 'exercise.dart';
import 'screens/exo2_screen.dart';
import 'screens/exo4_screen.dart';

class Library {
  final List<Exercise> allExercises = [];

  void addExercise({
    required String title,
    required String description,
    required Widget widget,
  }) {
    var exercise = Exercise(allExercises.length, title, description, widget);

    allExercises.add(exercise);
  }

  Exercise getExercise(int id){
    return allExercises[id];
  }
}
  
final libraryInstance = Library()
..addExercise(
  title: 'Exercice2', description:'Rotate/Scale image', widget: Exo2Screen()
  )
..addExercise(
  title: 'Exercice4', description: 'Display a tile as a cropped image', widget: Exo4Screen()
  );
