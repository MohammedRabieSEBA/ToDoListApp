import 'package:flutter/material.dart';
import 'package:todolist/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //get user input
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new Task",
            ),
          ),

          // buttons --> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Save Button
              MyButton(
                text: 'Save',
                onPressed: onSave,
              ),
              // Space between two box of 'Save' and 'Cancel'
              const SizedBox(
                width: 5,
              ),
              // Cancel Button
              MyButton(
                text: 'Cancel',
                onPressed: onCancel,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
