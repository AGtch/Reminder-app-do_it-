import 'package:flutter/widgets.dart';

@immutable
abstract class AppState {}

class InitialState extends AppState {}

class CreateDatabaseState extends AppState {}

class GetAllTaskFormDatabaseState extends AppState {}
class InsertNewTaskFormDatabaseState extends AppState {}
class DeleteTaskFormDatabaseState extends AppState {}
