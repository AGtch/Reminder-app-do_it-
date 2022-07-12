
import '../logic/cubit/cubit.dart';
import '../logic/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utilities/models/tasks_model.dart';
import '../widgets/shared_widgets.dart';

class NewTasksList extends StatefulWidget {
  final List<Task> list;
  const NewTasksList({required this.list});

  @override
  State<NewTasksList> createState() => _NewTasksListState();
}

class _NewTasksListState extends State<NewTasksList> {
  late List<Task> newList;
  late int len;

  @override
  void initState() {
    super.initState();
    newList = widget.list;
    len = newList.length;
    
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      newList = widget.list;
      len = newList.length;
    });
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final task = newList[index];
              AppCubit appCubit = AppCubit().get(context);

              return Dismissible(
                  key: Key(
                    task.id.toString(),
                  ),
                  onDismissed: (direction) {
                    appCubit.deleteTask(task);

                    setState(() {
                      newList.removeAt(index);
                    });
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${task.task}  dismissed'),
                      
                      ),
                    );
                  },
                  background: Container(color: Colors.red),
                  child: itemDesignInListView(newList[index]));
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[400],
              );
            },
            itemCount: len);
      },
    );
  }
}
