import 'package:do_it/constants/colors.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

import '../logic/cubit/states.dart';

import '../logic/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_tasks_list.dart';
import '../utilities/dao/dao.dart';
import '../utilities/database/task_database.dart';
import '../utilities/models/tasks_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../widgets/shared_widgets.dart';

class TaskScreens extends StatefulWidget {
  const TaskScreens({Key? key}) : super(key: key);

  @override
  State<TaskScreens> createState() => _TaskScreensState();
}

class _TaskScreensState extends State<TaskScreens> {
  int length = 0;

  List<Task>? allTasksInDatabase = [];

  var formKey = GlobalKey<FormState>();

  var taskController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();
  TimeOfDay? pickedTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit appCubit = AppCubit().get(context);
          if (state is InsertNewTaskFormDatabaseState ||
              state is CreateDatabaseState) {
            appCubit.getAllTasks().then((value) {
              allTasksInDatabase = value;
            });
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Do it",
              ),
              backgroundColor: AppColors.primaryColor,
            ),
            bottomNavigationBar: BottomAppBar(
              notchMargin: 216.0,
              elevation: 20.0,
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.more_vert), onPressed: () {}),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              elevation: 30.0,
              onPressed: () {
                showBottomSheet(
                  enableDrag: true,
                  elevation: 200.0,
                  context: context,
                  backgroundColor: Colors.grey[300],
                  builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            const Center(
                              child: Text(
                                "Enter The Task",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 46,
                            ),
                            defaultTextForm(
                              hintText: "Enter your task",
                              prefixIcon: const Icon(Icons.title),
                              onFieldSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  taskController.text = value;
                                }
                              },
                              textEditingController: taskController,
                              maxLines: null,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'task is empty!';
                                }
                                return null;
                              },
                            ), //defaultTextForm ( task text form field)

                            const SizedBox(
                              height: 26,
                            ),

                            defaultTextForm(
                              hintText: "Pick a time",
                              prefixIcon: const Icon(Icons.access_time),
                              onFieldSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  timeController.text = value;
                                }
                              },
                              textEditingController: timeController,
                              maxLines: 1,
                              textInputType: TextInputType.datetime,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'time is empty';
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  pickedTime = value;
                                  timeController.text = value!.format(context);
                                });
                              },
                            ), //defaultTextForm ( time text form field)
                            const SizedBox(
                              height: 26,
                            ),

                            defaultTextForm(
                                hintText: "Pick a date",
                                prefixIcon: const Icon(Icons.date_range),
                                onFieldSubmitted: (value) {
                                  dateController.text = value;
                                },
                                textEditingController: dateController,
                                maxLines: 1,
                                textInputType: TextInputType.datetime,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'date is empty';
                                  } else {
                                    dateController.text = value;
                                  }
                                  return null;
                                },
                                onTap: () {
                                  var dateNow = DateTime.now();
                                  var lastDate = DateTime(dateNow.year,
                                      dateNow.month, dateNow.day + 30);

                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: dateNow,
                                    lastDate: lastDate,
                                  ).then((value) => dateController.text =
                                      DateFormat.yMMMd().format(value!));
                                }), //defaultTextForm ( date text form field)

                            const SizedBox(
                              height: 38,
                            ),
                            defaultButton(
                              widget: const Text(
                                "Add Task",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: AppColors.primaryColor,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  Task task = Task(
                                      task: taskController.text,
                                      date: dateController.text,
                                      time: timeController.text);

                                  appCubit.insertNewTaskInDatabase(task);
                                  FlutterAlarmClock.createAlarm(
                                      pickedTime!.hour.toInt(),
                                      pickedTime!.minute.toInt());
                                  print("-------------------------------");
                                  print(pickedTime!.hour.toString());
                                  print(pickedTime!.minute.toString());
                                  print("-------------------------------");

                                  Navigator.pop(context);

                                  taskController.clear();
                                  timeController.clear();
                                  dateController.clear();
                                } // if validation
                              },
                            ),
                            SizedBox(
                              height: 80.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ); // BottomSheetBar
              }, // onPressed()
              child: const Icon(Icons.add),
            ),
            body: (allTasksInDatabase!.isEmpty)
                ? const Center(
                    child: Text("There are no Tasks yat"),
                  )
                : NewTasksList(list: allTasksInDatabase!),
          );
        },
      ),
    );
  }
}
