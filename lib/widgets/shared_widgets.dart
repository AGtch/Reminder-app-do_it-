import 'package:flutter/material.dart';

import '../utilities/models/tasks_model.dart';

Widget defaultTextForm({
  GlobalKey<FormState>? formKey,
  required String hintText,
  required Icon prefixIcon,
  Icon? suffixIcon,
  TextInputType? textInputType,
  required ValueChanged onFieldSubmitted,
  required TextEditingController textEditingController,
  GestureTapCallback? onTap,
  int? maxLines,
  bool readOnly = false,
  required FormFieldValidator<String> validator,
}) {
  return TextFormField(
    decoration: InputDecoration(
      hintText: hintText,
      border: const OutlineInputBorder(),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    ),
    key: formKey,
    keyboardType: textInputType,
    onFieldSubmitted: onFieldSubmitted,
    controller: textEditingController,
    maxLines: maxLines,
    readOnly: readOnly,
    onTap: onTap,
    validator: validator,
  );
}

Widget defaultButton(
    {required Widget widget,
    required VoidCallback onPressed,
    GlobalKey? globalKey,
    Color? color}) {
  return MaterialButton(
    key: globalKey,
    color: color,
    onPressed: onPressed,
    focusElevation: 16,
    height: 60,
    minWidth: 260,
    elevation: 26,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: widget,
  );
}

Widget itemDesignInListView(Task task) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            task.time,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              task.task,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              task.date,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
